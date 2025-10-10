//
//  StatCounter.swift
//  StatLocker
//
//  Reusable +/- counter component for stat entry.
//  Used in B-005 After Game logging to increment/decrement stats.
//

import SwiftUI

struct StatCounter: View {
    let label: String
    let value: Int
    let onIncrement: () -> Void
    let onDecrement: () -> Void
    var accentColor: Color = Theme.Colors.primary
    
    var body: some View {
        HStack(spacing: Theme.Spacing.lg) {
            // Label
            VStack(alignment: .leading, spacing: 4) {
                Text(label)
                    .font(Theme.Typography.title(16))
                    .fontWeight(.semibold)
                    .foregroundStyle(Theme.Colors.textPrimary)
            }
            
            Spacer()
            
            // Counter Controls
            HStack(spacing: Theme.Spacing.md) {
                // Minus Button
                Button(action: onDecrement) {
                    Image(systemName: "minus")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(value > 0 ? .white : Theme.Colors.textTertiary)
                        .frame(width: 48, height: 48)
                        .background(
                            value > 0 ? 
                                Theme.Colors.error : 
                                Theme.Colors.backgroundTertiary
                        )
                        .clipShape(Circle())
                        .scaleEffect(value > 0 ? 1.0 : 0.9)
                        .animation(.easeInOut(duration: 0.1), value: value)
                }
                .disabled(value == 0)
                .accessibilityLabel("Decrease \(label)")
                
                // Value Display
                Text("\(value)")
                    .font(Theme.Typography.number(36, weight: .bold))
                    .foregroundStyle(Theme.Colors.textPrimary)
                    .frame(minWidth: 60)
                    .accessibilityLabel("\(label): \(value)")
                
                // Plus Button
                Button(action: onIncrement) {
                    Image(systemName: "plus")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(width: 48, height: 48)
                        .background(accentColor)
                        .clipShape(Circle())
                        .scaleEffect(1.0)
                        .animation(.easeInOut(duration: 0.1), value: value)
                }
                .accessibilityLabel("Increase \(label)")
            }
        }
        .padding(Theme.Spacing.lg)
        .background(Theme.Colors.backgroundTertiary)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Theme.Colors.divider.opacity(0.5), lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    VStack(spacing: Theme.Spacing.md) {
        StatCounter(
            label: "Shots Faced",
            value: 12,
            onIncrement: { print("Increment") },
            onDecrement: { print("Decrement") }
        )
        
        StatCounter(
            label: "Saves",
            value: 8,
            onIncrement: { print("Increment") },
            onDecrement: { print("Decrement") },
            accentColor: Theme.Colors.success
        )
        
        StatCounter(
            label: "Goals Allowed",
            value: 0,
            onIncrement: { print("Increment") },
            onDecrement: { print("Decrement") },
            accentColor: Theme.Colors.error
        )
    }
    .padding()
    .background(Theme.Colors.backgroundPrimary)
}

