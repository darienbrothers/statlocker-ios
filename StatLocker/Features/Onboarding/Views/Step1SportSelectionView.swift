//
//  Step1SportSelectionView.swift
//  StatLocker
//
//  Step 1 of onboarding: Sport selection with Lacrosse unlocked.
//  Future-proofed for multi-sport expansion per B-003.
//

import SwiftUI
import FirebaseAuth

struct Step1SportSelectionView: View {
    @Bindable var viewModel: OnboardingViewModel
    
    private let sports: [SportOption] = [
        SportOption(id: "lacrosse", name: "Lacrosse", icon: "🥍", isUnlocked: true),
        SportOption(id: "basketball", name: "Basketball", icon: "🏀", isUnlocked: false),
        SportOption(id: "field_hockey", name: "Field Hockey", icon: "🏑", isUnlocked: false),
        SportOption(id: "football", name: "Football", icon: "🏈", isUnlocked: false),
        SportOption(id: "baseball", name: "Baseball", icon: "⚾️", isUnlocked: false)
    ]
    
    var body: some View {
        VStack(spacing: Theme.Spacing.xl) {
            Spacer()
            
            // MARK: - Header
            VStack(spacing: Theme.Spacing.md) {
                Text("What sport do you play?")
                    .font(Theme.Typography.headline(28))
                    .foregroundStyle(Theme.Colors.textPrimary)
                    .multilineTextAlignment(.center)
                    .accessibilityAddTraits(.isHeader)
                
                Text("Choose your sport to get started")
                    .font(Theme.Typography.body(16))
                    .foregroundStyle(Theme.Colors.textSecondary)
                    .multilineTextAlignment(.center)
            }
            
            // MARK: - Sports Grid (2x2 layout)
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: Theme.Spacing.md), count: 2), spacing: Theme.Spacing.md) {
                ForEach(sports) { sport in
                    SportSelectionCard(
                        sport: sport,
                        isSelected: viewModel.sport == sport.id,
                        action: {
                            if sport.isUnlocked {
                                viewModel.sport = sport.id
                                print("[StatLocker][Onboarding] Selected sport: \(sport.name)")
                            }
                        }
                    )
                }
            }
            .padding(.horizontal, Theme.Spacing.xl)
            
            Spacer()
            
            // MARK: - Helper Text
            Text("We're launching with lacrosse — more sports coming soon!")
                .font(Theme.Typography.caption(14))
                .foregroundStyle(Theme.Colors.textTertiary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, Theme.Spacing.xl)
        }
        .padding(Theme.Spacing.xl)
        .background(Theme.Colors.backgroundPrimary)
    }
}

// MARK: - Sport Option Model

struct SportOption: Identifiable {
    let id: String
    let name: String
    let icon: String
    let isUnlocked: Bool
}

// MARK: - Sport Selection Card Component

struct SportSelectionCard: View {
    let sport: SportOption
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: Theme.Spacing.md) {
                // Sport Icon
                Text(sport.icon)
                    .font(.system(size: 40))
                    .opacity(sport.isUnlocked ? 1.0 : 0.4)
                
                // Sport Name
                Text(sport.name)
                    .font(Theme.Typography.title(18))
                    .foregroundStyle(sport.isUnlocked ? Theme.Colors.textPrimary : Theme.Colors.textTertiary)
                    .multilineTextAlignment(.center)
                
                // Status Badge
                if !sport.isUnlocked {
                    Text("Coming Soon")
                        .font(Theme.Typography.caption(12))
                        .foregroundStyle(Theme.Colors.textSecondary)
                        .padding(.horizontal, Theme.Spacing.sm)
                        .padding(.vertical, Theme.Spacing.xs)
                        .background(Theme.Colors.backgroundTertiary)
                        .clipShape(Capsule())
                }
            }
            .frame(maxWidth: .infinity, minHeight: 120)
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
            .opacity(sport.isUnlocked ? 1.0 : 0.6)
            .animation(.easeInOut(duration: 0.2), value: isSelected)
        }
        .buttonStyle(PlainButtonStyle())
        .disabled(!sport.isUnlocked)
        .accessibilityLabel("\(sport.name) sport option")
        .accessibilityHint(sport.isUnlocked ? "Tap to select" : "Coming soon")
    }
}

// MARK: - Preview

#Preview("Step 1 - Default") {
    Step1SportSelectionView(viewModel: OnboardingViewModel(userId: "preview", displayName: "John Doe", email: "john@example.com"))
}

#Preview("Step 1 - Lacrosse Selected") {
    let vm = OnboardingViewModel(userId: "preview", displayName: "John Doe", email: "john@example.com")
    vm.sport = "lacrosse"
    return Step1SportSelectionView(viewModel: vm)
}

