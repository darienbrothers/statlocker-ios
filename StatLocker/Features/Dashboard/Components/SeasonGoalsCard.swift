//
//  SeasonGoalsCard.swift
//  StatLocker
//
//  Season goals card component with circular progress indicators.
//  Used in B-004 Dashboard to display goal progress with tap-to-expand functionality.
//

import SwiftUI

struct SeasonGoalsCard: View {
    let goals: [SeasonGoal]
    @State private var showGoalsSheet = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.md) {
            HStack {
                Label("Season Goals", systemImage: "target")
                    .font(Theme.Typography.title(18))
                    .foregroundStyle(Theme.Colors.textPrimary)
                
                Spacer()
                
                Button("Manage") {
                    showGoalsSheet = true
                    print("[StatLocker][Dashboard] Goals manage button tapped")
                }
                .font(Theme.Typography.body(15))
                .foregroundStyle(Theme.Colors.primary)
                .accessibilityLabel("Manage season goals")
            }
            
            HStack(spacing: Theme.Spacing.lg) {
                ForEach(goals.prefix(3)) { goal in
                    CircularGoalProgress(goal: goal)
                }
            }
            
            if goals.isEmpty {
                Text("Start logging games to track progress")
                    .font(Theme.Typography.caption())
                    .foregroundStyle(Theme.Colors.textSecondary)
            } else {
                Text("On track • Tap to expand full view")
                    .font(Theme.Typography.caption())
                    .foregroundStyle(Theme.Colors.textSecondary)
            }
        }
        .padding(Theme.Spacing.md)
        .background(Theme.Colors.cardSurface)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .themedShadow(Theme.Shadows.card)
        .onTapGesture {
            showGoalsSheet = true
            print("[StatLocker][Dashboard] Season goals card tapped")
        }
        .sheet(isPresented: $showGoalsSheet) {
            // TODO: Full Goals View (B-007)
            Text("Goals Detail View - Coming in B-007")
                .padding()
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Season goals progress")
    }
}

struct CircularGoalProgress: View {
    let goal: SeasonGoal
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .stroke(Theme.Colors.divider, lineWidth: 6)
                
                Circle()
                    .trim(from: 0, to: goal.progress)
                    .stroke(statusColor, lineWidth: 6)
                    .rotationEffect(.degrees(-90))
                
                VStack(spacing: 2) {
                    Text("\(Int(goal.currentValue))")
                        .font(Theme.Typography.number(16))
                        .foregroundStyle(Theme.Colors.textPrimary)
                    Text("/\(Int(goal.targetValue))")
                        .font(Theme.Typography.caption(12))
                        .foregroundStyle(Theme.Colors.textSecondary)
                }
            }
            .frame(width: 80, height: 80)
            
            Text(goal.title.prefix(10) + (goal.title.count > 10 ? "..." : ""))
                .font(Theme.Typography.caption(13))
                .foregroundStyle(Theme.Colors.textSecondary)
                .lineLimit(1)
            
            Text("\(goal.progressPercent)%")
                .font(Theme.Typography.number(14, weight: .semibold))
                .foregroundStyle(statusColor)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(goal.title): \(goal.progressPercent)% complete")
    }
    
    var statusColor: Color {
        switch goal.status {
        case .completed:
            return Theme.Colors.accentEmerald
        case .onTrack:
            return Theme.Colors.success
        case .catchUp:
            return Theme.Colors.warning
        case .stretch:
            return Theme.Colors.primary
        }
    }
}

#Preview {
    let sampleGoals = [
        SeasonGoal(
            title: "60%+ save percentage",
            targetValue: 0.6,
            currentValue: 0.23,
            unit: "%",
            metricType: "percent",
            trackingKey: "save_pct"
        ),
        SeasonGoal(
            title: "200+ saves",
            targetValue: 200,
            currentValue: 45,
            unit: "saves",
            metricType: "count",
            trackingKey: "saves"
        ),
        SeasonGoal(
            title: "12 saves/game",
            targetValue: 12,
            currentValue: 8,
            unit: "saves/game",
            metricType: "rate",
            trackingKey: "saves_per_game"
        )
    ]
    
    SeasonGoalsCard(goals: sampleGoals)
        .padding()
        .background(Theme.Colors.background)
}
