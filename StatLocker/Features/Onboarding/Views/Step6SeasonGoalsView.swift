//
//  Step6SeasonGoalsView.swift
//  StatLocker
//
//  Step 6 of onboarding: Season goal selection from library + custom goals.
//  Filtered by position and level with 3-goal max per B-003.
//

import SwiftUI
import FirebaseAuth

struct Step6SeasonGoalsView: View {
    @Bindable var viewModel: OnboardingViewModel
    @State private var showCustomGoalSheet = false
    
    private var availableGoals: [GoalTemplate] {
        GoalsLibrary.shared.getGoals(for: viewModel.position, level: viewModel.level)
    }
    
    private var selectedCount: Int {
        viewModel.selectedGoals.count
    }
    
    var body: some View {
        VStack(spacing: Theme.Spacing.xl) {
            Spacer()
            
            // MARK: - Header
            VStack(spacing: Theme.Spacing.md) {
                Text("Set your season goals")
                    .font(Theme.Typography.headline(28))
                    .foregroundStyle(Theme.Colors.textPrimary)
                    .multilineTextAlignment(.center)
                    .accessibilityAddTraits(.isHeader)
                
                HStack {
                    Text("Choose up to 3 goals to track this season")
                        .font(Theme.Typography.body(16))
                        .foregroundStyle(Theme.Colors.textSecondary)
                    
                    Spacer()
                    
                    // Selection Counter
                    Text("\(selectedCount)/3")
                        .font(Theme.Typography.number(20, weight: .bold))
                        .foregroundStyle(
                            selectedCount == 3 ? Theme.Colors.accentEmerald : Theme.Colors.primary
                        )
                        .accessibilityLabel("\(selectedCount) of 3 goals selected")
                }
                .multilineTextAlignment(.center)
            }
            .padding(.horizontal, Theme.Spacing.xl)
            
            // MARK: - Goals List
            VStack(spacing: Theme.Spacing.md) {
                // Library Goals
                ForEach(availableGoals) { goal in
                    GoalSelectionCard(
                        goal: goal,
                        isSelected: viewModel.isGoalSelected(goal.id),
                        action: {
                            viewModel.toggleGoal(goal)
                        }
                    )
                }
                
                // Custom Goal Button
                Button {
                    showCustomGoalSheet = true
                    print("[StatLocker][Onboarding] Opening custom goal sheet")
                } label: {
                    HStack(spacing: Theme.Spacing.md) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 24))
                            .foregroundStyle(Theme.Colors.primary)
                        
                        Text("Custom Goal")
                            .font(Theme.Typography.body(15))
                            .fontWeight(.medium)
                            .foregroundStyle(Theme.Colors.textPrimary)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .font(.system(size: 14))
                            .foregroundStyle(Theme.Colors.textSecondary)
                    }
                    .padding(Theme.Spacing.lg)
                    .background(Theme.Colors.backgroundSecondary)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Theme.Colors.primary.opacity(0.3), style: StrokeStyle(lineWidth: 1, dash: [5, 3]))
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .buttonStyle(.plain)
                .disabled(selectedCount >= 3)
                .opacity(selectedCount >= 3 ? 0.5 : 1.0)
                .accessibilityLabel("Add custom goal")
                .accessibilityHint(selectedCount >= 3 ? "Maximum 3 goals already selected" : "Tap to create your own goal")
            }
            .padding(.horizontal, Theme.Spacing.xl)
            
            Spacer()
            
            // Helper Text
            Text("You can change these anytime in Settings.")
                .font(Theme.Typography.caption(14))
                .foregroundStyle(Theme.Colors.textTertiary)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.horizontal, Theme.Spacing.xl)
        }
        .sheet(isPresented: $showCustomGoalSheet) {
            CustomGoalSheet(viewModel: viewModel)
        }
        .padding(Theme.Spacing.xl)
        .background(Theme.Colors.backgroundPrimary)
    }
}

// MARK: - Goal Selection Card Component

struct GoalSelectionCard: View {
    let goal: GoalTemplate
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: Theme.Spacing.md) {
                // Goal Icon
                Image(systemName: goal.icon)
                    .font(.system(size: 24))
                    .foregroundStyle(Theme.Colors.primary)
                    .frame(width: 40, height: 40)
                
                VStack(alignment: .leading, spacing: Theme.Spacing.xs) {
                    // Goal Title
                    Text(goal.title)
                        .font(Theme.Typography.body(16))
                        .foregroundStyle(Theme.Colors.textPrimary)
                        .fontWeight(isSelected ? .semibold : .medium)
                        .multilineTextAlignment(.leading)
                    
                    // Goal Description
                    Text(goal.description)
                        .font(Theme.Typography.caption(12))
                        .foregroundStyle(Theme.Colors.textSecondary)
                        .lineLimit(2)
                }
                
                Spacer()
                
                // Selection indicator
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 24))
                        .foregroundStyle(Theme.Colors.primary)
                } else {
                    Image(systemName: "circle")
                        .font(.system(size: 24))
                        .foregroundStyle(Theme.Colors.divider)
                }
            }
            .padding(Theme.Spacing.lg)
            .background(Theme.Colors.backgroundSecondary)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(
                        isSelected ? Theme.Colors.primary : Theme.Colors.divider,
                        lineWidth: isSelected ? 2 : 1
                    )
            )
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .scaleEffect(isSelected ? 1.02 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: isSelected)
        }
        .buttonStyle(PlainButtonStyle())
        .accessibilityLabel("\(goal.title) goal")
        .accessibilityHint("Tap to select this goal")
        .accessibilityAddTraits(isSelected ? [.isSelected, .isButton] : .isButton)
    }
}

// MARK: - Preview

#Preview("Step 6 - No Selection") {
    let vm = OnboardingViewModel(userId: "preview", displayName: "John Doe", email: "john@example.com")
    vm.position = "Goalie"
    vm.level = "Varsity"
    return Step6SeasonGoalsView(viewModel: vm)
}

#Preview("Step 6 - 2 Selected") {
    let vm = OnboardingViewModel(userId: "preview", displayName: "John Doe", email: "john@example.com")
    vm.position = "Goalie"
    vm.level = "Varsity"
    let goal1 = SeasonGoal(title: "60%+ save percentage", targetValue: 0.6, unit: "%", metricType: "percent", trackingKey: "save_pct")
    let goal2 = SeasonGoal(title: "200+ saves (season)", targetValue: 200, unit: "saves", metricType: "count", trackingKey: "saves")
    vm.selectedGoals = [goal1, goal2]
    return Step6SeasonGoalsView(viewModel: vm)
}

