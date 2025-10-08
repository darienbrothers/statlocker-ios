//
//  HeroCard.swift
//  StatLocker
//
//  Hero card component showing athlete profile, team info, and context toggle.
//  Used in B-004 Dashboard to display athlete identity and HS/Club switching.
//

import SwiftUI

struct HeroCard: View {
    let profile: AthleteProfile
    let teamInfo: TeamInfo
    @Binding var selectedContext: GameContext
    
    var teamName: String {
        selectedContext == .hs ? teamInfo.hsTeamName : (teamInfo.clubTeamName ?? "")
    }
    
    var location: String {
        selectedContext == .hs ? teamInfo.hsLocation : (teamInfo.clubLocation ?? "")
    }
    
    var body: some View {
        VStack(spacing: Theme.Spacing.md) {
            HStack(spacing: Theme.Spacing.md) {
                // Profile Picture
                Circle()
                    .fill(Theme.Colors.cardSurface)
                    .frame(width: 40, height: 40)
                    .overlay(
                        Text(profile.firstName.prefix(1))
                            .font(Theme.Typography.title(18))
                            .foregroundStyle(Theme.Colors.primary)
                    )
                    .onTapGesture {
                        // TODO: Open Profile in drawer
                        print("[StatLocker][Dashboard] Profile picture tapped")
                    }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(profile.fullName)
                        .font(Theme.Typography.title(18))
                        .foregroundStyle(Theme.Colors.textPrimary)
                    
                    Text(teamName)
                        .font(Theme.Typography.body(15))
                        .foregroundStyle(Theme.Colors.textSecondary)
                    
                    Text("\(location) • \(profile.level)")
                        .font(Theme.Typography.caption(13))
                        .foregroundStyle(Theme.Colors.textSecondary)
                }
                
                Spacer()
            }
            
            // Context Toggle
            Picker("Context", selection: $selectedContext) {
                Text("HS").tag(GameContext.hs)
                Text("Club").tag(GameContext.club)
            }
            .pickerStyle(.segmented)
            .frame(height: 44)
            .accessibilityLabel("Select team context")
        }
        .padding(Theme.Spacing.md)
        .background(Theme.Colors.cardSurface)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .themedShadow(Theme.Shadows.card)
    }
}

#Preview {
    @Previewable @State var selectedContext: GameContext = .hs
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
        hsTeamName: "Westlake Warriors Lacrosse",
        hsCity: "Austin",
        hsState: "TX",
        hasClubTeam: true,
        clubTeamName: "Austin Elite LC",
        clubCity: "Austin",
        clubState: "TX"
    )
    
    return HeroCard(
        profile: sampleProfile,
        teamInfo: sampleTeam,
        selectedContext: $selectedContext
    )
    .padding()
    .background(Theme.Colors.background)
}
