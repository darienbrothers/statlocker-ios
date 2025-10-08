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
        VStack(alignment: .leading, spacing: 0) {
            
            // MARK: - Header
            
            VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                HStack {
                    Text("Pick your top 3 season goals")
                        .font(Theme.Typography.headline(28))
                        .foregroundStyle(Theme.Colors.textPrimary)
                        .accessibilityAddTraits(.isHeader)
                    
                    Spacer()
                    
                    // Selection Counter
                    Text("\(selectedCount)/3")
                        .font(Theme.Typography.number(20, weight: .bold))
                        .foregroundStyle(
                            selectedCount == 3 ? Theme.Colors.accentEmerald : Theme.Colors.primary
                        )
                        .accessibilityLabel("\(selectedCount) of 3 goals selected")
                }
                
                Text("These keep you locked in all season.")
                    .font(Theme.Typography.body(16))
                    .foregroundStyle(Theme.Colors.textSecondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.horizontal, Theme.Spacing.xl)
            .padding(.top, Theme.Spacing.xxl)
            .padding(.bottom, Theme.Spacing.md)
            
            // MARK: - Goals List
            
            ScrollView {
                VStack(spacing: Theme.Spacing.sm) {
                    
                    // Library Goals
                    ForEach(availableGoals) { goal in
                        GoalCard(
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
                                .foregroundStyle(Theme.Colors.muted)
                        }
                        .padding(Theme.Spacing.md)
                        .background(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .fill(Theme.Colors.cardSurface)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .stroke(Theme.Colors.primary.opacity(0.3), style: StrokeStyle(lineWidth: 1, dash: [5, 3]))
                        )
                    }
                    .buttonStyle(.plain)
                    .disabled(selectedCount >= 3)
                    .opacity(selectedCount >= 3 ? 0.5 : 1.0)
                    .accessibilityLabel("Add custom goal")
                    .accessibilityHint(selectedCount >= 3 ? "Maximum 3 goals already selected" : "Tap to create your own goal")
                }
                .padding(.horizontal, Theme.Spacing.xl)
                
                Spacer()
                    .frame(height: Theme.Spacing.xl)
                
                // Helper Text
                Text("You can change these anytime in Settings.")
                    .font(Theme.Typography.caption(14))
                    .foregroundStyle(Theme.Colors.muted)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.bottom, Theme.Spacing.xl)
            }
        }
        .sheet(isPresented: $showCustomGoalSheet) {
            CustomGoalSheet(viewModel: viewModel)
        }
    }
}

// MARK: - Preview

#Preview("Step 6 - No Selection") {
    let vm = OnboardingViewModel(userId: "preview", displayName: "John Doe", email: "john@example.com")
    vm.position = "Goalie"
    vm.level = "Varsity"
    return Step6SeasonGoalsView(viewModel: vm)
        .background(Theme.Colors.background)
}

#Preview("Step 6 - 2 Selected") {
    let vm = OnboardingViewModel(userId: "preview", displayName: "John Doe", email: "john@example.com")
    vm.position = "Goalie"
    vm.level = "Varsity"
    let goal1 = SeasonGoal(title: "60%+ save percentage", targetValue: 0.6, unit: "%", metricType: "percent", trackingKey: "save_pct")
    let goal2 = SeasonGoal(title: "200+ saves (season)", targetValue: 200, unit: "saves", metricType: "count", trackingKey: "saves")
    vm.selectedGoals = [goal1, goal2]
    return Step6SeasonGoalsView(viewModel: vm)
        .background(Theme.Colors.background)
}

