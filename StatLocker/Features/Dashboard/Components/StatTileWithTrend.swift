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
        VStack(alignment: .leading, spacing: 4) {
            Text(stat.name)
                .font(Theme.Typography.caption())
                .foregroundStyle(Theme.Colors.textSecondary)
            
            Text(stat.formattedValue)
                .font(Theme.Typography.number(28))
                .foregroundStyle(Theme.Colors.textPrimary)
            
            if let trend = stat.trend {
                HStack(spacing: 4) {
                    Text(trend.direction.icon)
                        .font(.system(size: 12, weight: .semibold))
                    Text(trend.formattedChange)
                        .font(Theme.Typography.caption(12))
                }
                .foregroundStyle(colorFromString(trend.direction.color))
            }
        }
        .padding(Theme.Spacing.sm)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Theme.Colors.background)
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
        .background(Theme.Colors.background)
}
