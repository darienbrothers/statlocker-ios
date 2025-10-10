//
//  PerformanceStatsCard.swift
//  StatLocker
//
//  Performance stats card component with 2x2 grid and per-game averages.
//  Used in B-004 Dashboard to display position-specific stats with trends.
//

import SwiftUI

struct PerformanceStatsCard: View {
    let stats: [PerformanceStat]
    let perGameStats: [String: Double]
    let context: GameContext
    
    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.lg) {
            // Header with icon
            HStack(spacing: Theme.Spacing.sm) {
                Image(systemName: "chart.bar.fill")
                    .font(.system(size: 16))
                    .foregroundStyle(Theme.Colors.primary)
                
                Text("Performance Stats")
                    .font(Theme.Typography.title(18))
                    .fontWeight(.semibold)
                    .foregroundStyle(Theme.Colors.textPrimary)
                
                Spacer()
                
                // Context Badge
                Text(context == .hs ? "HS" : "Club")
                    .font(Theme.Typography.caption(12))
                    .fontWeight(.medium)
                    .foregroundStyle(Theme.Colors.primary)
                    .padding(.horizontal, Theme.Spacing.sm)
                    .padding(.vertical, 4)
                    .background(Theme.Colors.primary.opacity(0.1))
                    .clipShape(Capsule())
            }
            
            if stats.isEmpty {
                EmptyStateCard(
                    icon: "chart.bar.xaxis",
                    message: "Log your first game to see stats"
                )
            } else {
                // Main Tiles (2x2 grid)
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: Theme.Spacing.md) {
                    ForEach(stats.prefix(4), id: \.name) { stat in
                        StatTileWithTrend(stat: stat)
                    }
                }
                
                // Per Game Averages Section
                VStack(alignment: .leading, spacing: Theme.Spacing.xs) {
                    Text("Per Game Averages")
                        .font(Theme.Typography.caption(12))
                        .fontWeight(.medium)
                        .foregroundStyle(Theme.Colors.textTertiary)
                        .textCase(.uppercase)
                    
                    Text(formatPerGameStats())
                        .font(Theme.Typography.body(14))
                        .foregroundStyle(Theme.Colors.textSecondary)
                }
                .padding(Theme.Spacing.md)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Theme.Colors.backgroundTertiary)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
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
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Performance statistics for \(context == .hs ? "High School" : "Club")")
    }
    
    func formatPerGameStats() -> String {
        perGameStats.map { "\($0.key): \(String(format: "%.1f", $0.value))" }
            .joined(separator: " • ")
    }
}

#Preview {
    let sampleStats = [
        PerformanceStat(
            name: "Save %",
            value: 0.712,
            trend: PerformanceTrend(
                statName: "savePercentage",
                currentValue: 0.712,
                previousAverage: 0.680,
                changePercentage: 3.2,
                direction: .up
            )
        ),
        PerformanceStat(
            name: "Total Saves",
            value: 142,
            trend: PerformanceTrend(
                statName: "totalSaves",
                currentValue: 142,
                previousAverage: 144,
                changePercentage: -2,
                direction: .down
            )
        ),
        PerformanceStat(
            name: "Goals Against",
            value: 57,
            trend: PerformanceTrend(
                statName: "goalsAllowed",
                currentValue: 57,
                previousAverage: 52,
                changePercentage: 5,
                direction: .down
            )
        ),
        PerformanceStat(
            name: "Clears",
            value: 8.3,
            trend: PerformanceTrend(
                statName: "clears",
                currentValue: 8.3,
                previousAverage: 8.3,
                changePercentage: 0,
                direction: .stable
            )
        )
    ]
    
    let samplePerGame = [
        "Saves": 11.8,
        "GA": 4.8,
        "Clears": 8.3,
        "Shots Faced": 16.5
    ]
    
    PerformanceStatsCard(
        stats: sampleStats,
        perGameStats: samplePerGame,
        context: .hs
    )
    .padding()
    .background(Theme.Colors.background)
}
