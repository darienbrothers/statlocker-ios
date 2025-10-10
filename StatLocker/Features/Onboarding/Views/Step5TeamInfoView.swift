//
//  Step5TeamInfoView.swift
//  StatLocker
//
//  Step 5 of onboarding: Team information with HS required and optional club.
//  Conditional club fields based on toggle per B-003.
//

import SwiftUI
import FirebaseAuth

struct Step5TeamInfoView: View {
    @Bindable var viewModel: OnboardingViewModel
    
    private let usStates = [
        "AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA",
        "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD",
        "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ",
        "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC",
        "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"
    ]
    
    var body: some View {
        VStack(spacing: Theme.Spacing.xl) {
            Spacer()
            
            // MARK: - Header
            VStack(spacing: Theme.Spacing.md) {
                Text("Tell us about your team")
                    .font(Theme.Typography.headline(28))
                    .foregroundStyle(Theme.Colors.textPrimary)
                    .multilineTextAlignment(.center)
                    .accessibilityAddTraits(.isHeader)
                
                Text("High school and club stats are tracked separately")
                    .font(Theme.Typography.body(16))
                    .foregroundStyle(Theme.Colors.textSecondary)
                    .multilineTextAlignment(.center)
            }
            
            // MARK: - Team Information Form
            VStack(spacing: Theme.Spacing.lg) {
                
                // MARK: - High School Team
                VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                    Text("High School Team")
                        .font(Theme.Typography.body(15))
                        .fontWeight(.medium)
                        .foregroundStyle(Theme.Colors.textPrimary)
                    
                    VStack(spacing: Theme.Spacing.md) {
                        // Team Name
                        TeamInfoField(
                            placeholder: "Team name (e.g., Duxbury High School)",
                            text: $viewModel.hsTeamName
                        )
                        
                        // City
                        TeamInfoField(
                            placeholder: "City",
                            text: $viewModel.hsCity
                        )
                        
                        // State Picker
                        StatePickerField(
                            selectedState: $viewModel.hsState,
                            states: usStates
                        )
                    }
                }
                .padding(Theme.Spacing.lg)
                .background(Theme.Colors.backgroundSecondary)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                Spacer()
                    .frame(height: Theme.Spacing.xl)
                
                // MARK: - Club Toggle
                VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                    Toggle(isOn: $viewModel.hasClubTeam) {
                        Text("I also play for a club team")
                            .font(Theme.Typography.body(16))
                            .foregroundStyle(Theme.Colors.textPrimary)
                    }
                    .tint(Theme.Colors.primary)
                    .onChange(of: viewModel.hasClubTeam) { oldValue, newValue in
                        print("[StatLocker][Onboarding] Club toggle: \(newValue)")
                    }
                    
                    Text("Club stats will be tracked separately from HS.")
                        .font(Theme.Typography.caption(14))
                        .foregroundStyle(Theme.Colors.textSecondary)
                }
                .padding(Theme.Spacing.lg)
                .background(Theme.Colors.backgroundSecondary)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                // MARK: - Club Team (Conditional)
                if viewModel.hasClubTeam {
                    VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                        Text("Club Team")
                            .font(Theme.Typography.body(15))
                            .fontWeight(.medium)
                            .foregroundStyle(Theme.Colors.textPrimary)
                        
                        VStack(spacing: Theme.Spacing.md) {
                            // Club Organization
                            TeamInfoField(
                                placeholder: "Club organization (e.g., Boston Lacrosse Club)",
                                text: $viewModel.clubOrganization
                            )
                            
                            // Club Team Name
                            TeamInfoField(
                                placeholder: "Team name (e.g., U17 Elite)",
                                text: $viewModel.clubTeamName
                            )
                            
                            // Club City
                            TeamInfoField(
                                placeholder: "City",
                                text: $viewModel.clubCity
                            )
                            
                            // Club State Picker
                            StatePickerField(
                                selectedState: $viewModel.clubState,
                                states: usStates
                            )
                        }
                    }
                    .padding(Theme.Spacing.lg)
                    .background(Theme.Colors.backgroundSecondary)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            .padding(.horizontal, Theme.Spacing.xl)
            
            Spacer()
        }
        .padding(Theme.Spacing.xl)
        .background(Theme.Colors.backgroundPrimary)
    }
}

// MARK: - Team Info Field Component

struct TeamInfoField: View {
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        TextField(placeholder, text: $text)
            .font(Theme.Typography.body(17))
            .textFieldStyle(.plain)
            .padding(Theme.Spacing.md)
            .frame(height: 50)
            .background(Theme.Colors.backgroundTertiary)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Theme.Colors.divider, lineWidth: 1)
            )
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

// MARK: - State Picker Field Component

struct StatePickerField: View {
    @Binding var selectedState: String
    let states: [String]
    
    var body: some View {
        Menu {
            ForEach(states, id: \.self) { state in
                Button(state) {
                    selectedState = state
                    print("[StatLocker][Onboarding] State selected: \(state)")
                }
            }
        } label: {
            HStack {
                Text(selectedState.isEmpty ? "Select State" : selectedState)
                    .font(Theme.Typography.body(17))
                    .foregroundStyle(selectedState.isEmpty ? Theme.Colors.textTertiary : Theme.Colors.textPrimary)
                
                Spacer()
                
                Image(systemName: "chevron.down")
                    .font(.system(size: 14))
                    .foregroundStyle(Theme.Colors.textSecondary)
            }
            .padding(Theme.Spacing.md)
            .frame(height: 50)
            .background(Theme.Colors.backgroundTertiary)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Theme.Colors.divider, lineWidth: 1)
            )
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .accessibilityLabel("Select state")
    }
}

// MARK: - Preview

#Preview("Step 5 - HS Only") {
    Step5TeamInfoView(viewModel: OnboardingViewModel(userId: "preview", displayName: "John Doe", email: "john@example.com"))
}

#Preview("Step 5 - With Club") {
    let vm = OnboardingViewModel(userId: "preview", displayName: "John Doe", email: "john@example.com")
    vm.hasClubTeam = true
    vm.hsTeamName = "Duxbury High School"
    vm.hsCity = "Duxbury"
    vm.hsState = "MA"
    vm.clubOrganization = "Boston Lacrosse Club"
    vm.clubTeamName = "U17 Elite"
    return Step5TeamInfoView(viewModel: vm)
}

