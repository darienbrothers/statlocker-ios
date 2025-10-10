//
//  RecruitingPlaceholderView.swift
//  StatLocker
//
//  Placeholder view for Recruiting tab until B-009 implementation.
//

import SwiftUI

struct RecruitingPlaceholderView: View {
    var body: some View {
        VStack(spacing: Theme.Spacing.xl) {
            Image(systemName: "graduationcap.fill")
                .font(.system(size: 64))
                .foregroundStyle(Theme.Colors.muted)
            
            Text("Recruiting")
                .font(Theme.Typography.headline(24))
                .foregroundStyle(Theme.Colors.textPrimary)
            
            Text("Coming in B-009")
                .font(Theme.Typography.body())
                .foregroundStyle(Theme.Colors.muted)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Theme.Colors.background)
    }
}

#Preview {
    RecruitingPlaceholderView()
}

