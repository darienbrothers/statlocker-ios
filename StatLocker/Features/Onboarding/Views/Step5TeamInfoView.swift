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
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                
                // MARK: - Header
                
                VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                    Text("Claim your home turf, \(viewModel.displayName)")
                        .font(Theme.Typography.headline(32))
                        .foregroundStyle(Theme.Colors.textPrimary)
                        .accessibilityAddTraits(.isHeader)
                    
                    Text("High school and club stats tracked separately, always.")
                        .font(Theme.Typography.subhead(17))
                        .foregroundStyle(Theme.Colors.textSecondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.horizontal, Theme.Spacing.xl)
                .padding(.top, Theme.Spacing.xxl)
                .padding(.bottom, Theme.Spacing.xl)
                
                // MARK: - High School Team
                
                VStack(alignment: .leading, spacing: Theme.Spacing.md) {
                    
                    Text("High School Team")
                        .font(Theme.Typography.body(15))
                        .fontWeight(.medium)
                        .foregroundStyle(Theme.Colors.textPrimary)
                    
                    // Team Name
                    TextField("Team name (e.g., Duxbury High School)", text: $viewModel.hsTeamName)
                        .font(Theme.Typography.body(17))
                        .padding(Theme.Spacing.md)
                        .frame(height: 50)
                        .background(Theme.Colors.cardSurface)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .stroke(Theme.Colors.divider, lineWidth: 1)
                        )
                        .accessibilityLabel("High school team name")
                    
                    // City
                    TextField("City", text: $viewModel.hsCity)
                        .font(Theme.Typography.body(17))
                        .padding(Theme.Spacing.md)
                        .frame(height: 50)
                        .background(Theme.Colors.cardSurface)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .stroke(Theme.Colors.divider, lineWidth: 1)
                        )
                        .accessibilityLabel("City")
                    
                    // State Picker
                    Menu {
                        ForEach(usStates, id: \.self) { state in
                            Button(state) {
                                viewModel.hsState = state
                                print("[StatLocker][Onboarding] HS state selected: \(state)")
                            }
                        }
                    } label: {
                        HStack {
                            Text(viewModel.hsState.isEmpty ? "Select State" : viewModel.hsState)
                                .font(Theme.Typography.body(17))
                                .foregroundStyle(viewModel.hsState.isEmpty ? Theme.Colors.muted : Theme.Colors.textPrimary)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.down")
                                .font(.system(size: 14))
                                .foregroundStyle(Theme.Colors.muted)
                        }
                        .padding(Theme.Spacing.md)
                        .frame(height: 50)
                        .background(Theme.Colors.cardSurface)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .stroke(Theme.Colors.divider, lineWidth: 1)
                        )
                    }
                    .accessibilityLabel("Select state")
                }
                .padding(.horizontal, Theme.Spacing.xl)
                
                Spacer()
                    .frame(height: Theme.Spacing.xl)
                
                // MARK: - Club Toggle
                
                VStack(alignment: .leading, spacing: Theme.Spacing.md) {
                    
                    Toggle(isOn: $viewModel.hasClubTeam) {
                        Text("I also play for a club team")
                            .font(Theme.Typography.body(16))
                            .foregroundStyle(Theme.Colors.textPrimary)
                    }
                    .tint(Theme.Colors.accentEmerald)
                    .onChange(of: viewModel.hasClubTeam) { oldValue, newValue in
                        print("[StatLocker][Onboarding] Club toggle: \(newValue)")
                    }
                    
                    Text("Club stats will be tracked separately from HS.")
                        .font(Theme.Typography.caption(14))
                        .foregroundStyle(Theme.Colors.muted)
                }
                .padding(.horizontal, Theme.Spacing.xl)
                
                // MARK: - Club Team (Conditional)
                
                if viewModel.hasClubTeam {
                    Spacer()
                        .frame(height: Theme.Spacing.xl)
                    
                    VStack(alignment: .leading, spacing: Theme.Spacing.md) {
                        
                        Text("Club Team")
                            .font(Theme.Typography.body(15))
                            .fontWeight(.medium)
                            .foregroundStyle(Theme.Colors.textPrimary)
                        
                        // Club Team Name
                        TextField("Club team name", text: $viewModel.clubTeamName)
                            .font(Theme.Typography.body(17))
                            .padding(Theme.Spacing.md)
                            .frame(height: 50)
                            .background(Theme.Colors.cardSurface)
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .stroke(Theme.Colors.divider, lineWidth: 1)
                            )
                            .accessibilityLabel("Club team name")
                        
                        // Club City
                        TextField("City", text: $viewModel.clubCity)
                            .font(Theme.Typography.body(17))
                            .padding(Theme.Spacing.md)
                            .frame(height: 50)
                            .background(Theme.Colors.cardSurface)
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .stroke(Theme.Colors.divider, lineWidth: 1)
                            )
                            .accessibilityLabel("Club city")
                        
                        // Club State Picker
                        Menu {
                            ForEach(usStates, id: \.self) { state in
                                Button(state) {
                                    viewModel.clubState = state
                                    print("[StatLocker][Onboarding] Club state selected: \(state)")
                                }
                            }
                        } label: {
                            HStack {
                                Text(viewModel.clubState.isEmpty ? "Select State" : viewModel.clubState)
                                    .font(Theme.Typography.body(17))
                                    .foregroundStyle(viewModel.clubState.isEmpty ? Theme.Colors.muted : Theme.Colors.textPrimary)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.down")
                                    .font(.system(size: 14))
                                    .foregroundStyle(Theme.Colors.muted)
                            }
                            .padding(Theme.Spacing.md)
                            .frame(height: 50)
                            .background(Theme.Colors.cardSurface)
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .stroke(Theme.Colors.divider, lineWidth: 1)
                            )
                        }
                        .accessibilityLabel("Select club state")
                    }
                    .padding(.horizontal, Theme.Spacing.xl)
                    .transition(.move(edge: .top).combined(with: .opacity))
                }
                
                Spacer()
                    .frame(height: Theme.Spacing.xl)
            }
        }
    }
}

// MARK: - Preview

#Preview("Step 5 - HS Only") {
    Step5TeamInfoView(viewModel: OnboardingViewModel(userId: "preview", displayName: "John Doe", email: "john@example.com"))
        .background(Theme.Colors.background)
}

#Preview("Step 5 - With Club") {
    let vm = OnboardingViewModel(userId: "preview", displayName: "John Doe", email: "john@example.com")
    vm.hasClubTeam = true
    vm.hsTeamName = "Duxbury High School"
    vm.hsCity = "Duxbury"
    vm.hsState = "MA"
    return Step5TeamInfoView(viewModel: vm)
        .background(Theme.Colors.background)
}

