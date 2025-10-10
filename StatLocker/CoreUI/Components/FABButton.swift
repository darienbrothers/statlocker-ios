//
//  FABButton.swift
//  StatLocker
//
//  Floating Action Button component with sheet presentation for game logging.
//  Used in B-004 Dashboard to provide quick access to game logging options.
//

import SwiftUI

struct FABButton: View {
    let profile: AthleteProfile
    @State private var showSheet = false
    @State private var showAfterGame = false
    
    var body: some View {
        Button(action: { 
            showSheet = true
            print("[StatLocker][Dashboard] FAB sheet presented")
        }) {
            Image(systemName: "plus")
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(.white)
                .frame(width: 64, height: 64)
                .background(Theme.Colors.primary)
                .clipShape(Circle())
                .themedShadow(Theme.Shadows.elevated)
        }
        .sheet(isPresented: $showSheet) {
            LogGameSheet(
                profile: profile,
                onAfterGameTap: {
                    showSheet = false
                    showAfterGame = true
                }
            )
            .presentationDetents([.height(320)])
            .presentationDragIndicator(.visible)
        }
        .sheet(isPresented: $showAfterGame) {
            AfterGameView(profile: profile)
        }
        .accessibilityLabel("Log a game")
        .accessibilityHint("Opens game logging options")
    }
}

struct LogGameSheet: View {
    let profile: AthleteProfile
    let onAfterGameTap: () -> Void
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Log Game")
                .font(Theme.Typography.title(20))
                .padding(.top, Theme.Spacing.md)
                .padding(.bottom, Theme.Spacing.sm)
            
            Divider()
            
            VStack(spacing: 0) {
                LogOptionButton(
                    icon: "🎮",
                    title: "Live Game",
                    subtitle: "Track in real-time with timer"
                ) {
                    // TODO: Navigate to Live Game (B-005 Phase 2)
                    print("[StatLocker][Dashboard] Live Game selected")
                    dismiss()
                }
                
                LogOptionButton(
                    icon: "📝",
                    title: "After Game",
                    subtitle: "Quick entry after the game"
                ) {
                    print("[StatLocker][Dashboard] After Game selected")
                    onAfterGameTap()
                }
                
                LogOptionButton(
                    icon: "📷",
                    title: "Scan Stats Sheet",
                    subtitle: "OCR - Optical Character Recognition"
                ) {
                    // TODO: Navigate to OCR (B-005 Phase 3)
                    print("[StatLocker][Dashboard] OCR Scan selected")
                    dismiss()
                }
            }
            
            Spacer()
        }
        .background(Theme.Colors.background)
        .accessibilityElement(children: .contain)
        .accessibilityLabel("Game logging options")
    }
}

struct LogOptionButton: View {
    let icon: String
    let title: String
    let subtitle: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: Theme.Spacing.md) {
                Text(icon)
                    .font(.system(size: 32))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(Theme.Typography.title(17))
                        .foregroundStyle(Theme.Colors.textPrimary)
                    
                    Text(subtitle)
                        .font(Theme.Typography.body(14))
                        .foregroundStyle(Theme.Colors.textSecondary)
                }
                
                Spacer()
            }
            .padding(Theme.Spacing.md)
            .frame(height: 72)
            .background(Color.clear)
        }
        .buttonStyle(.plain)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(title): \(subtitle)")
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
    
    VStack {
        FABButton(profile: sampleProfile)
        Spacer()
    }
    .padding()
    .background(Theme.Colors.background)
}
