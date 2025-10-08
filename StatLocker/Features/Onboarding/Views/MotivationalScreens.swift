//
//  MotivationalScreens.swift
//  StatLocker
//
//  Motivational/transition screens for onboarding flow.
//  Includes Welcome Journey, Goals Locked In, and Almost There screens.
//

import SwiftUI

// MARK: - Welcome Journey View (After Step 1)

struct WelcomeJourneyView: View {
    let name: String
    let onContinue: () -> Void
    
    var body: some View {
        ZStack {
            // Blue gradient background
            LinearGradient(
                colors: [Theme.Colors.primary, Color(hex: "#3730A3")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: Theme.Spacing.xl) {
                Spacer()
                
                // SF Symbol illustration
                Image(systemName: "figure.run")
                    .font(.system(size: 80))
                    .foregroundStyle(.white.opacity(0.9))
                
                VStack(spacing: Theme.Spacing.md) {
                    Text("Welcome to your journey, \(name)")
                        .font(Theme.Typography.headline(28))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                    
                    Text("Every game is a chance to improve. Let's build your athletic story together.")
                        .font(Theme.Typography.body(17))
                        .foregroundStyle(.white.opacity(0.9))
                        .multilineTextAlignment(.center)
                }
                
                Spacer()
                
                WhiteButton(title: "Let's Go", action: onContinue)
                    .padding(.horizontal, Theme.Spacing.xl)
            }
        }
        .onAppear {
            print("[StatLocker][Onboarding] Welcome Journey screen appeared for \(name)")
        }
    }
}

// MARK: - Goals Locked In View (After Step 7)

struct GoalsLockedInView: View {
    let name: String
    let onContinue: () -> Void
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Theme.Colors.primary, Color(hex: "#3730A3")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: Theme.Spacing.xl) {
                Spacer()
                
                Image(systemName: "target")
                    .font(.system(size: 80))
                    .foregroundStyle(.white.opacity(0.9))
                
                VStack(spacing: Theme.Spacing.md) {
                    Text("You're locked in, \(name)")
                        .font(Theme.Typography.headline(28))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                    
                    Text("Small goals = big wins. Your season targets will keep you focused and motivated.")
                        .font(Theme.Typography.body(17))
                        .foregroundStyle(.white.opacity(0.9))
                        .multilineTextAlignment(.center)
                }
                
                Spacer()
                
                WhiteButton(title: "Keep Going", action: onContinue)
                    .padding(.horizontal, Theme.Spacing.xl)
            }
        }
        .onAppear {
            print("[StatLocker][Onboarding] Goals Locked In screen appeared for \(name)")
        }
    }
}

// MARK: - Almost There View (Before Step 11)

struct AlmostThereView: View {
    let name: String
    let onContinue: () -> Void
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Theme.Colors.primary, Color(hex: "#3730A3")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: Theme.Spacing.xl) {
                Spacer()
                
                Image(systemName: "chart.line.uptrend.xyaxis")
                    .font(.system(size: 80))
                    .foregroundStyle(.white.opacity(0.9))
                
                VStack(spacing: Theme.Spacing.md) {
                    Text("Almost there, \(name)")
                        .font(Theme.Typography.headline(28))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                    
                    Text("You're ready to start tracking. Your first game log is just a tap away!")
                        .font(Theme.Typography.body(17))
                        .foregroundStyle(.white.opacity(0.9))
                        .multilineTextAlignment(.center)
                }
                
                Spacer()
                
                WhiteButton(title: "Finish Setup", action: onContinue)
                    .padding(.horizontal, Theme.Spacing.xl)
            }
        }
        .onAppear {
            print("[StatLocker][Onboarding] Almost There screen appeared for \(name)")
        }
    }
}

// MARK: - Preview

#Preview("Welcome Journey") {
    WelcomeJourneyView(name: "Julia", onContinue: {})
}

#Preview("Goals Locked In") {
    GoalsLockedInView(name: "Julia", onContinue: {})
}

#Preview("Almost There") {
    AlmostThereView(name: "Julia", onContinue: {})
}
