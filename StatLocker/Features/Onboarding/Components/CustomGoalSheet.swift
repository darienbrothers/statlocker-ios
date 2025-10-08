//
//  CustomGoalSheet.swift
//  StatLocker
//
//  Modal sheet for creating custom season goals.
//  Supports both quantitative and qualitative goals per B-003.
//

import SwiftUI
import FirebaseAuth

struct CustomGoalSheet: View {
    @Environment(\.dismiss) var dismiss
    @Bindable var viewModel: OnboardingViewModel
    
    @State private var goalTitle: String = ""
    @State private var targetValue: String = ""
    @State private var unit: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: Theme.Spacing.xl) {
                
                // MARK: - Instructions
                
                VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                    Text("Create your own goal to track this season.")
                        .font(Theme.Typography.body(16))
                        .foregroundStyle(Theme.Colors.textSecondary)
                }
                
                // MARK: - Form Fields
                
                VStack(alignment: .leading, spacing: Theme.Spacing.md) {
                    
                    // Goal Name
                    VStack(alignment: .leading, spacing: Theme.Spacing.xs) {
                        Text("Goal Name")
                            .font(Theme.Typography.caption(13))
                            .fontWeight(.medium)
                            .foregroundStyle(Theme.Colors.textSecondary)
                        
                        TextField("e.g., Improve weak-side coverage", text: $goalTitle)
                            .font(Theme.Typography.body(17))
                            .padding(Theme.Spacing.md)
                            .frame(height: 50)
                            .background(Theme.Colors.cardSurface)
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .stroke(Theme.Colors.divider, lineWidth: 1)
                            )
                    }
                    
                    // Target (Optional)
                    VStack(alignment: .leading, spacing: Theme.Spacing.xs) {
                        Text("Target (Optional)")
                            .font(Theme.Typography.caption(13))
                            .fontWeight(.medium)
                            .foregroundStyle(Theme.Colors.textSecondary)
                        
                        TextField("e.g., 50", text: $targetValue)
                            .font(Theme.Typography.body(17))
                            .keyboardType(.decimalPad)
                            .padding(Theme.Spacing.md)
                            .frame(height: 50)
                            .background(Theme.Colors.cardSurface)
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .stroke(Theme.Colors.divider, lineWidth: 1)
                            )
                    }
                    
                    // Unit (Optional)
                    VStack(alignment: .leading, spacing: Theme.Spacing.xs) {
                        Text("Unit (Optional)")
                            .font(Theme.Typography.caption(13))
                            .fontWeight(.medium)
                            .foregroundStyle(Theme.Colors.textSecondary)
                        
                        TextField("e.g., games, saves", text: $unit)
                            .font(Theme.Typography.body(17))
                            .padding(Theme.Spacing.md)
                            .frame(height: 50)
                            .background(Theme.Colors.cardSurface)
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .stroke(Theme.Colors.divider, lineWidth: 1)
                            )
                    }
                }
                
                Spacer()
                
                // MARK: - Add Button
                
                Button {
                    addCustomGoal()
                } label: {
                    Text("Add Goal")
                        .font(Theme.Typography.body(17))
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .fill(goalTitle.isEmpty ? Theme.Colors.muted : Theme.Colors.primary)
                        )
                }
                .buttonStyle(.plain)
                .disabled(goalTitle.isEmpty)
                .accessibilityLabel("Add custom goal")
            }
            .padding(Theme.Spacing.xl)
            .navigationTitle("Custom Goal")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func addCustomGoal() {
        let target = Double(targetValue)
        viewModel.addCustomGoal(
            title: goalTitle,
            target: target,
            unit: unit.isEmpty ? "goal" : unit
        )
        dismiss()
        print("[StatLocker][Onboarding] Custom goal added: \(goalTitle)")
    }
}

