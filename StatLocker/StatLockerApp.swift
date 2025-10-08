//
//  StatLockerApp.swift
//  StatLocker
//
//  Created by Darien Brothers on 10/6/25.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import GoogleSignIn

// MARK: - App Delegate for Firebase Setup

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Configure Firebase at app launch
        FirebaseApp.configure()
        print("[StatLocker][Boot] Firebase configured")
        return true
    }
}

// MARK: - App Entry

@main
struct StatLockerApp: App {
    // Register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    private let flags = FeatureFlags.load()
    
    var body: some Scene {
        WindowGroup {
            RootCoordinatorView()
                .onAppear {
                    print("[StatLocker][Boot] App launched — iOS 17+ SwiftUI")
                }
                .onOpenURL { url in
                    // Handle Google Sign-In redirect
                    GIDSignIn.sharedInstance.handle(url)
                    print("[StatLocker][Auth] Handled URL redirect: \(url)")
                }
        }
    }
}

// MARK: - Root Coordinator View

struct RootCoordinatorView: View {
    @State private var authService = AuthService()
    @State private var showOnboarding = false
    @State private var showDashboard = false
    @State private var isCheckingProfile = false
    @State private var athleteProfile: AthleteProfile?
    @State private var teamInfo: TeamInfo?
    
    var body: some View {
        Group {
            if authService.isAuthenticated {
                if isCheckingProfile {
                    // Loading state while checking profile
                    VStack {
                        ProgressView()
                        Text("Loading your Locker...")
                            .font(Theme.Typography.body(14))
                            .foregroundStyle(Theme.Colors.muted)
                            .padding(.top, Theme.Spacing.sm)
                    }
                } else if showOnboarding {
                    if let user = authService.currentUser {
                        OnboardingView(user: user) {
                            // Onboarding completed
                            Task {
                                await checkProfileStatus()
                            }
                        }
                    }
                } else if showDashboard {
                    if let profile = athleteProfile, let team = teamInfo {
                        DashboardView(profile: profile, teamInfo: team)
                    } else {
                        // Fallback loading state
                        VStack {
                            ProgressView()
                            Text("Loading Dashboard...")
                                .font(Theme.Typography.body(14))
                                .foregroundStyle(Theme.Colors.muted)
                                .padding(.top, Theme.Spacing.sm)
                        }
                    }
                } else {
                    // Default to checking profile
                    ProgressView()
                        .onAppear {
                            Task {
                                await checkProfileStatus()
                            }
                        }
                }
            } else {
                WelcomeScreen()
                    .environment(authService)
            }
        }
        .onChange(of: authService.currentUser) { oldValue, newValue in
            if newValue != nil {
                Task {
                    await checkProfileStatus()
                }
            } else {
                // User logged out
                showOnboarding = false
                showDashboard = false
                print("[StatLocker][Auth] User logged out, returning to welcome")
            }
        }
    }
    
    // MARK: - Profile Checking
    
    /// Check if user has completed onboarding
    @MainActor
    private func checkProfileStatus() async {
        guard let user = authService.currentUser else {
            print("[StatLocker][Boot] No authenticated user")
            return
        }
        
        isCheckingProfile = true
        print("[StatLocker][Boot] Checking profile for user: \(user.uid)")
        
        do {
            let db = Firestore.firestore()
            let profileDoc = try await db.collection("users")
                .document(user.uid)
                .collection("profile")
                .document("data")
                .getDocument()
            
            if profileDoc.exists {
                let profile = try profileDoc.data(as: AthleteProfile.self)
                
                if profile.onboardingCompleted {
                    // Fetch team info for dashboard
                    do {
                        let team = try await ProfileService.shared.fetchTeamInfo(for: user.uid)
                        athleteProfile = profile
                        teamInfo = team
                        showOnboarding = false
                        showDashboard = true
                        print("[StatLocker][Boot] Profile and team info loaded, showing dashboard")
                    } catch {
                        print("[StatLocker][Boot] Error loading team info: \(error)")
                        // Still show dashboard with profile only
                        athleteProfile = profile
                        showOnboarding = false
                        showDashboard = true
                        print("[StatLocker][Boot] Profile found, showing dashboard (team info missing)")
                    }
                } else {
                    showOnboarding = true
                    showDashboard = false
                    print("[StatLocker][Boot] Incomplete profile, showing onboarding")
                }
            } else {
                // No profile exists - check UserDefaults for partial progress
                showOnboarding = true
                showDashboard = false
                print("[StatLocker][Boot] No profile found, showing onboarding")
            }
            
            isCheckingProfile = false
            
        } catch {
            print("[StatLocker][Boot] Error checking profile: \(error.localizedDescription)")
            // Default to onboarding on error
            showOnboarding = true
            showDashboard = false
            isCheckingProfile = false
        }
    }
}