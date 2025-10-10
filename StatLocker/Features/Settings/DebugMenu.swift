//
//  DebugMenu.swift
//  StatLocker
//
//  Debug menu for testing and development.
//  Remove or feature-flag for production.
//

import SwiftUI
import FirebaseAuth

struct DebugMenu: View {
    @Environment(AuthService.self) private var authService
    @State private var showConfirm = false
    
    var body: some View {
        List {
            Section("Developer Tools") {
                Button(role: .destructive) {
                    showConfirm = true
                } label: {
                    Label("Sign Out", systemImage: "rectangle.portrait.and.arrow.right")
                }
            }
            
            Section("Data Management") {
                Button(role: .destructive) {
                    clearOnboardingProgress()
                } label: {
                    Label("Clear Onboarding Progress", systemImage: "trash")
                }
            }
        }
        .navigationTitle("Debug Menu")
        .alert("Sign Out?", isPresented: $showConfirm) {
            Button("Cancel", role: .cancel) { }
            Button("Sign Out", role: .destructive) {
                signOut()
            }
        } message: {
            Text("This will return you to the Welcome screen")
        }
    }
    
    private func signOut() {
        Task {
            do {
                try await authService.signOut()
                print("[StatLocker][Debug] User signed out successfully")
            } catch {
                print("[StatLocker][Debug] Error signing out: \(error)")
            }
        }
    }
    
    private func clearOnboardingProgress() {
        // Clear all onboarding progress from UserDefaults
        if let userId = authService.currentUser?.uid {
            UserDefaults.standard.removeObject(forKey: "onboarding_progress_\(userId)")
            print("[StatLocker][Debug] Cleared onboarding progress for user: \(userId)")
        }
    }
}

#Preview {
    NavigationStack {
        DebugMenu()
            .environment(AuthService())
    }
}

