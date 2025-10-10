//
//  Step2TeamGenderView.swift
//  StatLocker
//
//  Step 2 of onboarding: Team gender selection (Boys/Girls).
//  Clean, Calm-inspired design with accessibility support.
//

import SwiftUI
import FirebaseAuth

struct Step2TeamGenderView: View {
    @Bindable var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack(spacing: Theme.Spacing.xl) {
            Spacer()
            
            // MARK: - Header
            VStack(spacing: Theme.Spacing.md) {
                Text("What team gender do you play for?")
                    .font(Theme.Typography.headline(28))
                    .foregroundStyle(Theme.Colors.textPrimary)
                    .multilineTextAlignment(.center)
                    .accessibilityAddTraits(.isHeader)
                
                Text("This helps us provide accurate performance benchmarks")
                    .font(Theme.Typography.body(16))
                    .foregroundStyle(Theme.Colors.textSecondary)
                    .multilineTextAlignment(.center)
            }
            
            // MARK: - Gender Selection Cards
            VStack(spacing: Theme.Spacing.md) {
                // Boys Card
                GenderSelectionCard(
                    title: "Boys",
                    icon: "🏃‍♂️",
                    description: "Men's lacrosse rules and benchmarks",
                    isSelected: viewModel.teamGender == "boys",
                    action: {
                        viewModel.teamGender = "boys"
                        print("[StatLocker][Onboarding] Selected team gender: Boys")
                    }
                )
                
                // Girls Card
                GenderSelectionCard(
                    title: "Girls",
                    icon: "🏃‍♀️",
                    description: "Women's lacrosse rules and benchmarks",
                    isSelected: viewModel.teamGender == "girls",
                    action: {
                        viewModel.teamGender = "girls"
                        print("[StatLocker][Onboarding] Selected team gender: Girls")
                    }
                )
            }
            .padding(.horizontal, Theme.Spacing.xl)
            
            Spacer()
        }
        .padding(Theme.Spacing.xl)
        .background(Theme.Colors.backgroundPrimary)
    }
}

// MARK: - Gender Selection Card Component

struct GenderSelectionCard: View {
    let title: String
    let icon: String
    let description: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: Theme.Spacing.md) {
                // Icon
                Text(icon)
                    .font(.system(size: 32))
                
                VStack(alignment: .leading, spacing: Theme.Spacing.xs) {
                    // Title
                    Text(title)
                        .font(Theme.Typography.title(20))
                        .foregroundStyle(Theme.Colors.textPrimary)
                        .fontWeight(isSelected ? .semibold : .medium)
                    
                    // Description
                    Text(description)
                        .font(Theme.Typography.body(14))
                        .foregroundStyle(Theme.Colors.textSecondary)
                }
                
                Spacer()
                
                // Selection indicator
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 24))
                        .foregroundStyle(Theme.Colors.primary)
                } else {
                    Image(systemName: "circle")
                        .font(.system(size: 24))
                        .foregroundStyle(Theme.Colors.divider)
                }
            }
            .padding(Theme.Spacing.lg)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Theme.Colors.backgroundSecondary)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(
                                isSelected ? Theme.Colors.primary : Theme.Colors.divider,
                                lineWidth: isSelected ? 2 : 1
                            )
                    )
            )
            .scaleEffect(isSelected ? 1.02 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: isSelected)
        }
        .buttonStyle(PlainButtonStyle())
        .accessibilityLabel("\(title) team")
        .accessibilityHint("Tap to select \(title.lowercased()) lacrosse")
        .accessibilityAddTraits(isSelected ? [.isSelected, .isButton] : .isButton)
    }
}

// MARK: - Preview

#Preview("Step 2 - Not Selected") {
    Step2TeamGenderView(viewModel: OnboardingViewModel(userId: "preview", displayName: "John Doe", email: "john@example.com"))
}

#Preview("Step 2 - Boys Selected") {
    let vm = OnboardingViewModel(userId: "preview", displayName: "John Doe", email: "john@example.com")
    vm.teamGender = "boys"
    return Step2TeamGenderView(viewModel: vm)
}


