//
//  StatsPlaceholderView.swift
//  StatLocker
//
//  Placeholder view for Stats tab until B-006 implementation.
//

import SwiftUI

struct StatsPlaceholderView: View {
    var body: some View {
        VStack(spacing: Theme.Spacing.xl) {
            Image(systemName: "chart.line.uptrend.xyaxis")
                .font(.system(size: 64))
                .foregroundStyle(Theme.Colors.muted)
            
            Text("Stats")
                .font(Theme.Typography.headline(24))
                .foregroundStyle(Theme.Colors.textPrimary)
            
            Text("Coming in B-006")
                .font(Theme.Typography.body())
                .foregroundStyle(Theme.Colors.muted)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Theme.Colors.background)
    }
}

#Preview {
    StatsPlaceholderView()
}

