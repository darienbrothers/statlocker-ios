//
//  ValidationBanner.swift
//  StatLocker
//
//  Warning banner for stat validation issues.
//  Used in B-005 Logging to show validation warnings with option to override.
//

import SwiftUI

struct ValidationBanner: View {
    let message: String
    let onDismiss: () -> Void
    let onOverride: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.lg) {
            HStack(alignment: .top, spacing: Theme.Spacing.md) {
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 24))
                    .foregroundStyle(.white)
                    .frame(width: 48, height: 48)
                    .background(Theme.Colors.warning)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 6) {
                    Text("Validation Warning")
                        .font(Theme.Typography.title(18))
                        .fontWeight(.bold)
                        .foregroundStyle(Theme.Colors.textPrimary)
                    
                    Text(message)
                        .font(Theme.Typography.body(15))
                        .foregroundStyle(Theme.Colors.textSecondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                Spacer()
                
                Button(action: onDismiss) {
                    Image(systemName: "xmark")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(Theme.Colors.textTertiary)
                        .frame(width: 32, height: 32)
                        .background(Theme.Colors.backgroundTertiary)
                        .clipShape(Circle())
                }
                .accessibilityLabel("Dismiss warning")
            }
            
            HStack(spacing: Theme.Spacing.md) {
                Button(action: onDismiss) {
                    HStack(spacing: Theme.Spacing.xs) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 16, weight: .semibold))
                        
                        Text("Fix Stats")
                            .font(Theme.Typography.body(15))
                            .fontWeight(.semibold)
                    }
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .background(Theme.Colors.accentEmerald)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                
                Button(action: onOverride) {
                    HStack(spacing: Theme.Spacing.xs) {
                        Image(systemName: "arrow.right.circle.fill")
                            .font(.system(size: 16, weight: .semibold))
                        
                        Text("Save Anyway")
                            .font(Theme.Typography.body(15))
                            .fontWeight(.semibold)
                    }
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .background(Theme.Colors.warning)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
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
                .stroke(Theme.Colors.warning, lineWidth: 2)
        )
        .overlay(
            // Gradient accent bar on left
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        colors: [Theme.Colors.warning, Theme.Colors.warning.opacity(0.6)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(width: 4),
            alignment: .leading
        )
    }
}

#Preview {
    VStack(spacing: Theme.Spacing.lg) {
        ValidationBanner(
            message: "Saves (15) cannot exceed shots faced (12). Please check your numbers.",
            onDismiss: { print("Dismissed") },
            onOverride: { print("Override") }
        )
        
        ValidationBanner(
            message: "Goals allowed (8) doesn't match shots - saves (4). This will be auto-corrected to 4.",
            onDismiss: { print("Dismissed") },
            onOverride: { print("Override") }
        )
    }
    .padding()
    .background(Theme.Colors.backgroundPrimary)
}

