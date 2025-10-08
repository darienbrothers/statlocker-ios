//
//  OnboardingComponents.swift
//  StatLocker
//
//  Core UI components for the revamped onboarding flow.
//  Includes SegmentedProgressBar, BorderedSelectionCard, PrimaryButton, and WhiteButton.
//

import SwiftUI
import UIKit

// MARK: - Segmented Progress Bar

struct SegmentedProgressBar: View {
    let currentStep: Int
    let totalSteps: Int
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(1...totalSteps, id: \.self) { step in
                RoundedRectangle(cornerRadius: 2, style: .continuous)
                    .fill(step <= currentStep ? Theme.Colors.accentEmerald : Theme.Colors.divider.opacity(0.2))
                    .frame(height: 4)
                    .animation(.easeInOut(duration: 0.3), value: currentStep)
            }
        }
        .padding(.horizontal, Theme.Spacing.xl)
    }
}

// MARK: - Bordered Selection Card

struct BorderedSelectionCard: View {
    let title: String
    let subtitle: String?
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                VStack(alignment: .leading, spacing: Theme.Spacing.xs) {
                    Text(title)
                        .font(Theme.Typography.body(16))
                        .fontWeight(.medium)
                        .foregroundStyle(Theme.Colors.textPrimary)
                    
                    if let subtitle = subtitle {
                        Text(subtitle)
                            .font(Theme.Typography.caption(14))
                            .foregroundStyle(Theme.Colors.textSecondary)
                    }
                }
                
                Spacer()
                
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 20))
                        .foregroundStyle(Theme.Colors.primary)
                } else {
                    Image(systemName: "circle")
                        .font(.system(size: 20))
                        .foregroundStyle(Theme.Colors.divider)
                }
            }
            .padding(Theme.Spacing.md)
            .background(Theme.Colors.cardSurface)
            .overlay(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .stroke(isSelected ? Theme.Colors.primary : Theme.Colors.divider, lineWidth: 1)
            )
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
        .buttonStyle(.plain)
        .scaleEffect(isSelected ? 1.02 : 1.0)
        .animation(.easeInOut(duration: 0.2), value: isSelected)
        .hapticFeedback(.light)
    }
}

// MARK: - Primary Button

struct PrimaryButton: View {
    let title: String
    let isLoading: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .font(Theme.Typography.body(17))
                    .fontWeight(.semibold)
                
                if isLoading {
                    ProgressView()
                        .tint(.white)
                        .scaleEffect(0.8)
                        .padding(.leading, Theme.Spacing.xs)
                }
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 56) // Accessibility requirement
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Theme.Colors.primary)
            )
        }
        .buttonStyle(.plain)
        .disabled(isLoading)
        .hapticFeedback(.medium)
    }
}

// MARK: - White Button (for gradient screens)

struct WhiteButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(Theme.Typography.body(17))
                .fontWeight(.semibold)
                .foregroundStyle(Theme.Colors.primary)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(.white)
                )
        }
        .buttonStyle(.plain)
        .hapticFeedback(.medium)
    }
}

// MARK: - Haptic Feedback Extension

extension View {
    func hapticFeedback(_ style: UIImpactFeedbackGenerator.FeedbackStyle = .light) -> some View {
        self.onTapGesture {
            let impactFeedback = UIImpactFeedbackGenerator(style: style)
            impactFeedback.impactOccurred()
        }
    }
}

// MARK: - Preview

#Preview("Onboarding Components") {
    VStack(spacing: Theme.Spacing.lg) {
        SegmentedProgressBar(currentStep: 3, totalSteps: 8)
        
        BorderedSelectionCard(
            title: "Lacrosse",
            subtitle: "Track saves, goals, and clears",
            isSelected: true,
            action: {}
        )
        
        BorderedSelectionCard(
            title: "Basketball",
            subtitle: "Track points, assists, and rebounds",
            isSelected: false,
            action: {}
        )
        
        PrimaryButton(title: "Continue", isLoading: false, action: {})
        
        WhiteButton(title: "Let's Go", action: {})
    }
    .padding()
    .background(Theme.Colors.background)
}
