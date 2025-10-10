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
        VStack(alignment: .leading, spacing: Theme.Spacing.lg) {
            switch state {
            case .hidden:
                EmptyView()
                
            case .teaser(let gamesLogged):
                VStack(alignment: .leading, spacing: Theme.Spacing.md) {
                    // Header with icon
                    HStack(spacing: Theme.Spacing.sm) {
                        Image(systemName: "brain.head.profile")
                            .font(.system(size: 16))
                            .foregroundStyle(Theme.Colors.primary)
                        
                        Text("AI Insights")
                            .font(Theme.Typography.title(18))
                            .fontWeight(.semibold)
                            .foregroundStyle(Theme.Colors.textPrimary)
                        
                        Spacer()
                        
                        // Progress badge
                        Text("\(gamesLogged)/3")
                            .font(Theme.Typography.caption(12))
                            .fontWeight(.medium)
                            .foregroundStyle(Theme.Colors.primary)
                            .padding(.horizontal, Theme.Spacing.sm)
                            .padding(.vertical, 4)
                            .background(Theme.Colors.primary.opacity(0.1))
                            .clipShape(Capsule())
                    }
                    
                    // Content
                    VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                        Text("Your AI Coach is learning your game...")
                            .font(Theme.Typography.body(15))
                            .foregroundStyle(Theme.Colors.textSecondary)
                        
                        Text("Log \(3 - gamesLogged) more game\(3 - gamesLogged == 1 ? "" : "s") to unlock insights")
                            .font(Theme.Typography.caption(13))
                            .foregroundStyle(Theme.Colors.textTertiary)
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
                
            case .active, .offSeason:
                VStack(alignment: .leading, spacing: Theme.Spacing.md) {
                    // Header with gradient accent
                    HStack(spacing: Theme.Spacing.sm) {
                        Image(systemName: "brain.head.profile")
                            .font(.system(size: 16))
                            .foregroundStyle(Theme.Colors.primary)
                        
                        Text(state == .active ? "AI Insight" : "Season Recap")
                            .font(Theme.Typography.title(18))
                            .fontWeight(.semibold)
                            .foregroundStyle(Theme.Colors.textPrimary)
                        
                        Spacer()
                        
                        // Tone emoji
                        Text(state == .active ? "💡" : "💪")
                            .font(.system(size: 20))
                    }
                    
                    // Insight content
                    VStack(alignment: .leading, spacing: Theme.Spacing.md) {
                        Text(insight)
                            .font(Theme.Typography.body(15))
                            .foregroundStyle(Theme.Colors.textPrimary)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        // Next action
                        HStack(spacing: Theme.Spacing.sm) {
                            Image(systemName: "arrow.right.circle.fill")
                                .font(.system(size: 16))
                                .foregroundStyle(Theme.Colors.accentEmerald)
                            
                            Text(nextAction)
                                .font(Theme.Typography.body(14))
                                .fontWeight(.medium)
                                .foregroundStyle(Theme.Colors.textSecondary)
                        }
                        .padding(Theme.Spacing.sm)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Theme.Colors.backgroundTertiary)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    
                    // Action button
                    Button(action: onTap) {
                        HStack {
                            Text(state == .active ? "View Drill in Skills" : "Go to Skills Tab")
                                .font(Theme.Typography.body(14))
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                            
                            Spacer()
                            
                            Image(systemName: "arrow.right")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundStyle(.white)
                        }
                        .padding(Theme.Spacing.md)
                        .background(Theme.Gradients.primaryPurple)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .accessibilityLabel("Navigate to Skills tab")
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
                .overlay(
                    // Gradient accent bar on left
                    RoundedRectangle(cornerRadius: 20)
                        .fill(
                            LinearGradient(
                                colors: [Theme.Colors.primary, Theme.Colors.accentEmerald],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .frame(width: 4),
                    alignment: .leading
                )
            }
        }
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
    .background(Theme.Colors.backgroundPrimary)
}
