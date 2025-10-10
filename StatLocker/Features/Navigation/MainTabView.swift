//
//  MainTabView.swift
//  StatLocker
//
//  Main tab navigation with Home, Stats, Skills, and Recruiting tabs.
//  FAB overlay positioned between Stats and Skills per product requirements.
//

import SwiftUI
import Foundation

struct MainTabView: View {
    let profile: AthleteProfile
    let teamInfo: TeamInfo
    @State private var selectedTab: Tab = .home
    
    enum Tab: Int {
        case home = 0
        case stats = 1
        case skills = 2
        case recruiting = 3
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Tab View
            TabView(selection: $selectedTab) {
                DashboardView(profile: profile, teamInfo: teamInfo)
                    .tabItem {
                        Label("Locker", systemImage: "house.fill")
                    }
                    .tag(Tab.home)
                
                StatsPlaceholderView()
                    .tabItem {
                        Label("Stats", systemImage: "chart.line.uptrend.xyaxis")
                    }
                    .tag(Tab.stats)
                
                SkillsPlaceholderView()
                    .tabItem {
                        Label("Skills", systemImage: "target")
                    }
                    .tag(Tab.skills)
                
                RecruitingPlaceholderView()
                    .tabItem {
                        Label("Recruiting", systemImage: "graduationcap.fill")
                    }
                    .tag(Tab.recruiting)
            }
            .tint(Theme.Colors.primary)
            .onChange(of: selectedTab) { oldValue, newValue in
                print("[StatLocker][Navigation] Tab changed to: \(newValue)")
            }
            .onAppear {
                setupTabBarAppearance()
            }
            
            // FAB overlay centered above tab bar
            FABButton(profile: profile)
                .padding(.bottom, 32) // Position above tab bar with breathing room
                .accessibilityLabel("Log game")
                .accessibilityHint("Opens game logging options")
        }
        // Allow system preference to control theme
    }
    
    // MARK: - Tab Bar Appearance
    
    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        // Use adaptive background color that responds to light/dark mode
        appearance.backgroundColor = UIColor(named: "BackgroundPrimary") ?? UIColor.systemBackground
        
        // Set tab bar colors
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        
        print("[StatLocker][Navigation] Tab bar appearance configured for adaptive theme")
    }
}

#Preview {
    let sampleProfile = AthleteProfile(
        userId: "123",
        firstName: "Jordan",
        lastName: "Smith",
        email: "jordan@example.com",
        sport: "lacrosse",
        teamGender: "boys",
        gradYear: 2026,
        level: "Varsity",
        position: "Goalie",
        aiTone: "Mentor",
        seasonGoals: [],
        onboardingCompleted: true,
        createdAt: Date()
    )
    
    let sampleTeam = TeamInfo(
        hsTeamName: "Westlake Warriors",
        hsCity: "Austin",
        hsState: "TX",
        hasClubTeam: false,
        clubOrganization: nil,
        clubTeamName: nil,
        clubCity: nil,
        clubState: nil
    )
    
    MainTabView(profile: sampleProfile, teamInfo: sampleTeam)
}

