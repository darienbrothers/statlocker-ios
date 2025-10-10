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
        VStack(spacing: Theme.Spacing.xl) {
            Spacer()
            
            // MARK: - Header
            VStack(spacing: Theme.Spacing.md) {
                Text("What's your name?")
                    .font(Theme.Typography.headline(28))
                    .foregroundStyle(Theme.Colors.textPrimary)
                    .multilineTextAlignment(.center)
                    .accessibilityAddTraits(.isHeader)
                
                Text("Tell us a bit about yourself")
                    .font(Theme.Typography.body(16))
                    .foregroundStyle(Theme.Colors.textSecondary)
                    .multilineTextAlignment(.center)
            }
            
            // MARK: - Profile Details Form
            VStack(spacing: Theme.Spacing.lg) {
                // Name Field
                ProfileDetailField(
                    title: "Full Name",
                    placeholder: "Enter your name",
                    text: $viewModel.displayName
                )
                
                // Graduation Year
                VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                    Text("Graduation Year")
                        .font(Theme.Typography.body(15))
                        .fontWeight(.medium)
                        .foregroundStyle(Theme.Colors.textPrimary)
                    
                    Picker("Graduation Year", selection: $viewModel.gradYear) {
                        ForEach(gradYears, id: \.self) { year in
                            Text(String(year))
                                .font(Theme.Typography.body(17))
                                .foregroundStyle(Theme.Colors.textPrimary)
                                .tag(year)
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(height: 120)
                    .clipped()
                    .onChange(of: viewModel.gradYear) { oldValue, newValue in
                        print("[StatLocker][Onboarding] Grad year selected: \(newValue)")
                    }
                    .accessibilityLabel("Select graduation year")
                }
                .padding(Theme.Spacing.lg)
                .background(Theme.Colors.backgroundSecondary)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                // Level Selection
                VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                    Text("Current Level")
                        .font(Theme.Typography.body(15))
                        .fontWeight(.medium)
                        .foregroundStyle(Theme.Colors.textPrimary)
                    
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
                }
                .padding(Theme.Spacing.lg)
                .background(Theme.Colors.backgroundSecondary)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .padding(.horizontal, Theme.Spacing.xl)
            
            Spacer()
        }
        .padding(Theme.Spacing.xl)
        .background(Theme.Colors.backgroundPrimary)
    }
}

// MARK: - Profile Detail Field Component

struct ProfileDetailField: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
            Text(title)
                .font(Theme.Typography.body(15))
                .fontWeight(.medium)
                .foregroundStyle(Theme.Colors.textPrimary)
            
            TextField(placeholder, text: $text)
                .font(Theme.Typography.body(17))
                .textFieldStyle(.plain)
                .padding(Theme.Spacing.md)
                .background(Theme.Colors.backgroundSecondary)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Theme.Colors.divider, lineWidth: 1)
                )
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .accessibilityLabel(title)
        }
        .padding(Theme.Spacing.lg)
        .background(Theme.Colors.backgroundSecondary)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

// MARK: - Level Chip Component

struct LevelChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    private var athleticBadge: String {
        switch title {
        case "Freshman": return "🔰"
        case "JV": return "⭐"
        case "Varsity": return "👑"
        default: return ""
        }
    }
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: Theme.Spacing.xs) {
                Text(athleticBadge)
                    .font(.system(size: 16))
                
                Text(title)
                    .font(Theme.Typography.body(15))
                    .fontWeight(isSelected ? .semibold : .regular)
            }
            .foregroundStyle(isSelected ? .white : Theme.Colors.textPrimary)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(isSelected ? Theme.Colors.primary : Theme.Colors.backgroundSecondary)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
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
}

#Preview("Step 3 - Varsity Selected") {
    let vm = OnboardingViewModel(userId: "preview", displayName: "John Doe", email: "john@example.com")
    vm.gradYear = 2026
    vm.level = "Varsity"
    return Step3ProfileDetailsView(viewModel: vm)
}

