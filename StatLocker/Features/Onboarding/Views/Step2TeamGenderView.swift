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
        VStack(alignment: .leading, spacing: 0) {
            
            // MARK: - Header
            
            VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                Text("Boys or girls game, \(viewModel.displayName)?")
                    .font(Theme.Typography.headline(32))
                    .foregroundStyle(Theme.Colors.textPrimary)
                    .accessibilityAddTraits(.isHeader)
                
                Text("Your stats, benchmarks, and competition level are built different.")
                    .font(Theme.Typography.subhead(17))
                    .foregroundStyle(Theme.Colors.textSecondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.horizontal, Theme.Spacing.xl)
            .padding(.top, Theme.Spacing.xxl)
            .padding(.bottom, Theme.Spacing.xl)
            
            Spacer()
                .frame(height: Theme.Spacing.xxl)
            
            // MARK: - Gender Selector
            
            VStack(alignment: .leading, spacing: Theme.Spacing.md) {
                
                // Gender Segmented Control
                HStack(spacing: Theme.Spacing.sm) {
                    
                    // Boys Button
                    GenderButton(
                        title: "Boys",
                        isSelected: viewModel.teamGender == "boys",
                        action: {
                            viewModel.teamGender = "boys"
                            print("[StatLocker][Onboarding] Gender selected: boys")
                        }
                    )
                    
                    // Girls Button
                    GenderButton(
                        title: "Girls",
                        isSelected: viewModel.teamGender == "girls",
                        action: {
                            viewModel.teamGender = "girls"
                            print("[StatLocker][Onboarding] Gender selected: girls")
                        }
                    )
                }
                .padding(.horizontal, Theme.Spacing.xl)
                
                // Helper Text
                Text("This helps us show the right positions and benchmarks.")
                    .font(Theme.Typography.caption(14))
                    .foregroundStyle(Theme.Colors.muted)
                    .padding(.horizontal, Theme.Spacing.xl)
                    .padding(.top, Theme.Spacing.xs)
            }
            
            Spacer()
        }
    }
}

// MARK: - Gender Button Component

struct GenderButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(Theme.Typography.body(17))
                .fontWeight(isSelected ? .semibold : .regular)
                .foregroundStyle(isSelected ? .white : Theme.Colors.textPrimary)
                .frame(maxWidth: .infinity)
                .frame(height: 56) // 56pt for comfortable tap target
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(isSelected ? Theme.Colors.primary : Theme.Colors.cardSurface)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .stroke(isSelected ? Theme.Colors.primary : Theme.Colors.divider, lineWidth: isSelected ? 2 : 1)
                )
        }
        .buttonStyle(.plain)
        .accessibilityLabel("\(title) team")
        .accessibilityHint("Tap to select \(title.lowercased()) lacrosse")
        .accessibilityAddTraits(isSelected ? [.isSelected, .isButton] : .isButton)
    }
}

// MARK: - Preview

#Preview("Step 2 - Not Selected") {
    Step2TeamGenderView(viewModel: OnboardingViewModel(userId: "preview", displayName: "John Doe", email: "john@example.com"))
        .background(Theme.Colors.background)
}

#Preview("Step 2 - Boys Selected") {
    let vm = OnboardingViewModel(userId: "preview", displayName: "John Doe", email: "john@example.com")
    vm.teamGender = "boys"
    return Step2TeamGenderView(viewModel: vm)
        .background(Theme.Colors.background)
}


