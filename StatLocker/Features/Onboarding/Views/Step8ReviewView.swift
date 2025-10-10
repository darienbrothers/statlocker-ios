//
//  Step8ReviewView.swift
//  StatLocker
//
//  Step 8 of onboarding: Final review with edit capability.
//  Read-only summary before saving to Firebase per B-003.
//

import SwiftUI
import FirebaseAuth

struct Step8ReviewView: View {
    @Bindable var viewModel: OnboardingViewModel
    var onEdit: (Int) -> Void // Callback to jump to specific step
    
    var body: some View {
        VStack(spacing: Theme.Spacing.xl) {
            Spacer()
            
            // MARK: - Header
            VStack(spacing: Theme.Spacing.md) {
                Text("You're all set!")
                    .font(Theme.Typography.headline(28))
                    .foregroundStyle(Theme.Colors.textPrimary)
                    .multilineTextAlignment(.center)
                    .accessibilityAddTraits(.isHeader)
                
                Text("Review your setup and start tracking your first game")
                    .font(Theme.Typography.body(16))
                    .foregroundStyle(Theme.Colors.textSecondary)
                    .multilineTextAlignment(.center)
            }
            
            // MARK: - Summary Sections
            VStack(spacing: Theme.Spacing.lg) {
                // Profile Summary
                ReviewSummaryCard(
                    title: "Profile",
                    icon: "person.fill",
                    content: {
                        HStack(spacing: Theme.Spacing.md) {
                            // Profile Picture Preview
                            if let image = viewModel.profileImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            } else {
                                Circle()
                                    .fill(Theme.Colors.backgroundSecondary)
                                    .frame(width: 50, height: 50)
                                    .overlay(
                                        Text(viewModel.displayName.prefix(1))
                                            .font(.system(size: 20, weight: .semibold))
                                            .foregroundStyle(Theme.Colors.primary)
                                    )
                            }
                            
                            VStack(alignment: .leading, spacing: Theme.Spacing.xs) {
                                Text(viewModel.displayName)
                                    .font(Theme.Typography.body(16))
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Theme.Colors.textPrimary)
                                
                                Text("\(viewModel.position) | Class of \(String(viewModel.gradYear))")
                                    .font(Theme.Typography.caption(14))
                                    .foregroundStyle(Theme.Colors.textSecondary)
                            }
                            
                            Spacer()
                        }
                    },
                    onEdit: { onEdit(0) }
                )
                
                // Team Summary
                ReviewSummaryCard(
                    title: "Team",
                    icon: "sportscourt.fill",
                    content: {
                        VStack(alignment: .leading, spacing: Theme.Spacing.xs) {
                            Text(viewModel.hsTeamName)
                                .font(Theme.Typography.body(16))
                                .fontWeight(.semibold)
                                .foregroundStyle(Theme.Colors.textPrimary)
                            
                            Text("\(viewModel.hsCity), \(viewModel.hsState)")
                                .font(Theme.Typography.caption(14))
                                .foregroundStyle(Theme.Colors.textSecondary)
                        }
                    },
                    onEdit: { onEdit(5) }
                )
                
                // Season Goals Summary
                ReviewSummaryCard(
                    title: "Season Goals",
                    icon: "target",
                    content: {
                        VStack(alignment: .leading, spacing: Theme.Spacing.xs) {
                            ForEach(Array(viewModel.selectedGoals.enumerated()), id: \.element.id) { index, goal in
                                HStack(alignment: .top, spacing: Theme.Spacing.xs) {
                                    Text("\(index + 1).")
                                        .font(Theme.Typography.caption(12))
                                        .foregroundStyle(Theme.Colors.textSecondary)
                                    
                                    Text(goal.title)
                                        .font(Theme.Typography.caption(12))
                                        .foregroundStyle(Theme.Colors.textPrimary)
                                        .lineLimit(1)
                                }
                            }
                        }
                    },
                    onEdit: { onEdit(6) }
                )
                
                // AI Coach Tone Summary
                ReviewSummaryCard(
                    title: "AI Coach",
                    icon: "brain.head.profile",
                    content: {
                        HStack(spacing: Theme.Spacing.sm) {
                            Text(getToneEmoji(viewModel.aiTone))
                                .font(.system(size: 20))
                            
                            Text(viewModel.aiTone)
                                .font(Theme.Typography.body(16))
                                .fontWeight(.semibold)
                                .foregroundStyle(Theme.Colors.textPrimary)
                        }
                    },
                    onEdit: { onEdit(7) }
                )
            }
            .padding(.horizontal, Theme.Spacing.xl)
            
            Spacer()
        }
        .padding(Theme.Spacing.xl)
        .background(Theme.Colors.backgroundPrimary)
    }
    
    // MARK: - Helpers
    
    private func getToneEmoji(_ tone: String) -> String {
        switch tone {
        case "Hype": return "🔥"
        case "Mentor": return "🎯"
        case "Analyst": return "📊"
        case "Captain": return "⚡️"
        default: return "💪"
        }
    }
}

// MARK: - Review Summary Card Component

struct ReviewSummaryCard<Content: View>: View {
    let title: String
    let icon: String
    @ViewBuilder let content: Content
    let onEdit: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
            // Section Header
            HStack {
                HStack(spacing: Theme.Spacing.sm) {
                    Image(systemName: icon)
                        .font(.system(size: 16))
                        .foregroundStyle(Theme.Colors.primary)
                    
                    Text(title)
                        .font(Theme.Typography.caption(13))
                        .fontWeight(.medium)
                        .foregroundStyle(Theme.Colors.textSecondary)
                        .textCase(.uppercase)
                }
                
                Spacer()
                
                Button {
                    onEdit()
                    print("[StatLocker][Onboarding] Edit tapped for: \(title)")
                } label: {
                    Text("Edit")
                        .font(Theme.Typography.body(15))
                        .foregroundStyle(Theme.Colors.primary)
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Edit \(title)")
            }
            
            // Content
            content
                .padding(Theme.Spacing.md)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Theme.Colors.backgroundSecondary)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Theme.Colors.divider, lineWidth: 1)
                )
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

// MARK: - Preview

#Preview("Step 8 - Complete") {
    let vm = OnboardingViewModel(userId: "preview", displayName: "John Doe", email: "john@example.com")
    vm.sport = "lacrosse"
    vm.teamGender = "boys"
    vm.gradYear = 2026
    vm.level = "Varsity"
    vm.position = "Goalie"
    vm.hsTeamName = "Duxbury High School"
    vm.hsCity = "Duxbury"
    vm.hsState = "MA"
    vm.hasClubTeam = true
    vm.clubOrganization = "Boston Lacrosse Club"
    vm.clubTeamName = "U17 Elite"
    vm.clubCity = "Boston"
    vm.clubState = "MA"
    vm.selectedGoals = [
        SeasonGoal(title: "60%+ save percentage", targetValue: 0.6, unit: "%", metricType: "percent", trackingKey: "save_pct"),
        SeasonGoal(title: "200+ saves (season)", targetValue: 200, unit: "saves", metricType: "count", trackingKey: "saves"),
        SeasonGoal(title: "12.0+ saves per game", targetValue: 12, unit: "saves", metricType: "rate", trackingKey: "saves")
    ]
    vm.aiTone = "Hype"
    
    return Step8ReviewView(viewModel: vm) { step in
        print("Navigate to step \(step)")
    }
}


