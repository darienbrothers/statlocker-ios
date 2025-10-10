//
//  StatTileWithTrend.swift
//  StatLocker
//
//  Stat tile component with trend indicators for Dashboard performance display.
//  Used in B-004 Dashboard to show individual stats with up/down/stable trends.
//

import SwiftUI

struct StatTileWithTrend: View {
    let stat: PerformanceStat
    
    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.xs) {
            Text(stat.name)
                .font(Theme.Typography.caption(12))
                .fontWeight(.medium)
                .foregroundStyle(Theme.Colors.textTertiary)
            
            Text(stat.formattedValue)
                .font(Theme.Typography.number(24, weight: .bold))
                .foregroundStyle(Theme.Colors.textPrimary)
            
            if let trend = stat.trend {
                HStack(spacing: 4) {
                    Text(trend.direction.icon)
                        .font(.system(size: 10, weight: .bold))
                    Text(trend.formattedChange)
                        .font(Theme.Typography.caption(11))
                        .fontWeight(.medium)
                }
                .foregroundStyle(colorFromString(trend.direction.color))
            }
        }
        .padding(Theme.Spacing.md)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Theme.Colors.backgroundTertiary)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Theme.Colors.divider.opacity(0.5), lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(stat.name): \(stat.formattedValue)")
    }
    
    private func colorFromString(_ colorString: String) -> Color {
        switch colorString {
        case "success":
            return Theme.Colors.success
        case "error":
            return Theme.Colors.error
        case "muted":
            return Theme.Colors.muted
        default:
            return Theme.Colors.muted
        }
    }
}

#Preview {
    let sampleStat = PerformanceStat(
        name: "Save %",
        value: 0.712,
        trend: PerformanceTrend(
            statName: "savePercentage",
            currentValue: 0.712,
            previousAverage: 0.680,
            changePercentage: 3.2,
            direction: .up
        )
    )
    
    StatTileWithTrend(stat: sampleStat)
        .padding()
        .background(Theme.Colors.backgroundPrimary)
}
