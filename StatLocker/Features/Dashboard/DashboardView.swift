//
//  DashboardView.swift
//  StatLocker
//
//  Placeholder dashboard view for B-003 onboarding completion.
//  Full implementation in B-004.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        VStack(spacing: Theme.Spacing.xl) {
            
            Spacer()
            
            // Success State
            VStack(spacing: Theme.Spacing.md) {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 64))
                    .foregroundStyle(Theme.Colors.accentEmerald)
                
                Text("Welcome to StatLocker!")
                    .font(Theme.Typography.headline(28))
                    .foregroundStyle(Theme.Colors.textPrimary)
                
                Text("Your Locker is ready. Dashboard coming in B-004.")
                    .font(Theme.Typography.body(16))
                    .foregroundStyle(Theme.Colors.textSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, Theme.Spacing.xl)
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Theme.Colors.background)
    }
}

#Preview {
    DashboardView()
}

