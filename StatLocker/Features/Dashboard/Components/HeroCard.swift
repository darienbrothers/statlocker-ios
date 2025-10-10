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
        VStack(spacing: Theme.Spacing.lg) {
            HStack(spacing: Theme.Spacing.md) {
                // Profile Picture
                ProfileImageView(
                    imageData: profile.profilePictureData,
                    initials: String(profile.firstName.prefix(1)),
                    size: 56
                )
                .onTapGesture {
                    // TODO: Open Profile in drawer
                    print("[StatLocker][Dashboard] Profile picture tapped")
                }
                .accessibilityLabel("Profile picture")
                
                VStack(alignment: .leading, spacing: Theme.Spacing.xs) {
                    Text(profile.fullName)
                        .font(Theme.Typography.title(20))
                        .fontWeight(.bold)
                        .foregroundStyle(Theme.Colors.textPrimary)
                    
                    Text(teamName)
                        .font(Theme.Typography.body(15))
                        .foregroundStyle(Theme.Colors.textSecondary)
                    
                    HStack(spacing: Theme.Spacing.xs) {
                        Image(systemName: "mappin.circle.fill")
                            .font(.system(size: 12))
                            .foregroundStyle(Theme.Colors.textTertiary)
                        
                        Text("\(location) • \(profile.level)")
                            .font(Theme.Typography.caption(13))
                            .foregroundStyle(Theme.Colors.textTertiary)
                    }
                }
                
                Spacer()
            }
            
            // Context Toggle with gradient highlight
            Picker("Context", selection: $selectedContext) {
                Text("High School").tag(GameContext.hs)
                Text("Club").tag(GameContext.club)
            }
            .pickerStyle(.segmented)
            .frame(height: 44)
            .accessibilityLabel("Select team context")
        }
        .padding(Theme.Spacing.lg)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Theme.Colors.backgroundSecondary)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Theme.Colors.divider, lineWidth: 1)
        )
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
    .background(Theme.Colors.backgroundPrimary)
}
