//
//  Step4PositionView.swift
//  StatLocker
//
//  Step 4 of onboarding: Position selection with gender-aware filtering and tooltips.
//  Shows tracked stats per position per B-003 requirements.
//

import SwiftUI
import FirebaseAuth

struct Step4PositionView: View {
    @Bindable var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack(spacing: Theme.Spacing.xl) {
            Spacer()
            
            // MARK: - Header
            VStack(spacing: Theme.Spacing.md) {
                Text("What position do you play?")
                    .font(Theme.Typography.headline(28))
                    .foregroundStyle(Theme.Colors.textPrimary)
                    .multilineTextAlignment(.center)
                    .accessibilityAddTraits(.isHeader)
                
                Text("Each position has specific stats we'll track for you")
                    .font(Theme.Typography.body(16))
                    .foregroundStyle(Theme.Colors.textSecondary)
                    .multilineTextAlignment(.center)
            }
            
            // MARK: - Position Grid (2x3 layout)
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: Theme.Spacing.md), count: 2), spacing: Theme.Spacing.md) {
                ForEach(getPositionsForGender()) { position in
                    PositionSelectionCard(
                        position: position,
                        isSelected: viewModel.position == position.name,
                        action: {
                            viewModel.position = position.name
                            print("[StatLocker][Onboarding] Position selected: \(position.name)")
                        }
                    )
                }
            }
            .padding(.horizontal, Theme.Spacing.xl)
            
            Spacer()
        }
        .padding(Theme.Spacing.xl)
        .background(Theme.Colors.backgroundPrimary)
    }
    
    // MARK: - Position Helpers
    
    /// Get positions based on selected gender
    private func getPositionsForGender() -> [PositionOption] {
        if viewModel.teamGender == "boys" {
            return boysPositions
        } else {
            return girlsPositions
        }
    }
    
    // MARK: - Position Definitions
    
    private let boysPositions: [PositionOption] = [
        PositionOption(
            name: "Goalie",
            icon: "figure.lacrosse",
            trackedStats: "Save %, Saves, Goals Against, Clears, Save Zones"
        ),
        PositionOption(
            name: "Attack",
            icon: "figure.run",
            trackedStats: "Goals, Assists, Shots, Shooting %, Ground Balls, Turnovers"
        ),
        PositionOption(
            name: "Midfield",
            icon: "figure.australian.football",
            trackedStats: "Goals, Assists, Ground Balls, Clears, Faceoffs, Caused Turnovers"
        ),
        PositionOption(
            name: "Defense",
            icon: "shield.fill",
            trackedStats: "Ground Balls, Caused Turnovers, Clears, Penalties"
        ),
        PositionOption(
            name: "FOGO",
            icon: "circle.hexagongrid.fill",
            trackedStats: "Faceoff Win %, FO Wins, Ground Balls, Violations, Transition Points"
        ),
        PositionOption(
            name: "LSM",
            icon: "shield.lefthalf.filled",
            trackedStats: "Ground Balls, Caused Turnovers, Clears, Penalties, Transition Points"
        )
    ]
    
    private let girlsPositions: [PositionOption] = [
        PositionOption(
            name: "Goalie",
            icon: "figure.lacrosse",
            trackedStats: "Save %, Saves, Goals Against, Clears"
        ),
        PositionOption(
            name: "Attack",
            icon: "figure.run",
            trackedStats: "Goals, Assists, Shots, Shooting %, Ground Balls, Draw Controls"
        ),
        PositionOption(
            name: "Midfield",
            icon: "figure.australian.football",
            trackedStats: "Goals, Assists, Ground Balls, Draw Controls, Caused Turnovers"
        ),
        PositionOption(
            name: "Defense",
            icon: "shield.fill",
            trackedStats: "Ground Balls, Caused Turnovers, Clears, Draw Controls"
        )
    ]
}

// MARK: - Position Option Model

struct PositionOption: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    let trackedStats: String
}

// MARK: - Position Selection Card Component

struct PositionSelectionCard: View {
    let position: PositionOption
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: Theme.Spacing.md) {
                // Position Icon
                Image(systemName: position.icon)
                    .font(.system(size: 32))
                    .foregroundStyle(Theme.Colors.primary)
                
                // Position Name
                Text(position.name)
                    .font(Theme.Typography.title(16))
                    .foregroundStyle(Theme.Colors.textPrimary)
                    .fontWeight(isSelected ? .semibold : .medium)
                    .multilineTextAlignment(.center)
                
                // Tracked Stats (smaller text)
                Text(position.trackedStats)
                    .font(Theme.Typography.caption(11))
                    .foregroundStyle(Theme.Colors.textSecondary)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }
            .frame(maxWidth: .infinity, minHeight: 120)
            .padding(Theme.Spacing.md)
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
        .accessibilityLabel("\(position.name) position")
        .accessibilityHint("Tap to select \(position.name.lowercased()) position")
        .accessibilityAddTraits(isSelected ? [.isSelected, .isButton] : .isButton)
    }
}

// MARK: - Preview

#Preview("Step 4 - Boys") {
    let vm = OnboardingViewModel(userId: "preview", displayName: "John Doe", email: "john@example.com")
    vm.teamGender = "boys"
    return Step4PositionView(viewModel: vm)
}

#Preview("Step 4 - Girls with Selection") {
    let vm = OnboardingViewModel(userId: "preview", displayName: "John Doe", email: "john@example.com")
    vm.teamGender = "girls"
    vm.position = "Goalie"
    return Step4PositionView(viewModel: vm)
}

