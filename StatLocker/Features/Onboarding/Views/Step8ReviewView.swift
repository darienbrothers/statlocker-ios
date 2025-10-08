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
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                
                // MARK: - Header
                
                VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                    Text("You're all set!")
                        .font(Theme.Typography.headline(28))
                        .foregroundStyle(Theme.Colors.textPrimary)
                        .accessibilityAddTraits(.isHeader)
                    
                    Text("Review your info before entering your Locker.")
                        .font(Theme.Typography.body(16))
                        .foregroundStyle(Theme.Colors.textSecondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.horizontal, Theme.Spacing.xl)
                .padding(.top, Theme.Spacing.xxl)
                .padding(.bottom, Theme.Spacing.xl)
                
                // MARK: - Summary Sections
                
                VStack(spacing: Theme.Spacing.md) {
                    
                    // Name & Position
                    ReviewSection(title: "Profile") {
                        VStack(alignment: .leading, spacing: Theme.Spacing.xs) {
                            Text("\(viewModel.firstName) \(viewModel.lastName)")
                                .font(Theme.Typography.body(17))
                                .fontWeight(.semibold)
                                .foregroundStyle(Theme.Colors.textPrimary)
                            
                            Text("\(viewModel.position) | Class of \(viewModel.gradYear)")
                                .font(Theme.Typography.body(15))
                                .foregroundStyle(Theme.Colors.textSecondary)
                            
                            Text("Level: \(viewModel.level)")
                                .font(Theme.Typography.body(15))
                                .foregroundStyle(Theme.Colors.textSecondary)
                        }
                    } editAction: {
                        onEdit(3) // Go to profile details step
                    }
                    
                    // High School Team
                    ReviewSection(title: "High School Team") {
                        VStack(alignment: .leading, spacing: Theme.Spacing.xs) {
                            Text(viewModel.hsTeamName)
                                .font(Theme.Typography.body(17))
                                .fontWeight(.semibold)
                                .foregroundStyle(Theme.Colors.textPrimary)
                            
                            Text("\(viewModel.hsCity), \(viewModel.hsState)")
                                .font(Theme.Typography.body(15))
                                .foregroundStyle(Theme.Colors.textSecondary)
                        }
                    } editAction: {
                        onEdit(5) // Go to team info step
                    }
                    
                    // Club Team (if applicable)
                    if viewModel.hasClubTeam {
                        ReviewSection(title: "Club Team") {
                            VStack(alignment: .leading, spacing: Theme.Spacing.xs) {
                                Text(viewModel.clubTeamName)
                                    .font(Theme.Typography.body(17))
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Theme.Colors.textPrimary)
                                
                                Text("\(viewModel.clubCity), \(viewModel.clubState)")
                                    .font(Theme.Typography.body(15))
                                    .foregroundStyle(Theme.Colors.textSecondary)
                            }
                        } editAction: {
                            onEdit(5) // Go to team info step
                        }
                    }
                    
                    // Season Goals
                    ReviewSection(title: "Season Goals") {
                        VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                            ForEach(Array(viewModel.selectedGoals.enumerated()), id: \.element.id) { index, goal in
                                HStack(alignment: .top, spacing: Theme.Spacing.xs) {
                                    Text("\(index + 1).")
                                        .font(Theme.Typography.body(15))
                                        .foregroundStyle(Theme.Colors.textSecondary)
                                    
                                    Text(goal.title)
                                        .font(Theme.Typography.body(15))
                                        .foregroundStyle(Theme.Colors.textPrimary)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                            }
                        }
                    } editAction: {
                        onEdit(6) // Go to goals step
                    }
                    
                    // AI Coach Tone
                    ReviewSection(title: "AI Coach Tone") {
                        HStack(spacing: Theme.Spacing.sm) {
                            Text(getToneEmoji(viewModel.aiTone))
                                .font(.system(size: 24))
                            
                            Text(viewModel.aiTone)
                                .font(Theme.Typography.body(17))
                                .fontWeight(.semibold)
                                .foregroundStyle(Theme.Colors.textPrimary)
                        }
                    } editAction: {
                        onEdit(7) // Go to tone step
                    }
                }
                .padding(.horizontal, Theme.Spacing.xl)
                
                Spacer()
                    .frame(height: Theme.Spacing.xl)
            }
        }
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

// MARK: - Review Section Component

struct ReviewSection<Content: View>: View {
    let title: String
    @ViewBuilder let content: Content
    let editAction: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
            
            // Section Header
            HStack {
                Text(title)
                    .font(Theme.Typography.caption(13))
                    .fontWeight(.medium)
                    .foregroundStyle(Theme.Colors.muted)
                    .textCase(.uppercase)
                
                Spacer()
                
                Button {
                    editAction()
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
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Theme.Colors.cardSurface)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .stroke(Theme.Colors.divider, lineWidth: 1)
                )
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
    vm.clubTeamName = "Boston Lacrosse Club"
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
    .background(Theme.Colors.background)
}

