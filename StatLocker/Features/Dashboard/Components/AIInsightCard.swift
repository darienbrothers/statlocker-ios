//
//  AIInsightCard.swift
//  StatLocker
//
//  AI insight card component with 4 states for Dashboard feedback.
//  Used in B-004 Dashboard to provide actionable AI feedback with proper state management.
//

import SwiftUI

struct AIInsightCard: View {
    let state: AIInsightState
    let insight: String
    let nextAction: String
    var onTap: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.md) {
            switch state {
            case .hidden:
                EmptyView()
                
            case .teaser(let gamesLogged):
                VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                    Label("AI Insights", systemImage: "brain.head.profile")
                        .font(Theme.Typography.title(18))
                        .foregroundStyle(Theme.Colors.textPrimary)
                    
                    Text("Your AI Coach is learning your game...")
                        .font(Theme.Typography.body(16))
                        .foregroundStyle(Theme.Colors.textSecondary)
                    
                    Text("Log \(3 - gamesLogged) more game\(3 - gamesLogged == 1 ? "" : "s") to unlock insights")
                        .font(Theme.Typography.caption())
                        .foregroundStyle(Theme.Colors.muted)
                    
                    Text("(\(gamesLogged)/3 games)")
                        .font(Theme.Typography.caption())
                        .foregroundStyle(Theme.Colors.muted)
                }
                .padding(Theme.Spacing.md)
                .background(Theme.Colors.cardSurface)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                
            case .active, .offSeason:
                VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                    Label(state == .active ? "AI Insight" : "Season Recap", systemImage: "brain.head.profile")
                        .font(Theme.Typography.title(18))
                        .foregroundStyle(Theme.Colors.textPrimary)
                    
                    Text(insight)
                        .font(Theme.Typography.body(16))
                        .foregroundStyle(Theme.Colors.textPrimary)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    HStack(spacing: 4) {
                        Text(state == .active ? "💡" : "💪")
                        Text(nextAction)
                            .font(Theme.Typography.title(15))
                            .foregroundStyle(Theme.Colors.textPrimary)
                    }
                    
                    Button(action: onTap) {
                        Text(state == .active ? "View Drill in Skills →" : "Go to Skills Tab →")
                            .font(Theme.Typography.body(15))
                            .foregroundStyle(Theme.Colors.primary)
                    }
                    .accessibilityLabel("Navigate to Skills tab")
                }
                .padding(Theme.Spacing.md)
                .background(Theme.Colors.cardSurface)
                .overlay(
                    Rectangle()
                        .fill(Theme.Colors.accentEmerald)
                        .frame(width: 4),
                    alignment: .leading
                )
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
        }
        .themedShadow(Theme.Shadows.card)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(accessibilityLabel)
    }
    
    var accessibilityLabel: String {
        switch state {
        case .hidden:
            return ""
        case .teaser(let gamesLogged):
            return "AI Insights teaser. \(gamesLogged) of 3 games logged. Log \(3 - gamesLogged) more games to unlock insights."
        case .active:
            return "AI Insight: \(insight). Next action: \(nextAction)"
        case .offSeason:
            return "Season Recap: \(insight). Next action: \(nextAction)"
        }
    }
}

#Preview {
    VStack(spacing: Theme.Spacing.md) {
        // Teaser State
        AIInsightCard(
            state: .teaser(gamesLogged: 2),
            insight: "",
            nextAction: ""
        ) {
            print("Teaser tapped")
        }
        
        // Active State
        AIInsightCard(
            state: .active,
            insight: "Your save % jumps 18% in the 3rd quarter. Focus under pressure is a major strength.",
            nextAction: "Work on low shots (60% vs 75%)"
        ) {
            print("Active insight tapped")
        }
        
        // Off-Season State
        AIInsightCard(
            state: .offSeason,
            insight: "Your HS season: 71% save rate across 12 games. Strongest quarter: Q3 (78%)",
            nextAction: "Keep sharp: Explore Skills Library"
        ) {
            print("Off-season recap tapped")
        }
    }
    .padding()
    .background(Theme.Colors.background)
}
