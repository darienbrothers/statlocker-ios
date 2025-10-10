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
        VStack(alignment: .leading, spacing: Theme.Spacing.lg) {
            // Header
            HStack(spacing: Theme.Spacing.sm) {
                Image(systemName: "target")
                    .font(.system(size: 16))
                    .foregroundStyle(Theme.Colors.primary)
                
                Text("Season Goals")
                    .font(Theme.Typography.title(18))
                    .fontWeight(.semibold)
                    .foregroundStyle(Theme.Colors.textPrimary)
                
                Spacer()
                
                Button {
                    showGoalsSheet = true
                    print("[StatLocker][Dashboard] Goals manage button tapped")
                } label: {
                    Text("Manage")
                        .font(Theme.Typography.body(14))
                        .fontWeight(.medium)
                        .foregroundStyle(Theme.Colors.primary)
                }
                .accessibilityLabel("Manage season goals")
            }
            
            // Goals Progress Rings
            if goals.isEmpty {
                VStack(spacing: Theme.Spacing.md) {
                    Image(systemName: "target")
                        .font(.system(size: 40))
                        .foregroundStyle(Theme.Colors.textTertiary)
                    
                    Text("Set your season goals")
                        .font(Theme.Typography.body(15))
                        .foregroundStyle(Theme.Colors.textSecondary)
                    
                    Text("Tap Manage to get started")
                        .font(Theme.Typography.caption(13))
                        .foregroundStyle(Theme.Colors.textTertiary)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, Theme.Spacing.xl)
            } else {
                HStack(spacing: Theme.Spacing.md) {
                    ForEach(goals.prefix(3)) { goal in
                        CircularGoalProgress(goal: goal)
                    }
                }
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
        VStack(spacing: Theme.Spacing.xs) {
            ZStack {
                // Background ring
                Circle()
                    .stroke(Theme.Colors.divider.opacity(0.3), lineWidth: 8)
                
                // Progress ring with gradient
                Circle()
                    .trim(from: 0, to: goal.progress)
                    .stroke(
                        AngularGradient(
                            gradient: Gradient(colors: [statusColor.opacity(0.6), statusColor]),
                            center: .center,
                            startAngle: .degrees(-90),
                            endAngle: .degrees(270 * goal.progress - 90)
                        ),
                        style: StrokeStyle(lineWidth: 8, lineCap: .round)
                    )
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut(duration: 0.6), value: goal.progress)
                
                // Center text
                VStack(spacing: 2) {
                    Text("\(Int(goal.currentValue))")
                        .font(Theme.Typography.number(18, weight: .bold))
                        .foregroundStyle(Theme.Colors.textPrimary)
                    Text("/\(Int(goal.targetValue))")
                        .font(Theme.Typography.caption(11))
                        .foregroundStyle(Theme.Colors.textTertiary)
                }
            }
            .frame(width: 90, height: 90)
            
            VStack(spacing: 2) {
                Text(goal.title.prefix(12) + (goal.title.count > 12 ? "..." : ""))
                    .font(Theme.Typography.caption(12))
                    .foregroundStyle(Theme.Colors.textSecondary)
                    .lineLimit(1)
                
                Text("\(goal.progressPercent)%")
                    .font(Theme.Typography.number(14, weight: .bold))
                    .foregroundStyle(statusColor)
            }
        }
        .frame(maxWidth: .infinity)
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
        .background(Theme.Colors.backgroundPrimary)
}
