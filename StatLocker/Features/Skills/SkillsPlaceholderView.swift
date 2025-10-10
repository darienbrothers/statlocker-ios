//
//  SkillsPlaceholderView.swift
//  StatLocker
//
//  Placeholder view for Skills tab until B-008 implementation.
//

import SwiftUI

struct SkillsPlaceholderView: View {
    var body: some View {
        VStack(spacing: Theme.Spacing.xl) {
            Image(systemName: "target")
                .font(.system(size: 64))
                .foregroundStyle(Theme.Colors.muted)
            
            Text("Skills")
                .font(Theme.Typography.headline(24))
                .foregroundStyle(Theme.Colors.textPrimary)
            
            Text("Coming in B-008")
                .font(Theme.Typography.body())
                .foregroundStyle(Theme.Colors.muted)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Theme.Colors.background)
    }
}

#Preview {
    SkillsPlaceholderView()
}

