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
        VStack(alignment: .leading, spacing: Theme.Spacing.md) {
            HStack {
                Label("Performance Stats (\(context == .hs ? "HS" : "Club"))", systemImage: "chart.bar.fill")
                    .font(Theme.Typography.title(18))
                    .foregroundStyle(Theme.Colors.textPrimary)
                
                Spacer()
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
                ], spacing: Theme.Spacing.sm) {
                    ForEach(stats.prefix(4), id: \.name) { stat in
                        StatTileWithTrend(stat: stat)
                    }
                }
                
                Divider()
                    .padding(.vertical, Theme.Spacing.xs)
                
                // Per Game Averages
                VStack(alignment: .leading, spacing: 4) {
                    Text("Per Game Averages")
                        .font(Theme.Typography.title(14))
                        .foregroundStyle(Theme.Colors.textSecondary)
                    
                    Text(formatPerGameStats())
                        .font(Theme.Typography.body(13))
                        .foregroundStyle(Theme.Colors.textPrimary)
                }
            }
        }
        .padding(Theme.Spacing.md)
        .background(Theme.Colors.cardSurface)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .themedShadow(Theme.Shadows.card)
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
