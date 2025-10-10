//
//  OnboardingProgressBar.swift
//  StatLocker
//
//  Progress bar component for onboarding flow with gradient fill.
//  Shows "Step X of Y" text above a gradient progress bar.
//

import SwiftUI

// MARK: - Onboarding Progress Bar

struct OnboardingProgressBar: View {
    let currentStep: Int
    let totalSteps: Int
    
    var body: some View {
        VStack(spacing: Theme.Spacing.xs) {
            // Step text: "Step 2 of 8"
            Text("Step \(currentStep) of \(totalSteps)")
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(Theme.Colors.textTertiary)
                .frame(maxWidth: .infinity, alignment: .center)
            
            // Progress bar
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    // Background track
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Theme.Colors.divider)
                        .frame(height: 4)
                    
                    // Progress fill with gradient
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Theme.Gradients.primaryPurple)
                        .frame(
                            width: geo.size.width * (CGFloat(currentStep) / CGFloat(totalSteps)),
                            height: 4
                        )
                        .animation(.easeInOut(duration: 0.3), value: currentStep)
                }
            }
            .frame(height: 4)
        }
        .padding(.horizontal, Theme.Spacing.xl)
        .padding(.top, Theme.Spacing.md)
        .padding(.bottom, Theme.Spacing.xs)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Progress: Step \(currentStep) of \(totalSteps)")
        .accessibilityValue("\(Int((Double(currentStep) / Double(totalSteps)) * 100)) percent complete")
    }
}

// MARK: - Preview

#Preview("Progress - Step 1") {
    VStack(spacing: Theme.Spacing.xl) {
        OnboardingProgressBar(currentStep: 1, totalSteps: 9)
        
        Text("First Step")
            .font(Theme.Typography.headline(28))
            .foregroundStyle(Theme.Colors.textPrimary)
    }
    .frame(maxHeight: .infinity)
    .background(Theme.Colors.backgroundPrimary)
}

#Preview("Progress - Step 5") {
    VStack(spacing: Theme.Spacing.xl) {
        OnboardingProgressBar(currentStep: 5, totalSteps: 9)
        
        Text("Halfway There!")
            .font(Theme.Typography.headline(28))
            .foregroundStyle(Theme.Colors.textPrimary)
    }
    .frame(maxHeight: .infinity)
    .background(Theme.Colors.backgroundPrimary)
}

#Preview("Progress - Step 9") {
    VStack(spacing: Theme.Spacing.xl) {
        OnboardingProgressBar(currentStep: 9, totalSteps: 9)
        
        Text("Final Step")
            .font(Theme.Typography.headline(28))
            .foregroundStyle(Theme.Colors.textPrimary)
    }
    .frame(maxHeight: .infinity)
    .background(Theme.Colors.backgroundPrimary)
}
