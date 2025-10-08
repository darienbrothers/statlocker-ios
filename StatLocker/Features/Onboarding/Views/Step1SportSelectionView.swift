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
        VStack(alignment: .leading, spacing: 0) {
            
            // MARK: - Header
            
            VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                Text("Hey \(viewModel.displayName) 👋 What sport do you play?")
                    .font(Theme.Typography.headline(24))
                    .foregroundStyle(Theme.Colors.textPrimary)
                    .accessibilityAddTraits(.isHeader)
                
                Text("Choose the sport you'll be tracking stats for.")
                    .font(Theme.Typography.body(16))
                    .foregroundStyle(Theme.Colors.textSecondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.horizontal, Theme.Spacing.xl)
            .padding(.top, Theme.Spacing.xxl)
            .padding(.bottom, Theme.Spacing.xl)
            
            Spacer()
                .frame(height: Theme.Spacing.xl)
            
            // MARK: - Sports List
            
            ScrollView {
                VStack(spacing: Theme.Spacing.sm) {
                    ForEach(sports) { sport in
                        BorderedSelectionCard(
                            title: "\(sport.icon) \(sport.name)",
                            subtitle: sport.isUnlocked ? "Available now" : "Coming soon",
                            isSelected: viewModel.sport == sport.id,
                            action: {
                                if sport.isUnlocked {
                                    viewModel.sport = sport.id
                                    print("[StatLocker][Onboarding] Selected sport: \(sport.name)")
                                }
                            }
                        )
                        .disabled(!sport.isUnlocked)
                        .opacity(sport.isUnlocked ? 1.0 : 0.6)
                    }
                }
                .padding(.horizontal, Theme.Spacing.xl)
            }
            
            Spacer()
                .frame(height: Theme.Spacing.md)
            
            // MARK: - Helper Text
            
            Text("We're launching with lacrosse — more sports coming soon!")
                .font(Theme.Typography.caption(14))
                .foregroundStyle(Theme.Colors.muted)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, Theme.Spacing.xl)
            
            Spacer()
        }
    }
}

// MARK: - Sport Option Model

struct SportOption: Identifiable {
    let id: String
    let name: String
    let icon: String
    let isUnlocked: Bool
}

// MARK: - Sport Card Component

struct SportCard: View {
    let sport: SportOption
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: Theme.Spacing.md) {
                
                // Icon with lock overlay if locked
                ZStack {
                    Text(sport.icon)
                        .font(.system(size: 48))
                        .opacity(sport.isUnlocked ? 1.0 : 0.3)
                    
                    if !sport.isUnlocked {
                        Image(systemName: "lock.fill")
                            .font(.system(size: 20))
                            .foregroundStyle(Theme.Colors.muted)
                    }
                }
                .frame(height: 60)
                
                // Sport Name
                VStack(spacing: Theme.Spacing.xxs) {
                    Text(sport.name)
                        .font(Theme.Typography.body(15))
                        .fontWeight(isSelected ? .semibold : .medium)
                        .foregroundStyle(sport.isUnlocked ? Theme.Colors.textPrimary : Theme.Colors.muted)
                    
                    if !sport.isUnlocked {
                        Text("Coming Soon")
                            .font(Theme.Typography.caption(11))
                            .foregroundStyle(Theme.Colors.muted)
                            .padding(.horizontal, Theme.Spacing.xs)
                            .padding(.vertical, 2)
                            .background(
                                Capsule()
                                    .fill(Theme.Colors.muted.opacity(0.1))
                            )
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 140)
            .padding(.vertical, Theme.Spacing.md)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(sport.isUnlocked ? Theme.Colors.cardSurface : Theme.Colors.cardSurface.opacity(0.5))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(
                        isSelected ? Theme.Colors.accentEmerald : (sport.isUnlocked ? Theme.Colors.divider : Theme.Colors.divider.opacity(0.5)),
                        lineWidth: isSelected ? 2 : 1
                    )
            )
        }
        .buttonStyle(.plain)
        .disabled(!sport.isUnlocked)
        .accessibilityLabel(sport.name)
        .accessibilityHint(sport.isUnlocked ? "Tap to select \(sport.name)" : "\(sport.name) coming soon")
        .accessibilityAddTraits(sport.isUnlocked ? (isSelected ? [.isSelected, .isButton] : .isButton) : [])
    }
}

// MARK: - Preview

#Preview("Step 1 - Default") {
    Step1SportSelectionView(viewModel: OnboardingViewModel(userId: "preview", displayName: "John Doe", email: "john@example.com"))
        .background(Theme.Colors.background)
}

#Preview("Step 1 - Lacrosse Selected") {
    let vm = OnboardingViewModel(userId: "preview", displayName: "John Doe", email: "john@example.com")
    vm.sport = "lacrosse"
    return Step1SportSelectionView(viewModel: vm)
        .background(Theme.Colors.background)
}

