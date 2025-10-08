//
//  Step3ProfileDetailsView.swift
//  StatLocker
//
//  Step 3 of onboarding: Grad year and level selection.
//  Professional design with picker and chip selection per B-003.
//

import SwiftUI
import FirebaseAuth

struct Step3ProfileDetailsView: View {
    @Bindable var viewModel: OnboardingViewModel
    
    private let gradYears = [2025, 2026, 2027, 2028]
    private let levels = ["Freshman", "JV", "Varsity"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            // MARK: - Header
            
            VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                Text("Tell us about yourself")
                    .font(Theme.Typography.headline(28))
                    .foregroundStyle(Theme.Colors.textPrimary)
                    .accessibilityAddTraits(.isHeader)
                
                Text("We use this to build your recruiting timeline.")
                    .font(Theme.Typography.body(16))
                    .foregroundStyle(Theme.Colors.textSecondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.horizontal, Theme.Spacing.xl)
            .padding(.top, Theme.Spacing.xxl)
            .padding(.bottom, Theme.Spacing.xl)
            
            Spacer()
                .frame(height: Theme.Spacing.xl)
            
            // MARK: - Grad Year Picker
            
            VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                Text("Graduation Year")
                    .font(Theme.Typography.body(15))
                    .fontWeight(.medium)
                    .foregroundStyle(Theme.Colors.textPrimary)
                    .padding(.horizontal, Theme.Spacing.xl)
                
                Picker("Graduation Year", selection: $viewModel.gradYear) {
                    ForEach(gradYears, id: \.self) { year in
                        Text(String(year))
                            .font(Theme.Typography.body(17))
                            .tag(year)
                    }
                }
                .pickerStyle(.wheel)
                .frame(height: 120)
                .onChange(of: viewModel.gradYear) { oldValue, newValue in
                    print("[StatLocker][Onboarding] Grad year selected: \(newValue)")
                }
                .accessibilityLabel("Select graduation year")
            }
            
            Spacer()
                .frame(height: Theme.Spacing.xl)
            
            // MARK: - Level Chips
            
            VStack(alignment: .leading, spacing: Theme.Spacing.md) {
                Text("Current Level")
                    .font(Theme.Typography.body(15))
                    .fontWeight(.medium)
                    .foregroundStyle(Theme.Colors.textPrimary)
                    .padding(.horizontal, Theme.Spacing.xl)
                
                HStack(spacing: Theme.Spacing.sm) {
                    ForEach(levels, id: \.self) { level in
                        LevelChip(
                            title: level,
                            isSelected: viewModel.level == level,
                            action: {
                                viewModel.level = level
                                print("[StatLocker][Onboarding] Level selected: \(level)")
                            }
                        )
                    }
                }
                .padding(.horizontal, Theme.Spacing.xl)
                
                // Helper Text
                Text("Your level helps us suggest realistic season goals.")
                    .font(Theme.Typography.caption(14))
                    .foregroundStyle(Theme.Colors.muted)
                    .padding(.horizontal, Theme.Spacing.xl)
                    .padding(.top, Theme.Spacing.xs)
            }
            
            Spacer()
        }
    }
}

// MARK: - Level Chip Component

struct LevelChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(Theme.Typography.body(15))
                .fontWeight(isSelected ? .semibold : .regular)
                .foregroundStyle(isSelected ? .white : Theme.Colors.textPrimary)
                .frame(maxWidth: .infinity)
                .frame(height: 50) // 50pt for comfortable tap target
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
        .accessibilityLabel("\(title) level")
        .accessibilityHint("Tap to select \(title.lowercased()) level")
        .accessibilityAddTraits(isSelected ? [.isSelected, .isButton] : .isButton)
    }
}

// MARK: - Preview

#Preview("Step 3 - Default") {
    Step3ProfileDetailsView(viewModel: OnboardingViewModel(userId: "preview", displayName: "John Doe", email: "john@example.com"))
        .background(Theme.Colors.background)
}

#Preview("Step 3 - Varsity Selected") {
    let vm = OnboardingViewModel(userId: "preview", displayName: "John Doe", email: "john@example.com")
    vm.gradYear = 2026
    vm.level = "Varsity"
    return Step3ProfileDetailsView(viewModel: vm)
        .background(Theme.Colors.background)
}

