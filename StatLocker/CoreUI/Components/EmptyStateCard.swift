//
//  EmptyStateCard.swift
//  StatLocker
//
//  Reusable empty state component for Dashboard and other screens.
//  Used in B-004 Dashboard to show empty states with consistent styling.
//

import SwiftUI

struct EmptyStateCard: View {
    let icon: String
    let message: String
    
    var body: some View {
        VStack(spacing: Theme.Spacing.md) {
            Image(systemName: icon)
                .font(.system(size: 40))
                .foregroundStyle(Theme.Colors.muted)
            
            Text(message)
                .font(Theme.Typography.body())
                .foregroundStyle(Theme.Colors.textSecondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(Theme.Spacing.xl)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(message) - \(icon)")
    }
}

#Preview {
    VStack(spacing: Theme.Spacing.md) {
        EmptyStateCard(
            icon: "chart.bar.xaxis",
            message: "Log your first game to see stats"
        )
        
        EmptyStateCard(
            icon: "gamecontroller",
            message: "Your game history will appear here"
        )
    }
    .padding()
    .background(Theme.Colors.background)
}
