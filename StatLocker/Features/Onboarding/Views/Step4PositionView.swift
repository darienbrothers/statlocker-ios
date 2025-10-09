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
        VStack(alignment: .leading, spacing: 0) {
            
            // MARK: - Header
            
            VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                Text("Lock in your position, \(viewModel.displayName)")
                    .font(Theme.Typography.headline(32))
                    .foregroundStyle(Theme.Colors.textPrimary)
                    .accessibilityAddTraits(.isHeader)
                
                Text("Each position has elite-level metrics we'll track for you.")
                    .font(Theme.Typography.subhead(17))
                    .foregroundStyle(Theme.Colors.textSecondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.horizontal, Theme.Spacing.xl)
            .padding(.top, Theme.Spacing.xxl)
            .padding(.bottom, Theme.Spacing.xl)
            
            Spacer()
                .frame(height: Theme.Spacing.xl)
            
            // MARK: - Position Grid
            
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible(), spacing: Theme.Spacing.md),
                    GridItem(.flexible(), spacing: Theme.Spacing.md)
                ], spacing: Theme.Spacing.md) {
                    ForEach(getPositionsForGender()) { position in
                        PositionCard(
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
            }
            
            Spacer()
                .frame(height: Theme.Spacing.md)
        }
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

// MARK: - Preview

#Preview("Step 4 - Boys") {
    let vm = OnboardingViewModel(userId: "preview", displayName: "John Doe", email: "john@example.com")
    vm.teamGender = "boys"
    return Step4PositionView(viewModel: vm)
        .background(Theme.Colors.background)
}

#Preview("Step 4 - Girls with Selection") {
    let vm = OnboardingViewModel(userId: "preview", displayName: "John Doe", email: "john@example.com")
    vm.teamGender = "girls"
    vm.position = "Goalie"
    return Step4PositionView(viewModel: vm)
        .background(Theme.Colors.background)
}

