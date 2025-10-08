//
//  GoalCard.swift
//  StatLocker
//
//  Reusable goal card for selection in onboarding.
//  Shows goal title, target, and selection state per B-003.
//

import SwiftUI

struct GoalCard: View {
    let goal: GoalTemplate
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: Theme.Spacing.md) {
                
                // Checkmark
                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 24))
                    .foregroundStyle(isSelected ? Theme.Colors.accentEmerald : Theme.Colors.muted)
                
                // Goal Info
                VStack(alignment: .leading, spacing: Theme.Spacing.xxs) {
                    Text(goal.title)
                        .font(Theme.Typography.body(15))
                        .fontWeight(isSelected ? .semibold : .regular)
                        .foregroundStyle(Theme.Colors.textPrimary)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Text("Target: \(formatTarget(goal.target)) \(goal.unit)")
                        .font(Theme.Typography.caption(13))
                        .foregroundStyle(Theme.Colors.textSecondary)
                }
                
                Spacer()
            }
            .padding(Theme.Spacing.md)
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(isSelected ? Theme.Colors.accentEmerald.opacity(0.05) : Theme.Colors.cardSurface)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .stroke(
                        isSelected ? Theme.Colors.accentEmerald : Theme.Colors.divider,
                        lineWidth: isSelected ? 2 : 1
                    )
            )
        }
        .buttonStyle(.plain)
        .accessibilityLabel(goal.title)
        .accessibilityValue("Target: \(formatTarget(goal.target)) \(goal.unit)")
        .accessibilityAddTraits(isSelected ? [.isSelected, .isButton] : .isButton)
    }
    
    private func formatTarget(_ value: Double) -> String {
        if value.truncatingRemainder(dividingBy: 1) == 0 {
            return String(Int(value))
        } else {
            return String(format: "%.1f", value)
        }
    }
}

