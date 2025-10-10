//
//  AfterGameView.swift
//  StatLocker
//
//  After Game logging view with stat counters and validation.
//  Used in B-005 Logging to quickly log game stats after the game ends.
//

import SwiftUI
import Foundation

struct AfterGameView: View {
    @State private var viewModel: AfterGameViewModel
    @Environment(\.dismiss) var dismiss
    
    init(profile: AthleteProfile) {
        _viewModel = State(wrappedValue: AfterGameViewModel(profile: profile))
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: Theme.Spacing.xl) {
                    // Header with gradient accent
                    VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                        HStack(spacing: Theme.Spacing.sm) {
                            Image(systemName: "gamecontroller.fill")
                                .font(.system(size: 20))
                                .foregroundStyle(Theme.Colors.primary)
                            
                            Text("Log Game Stats")
                                .font(Theme.Typography.headline(28))
                                .fontWeight(.bold)
                                .foregroundStyle(Theme.Colors.textPrimary)
                            
                            Spacer()
                            
                            // Position badge
                            Text(viewModel.profile.position)
                                .font(Theme.Typography.caption(12))
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                                .padding(.horizontal, Theme.Spacing.sm)
                                .padding(.vertical, 6)
                                .background(Theme.Gradients.primaryPurple)
                                .clipShape(Capsule())
                        }
                        
                        Text("Quick entry after the game")
                            .font(Theme.Typography.body(16))
                            .foregroundStyle(Theme.Colors.textSecondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // Game Meta Section
                    VStack(alignment: .leading, spacing: Theme.Spacing.lg) {
                        // Header with icon
                        HStack(spacing: Theme.Spacing.sm) {
                            Image(systemName: "info.circle.fill")
                                .font(.system(size: 16))
                                .foregroundStyle(Theme.Colors.primary)
                            
                            Text("Game Info")
                                .font(Theme.Typography.title(18))
                                .fontWeight(.semibold)
                                .foregroundStyle(Theme.Colors.textPrimary)
                        }
                        
                        // Context Chips
                        GameMetaChips(
                            selectedContext: $viewModel.selectedContext,
                            isConference: $viewModel.isConference
                        )
                        
                        // Opponent Field
                        VStack(alignment: .leading, spacing: Theme.Spacing.xs) {
                            Text("Opponent (Optional)")
                                .font(Theme.Typography.caption(12))
                                .fontWeight(.medium)
                                .foregroundStyle(Theme.Colors.textTertiary)
                                .textCase(.uppercase)
                            
                            TextField("Team name", text: $viewModel.opponent)
                                .font(Theme.Typography.body(16))
                                .textFieldStyle(.plain)
                                .textInputAutocapitalization(.words)
                                .autocorrectionDisabled(false)
                                .padding(Theme.Spacing.md)
                                .background(Theme.Colors.backgroundTertiary)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Theme.Colors.divider, lineWidth: 1)
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .accessibilityLabel("Opponent team name")
                        }
                        
                        // Date Picker
                        VStack(alignment: .leading, spacing: Theme.Spacing.xs) {
                            Text("Game Date")
                                .font(Theme.Typography.caption(12))
                                .fontWeight(.medium)
                                .foregroundStyle(Theme.Colors.textTertiary)
                                .textCase(.uppercase)
                            
                            DatePicker(
                                "Game Date",
                                selection: $viewModel.gameDate,
                                in: ...Date(),
                                displayedComponents: .date
                            )
                            .datePickerStyle(.compact)
                            .labelsHidden()
                            .padding(Theme.Spacing.md)
                            .background(Theme.Colors.backgroundTertiary)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Theme.Colors.divider, lineWidth: 1)
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .accessibilityLabel("Select game date")
                        }
                    }
                    .padding(Theme.Spacing.lg)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Theme.Colors.backgroundSecondary)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Theme.Colors.divider, lineWidth: 1)
                    )
                    
                    // Stats Section
                    VStack(alignment: .leading, spacing: Theme.Spacing.lg) {
                        // Header with save percentage (Goalie only)
                        HStack(spacing: Theme.Spacing.sm) {
                            Image(systemName: "chart.bar.fill")
                                .font(.system(size: 16))
                                .foregroundStyle(Theme.Colors.primary)
                            
                            Text("Game Stats")
                                .font(Theme.Typography.title(18))
                                .fontWeight(.semibold)
                                .foregroundStyle(Theme.Colors.textPrimary)
                            
                            Spacer()
                            
                            // Save Percentage Display (Goalie only)
                            if viewModel.isGoalie, viewModel.shotsFaced > 0 {
                                VStack(alignment: .trailing, spacing: 4) {
                                    Text("Save %")
                                        .font(Theme.Typography.caption(12))
                                        .fontWeight(.medium)
                                        .foregroundStyle(Theme.Colors.textTertiary)
                                        .textCase(.uppercase)
                                    
                                    Text(viewModel.savePercentageFormatted)
                                        .font(Theme.Typography.number(24, weight: .bold))
                                        .foregroundStyle(Theme.Colors.accentEmerald)
                                }
                                .padding(.horizontal, Theme.Spacing.md)
                                .padding(.vertical, Theme.Spacing.sm)
                                .background(Theme.Colors.accentEmerald.opacity(0.1))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            }
                        }
                        
                        // Position-specific stat counters
                        if viewModel.isGoalie {
                            goalieStatsView
                        } else if viewModel.isAttack {
                            attackStatsView
                        } else if viewModel.isMidfield {
                            midfieldStatsView
                        } else if viewModel.isDefense || viewModel.isLSM {
                            defenseStatsView
                        } else if viewModel.isFOGO {
                            fogoStatsView
                        }
                    }
                    .padding(Theme.Spacing.lg)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Theme.Colors.backgroundSecondary)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Theme.Colors.divider, lineWidth: 1)
                    )
                    
                    // Validation Warning Banner
                    if viewModel.showValidationWarning {
                        ValidationBanner(
                            message: viewModel.validationMessage,
                            onDismiss: {
                                viewModel.showValidationWarning = false
                            },
                            onOverride: {
                                Task {
                                    await viewModel.saveGameWithOverride()
                                }
                            }
                        )
                        .padding(.horizontal, Theme.Spacing.md)
                        .transition(.move(edge: .top).combined(with: .opacity))
                    }
                    
                    // Save Button
                    Button(action: {
                        Task {
                            await viewModel.saveGame()
                        }
                    }) {
                        HStack(spacing: Theme.Spacing.sm) {
                            if viewModel.isSaving {
                                ProgressView()
                                    .tint(.white)
                                    .scaleEffect(0.8)
                            } else {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 18, weight: .semibold))
                            }
                            
                            Text(viewModel.isSaving ? "Saving Game..." : "Save Game")
                                .font(Theme.Typography.title(17))
                                .fontWeight(.semibold)
                        }
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(
                            viewModel.canSave ? 
                                Theme.Gradients.primaryPurple : 
                                LinearGradient(
                                    colors: [Theme.Colors.textTertiary, Theme.Colors.textTertiary],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .scaleEffect(viewModel.isSaving ? 0.98 : 1.0)
                        .animation(.easeInOut(duration: 0.1), value: viewModel.isSaving)
                    }
                    .disabled(!viewModel.canSave || viewModel.isSaving)
                    .accessibilityLabel("Save game")
                    .accessibilityHint(viewModel.canSave ? "Save game stats" : "Enter at least one stat to save")
                }
                .padding(Theme.Spacing.lg)
                .padding(.bottom, 100) // Space for tab bar
        }
        .background(Theme.Colors.backgroundPrimary)
        .navigationBarTitleDisplayMode(.inline)
        // Allow system preference to control theme
        .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        print("[StatLocker][Logging] After Game cancelled")
                        dismiss()
                    }
                    .foregroundStyle(Theme.Colors.textSecondary)
                }
            }
            .alert("Game Saved!", isPresented: $viewModel.showSuccessAlert) {
                Button("OK") {
                    viewModel.resetForm()
                    dismiss()
                }
            } message: {
                Text("Your game stats have been logged successfully.")
            }
            .alert("Error", isPresented: .init(
                get: { viewModel.errorMessage != nil },
                set: { if !$0 { viewModel.errorMessage = nil } }
            )) {
                Button("OK") {
                    viewModel.errorMessage = nil
                }
            } message: {
                if let error = viewModel.errorMessage {
                    Text(error)
                }
            }
        }
    }
    
    // MARK: - Position-Specific Stats Views
    
    var goalieStatsView: some View {
        VStack(spacing: Theme.Spacing.sm) {
            StatCounter(
                label: "Shots Faced",
                value: viewModel.shotsFaced,
                onIncrement: { viewModel.incrementStat("shotsFaced") },
                onDecrement: { viewModel.decrementStat("shotsFaced") },
                accentColor: Theme.Colors.primary
            )
            
            StatCounter(
                label: "Saves",
                value: viewModel.saves,
                onIncrement: { viewModel.incrementStat("saves") },
                onDecrement: { viewModel.decrementStat("saves") },
                accentColor: Theme.Colors.success
            )
            
            StatCounter(
                label: "Goals Allowed",
                value: viewModel.goalsAllowed,
                onIncrement: { viewModel.incrementStat("goalsAllowed") },
                onDecrement: { viewModel.decrementStat("goalsAllowed") },
                accentColor: Theme.Colors.error
            )
            
            StatCounter(
                label: "Clears",
                value: viewModel.clears,
                onIncrement: { viewModel.incrementStat("clears") },
                onDecrement: { viewModel.decrementStat("clears") },
                accentColor: Theme.Colors.accentEmerald
            )
        }
    }
    
    var attackStatsView: some View {
        VStack(spacing: Theme.Spacing.sm) {
            StatCounter(
                label: "Goals",
                value: viewModel.goals,
                onIncrement: { viewModel.incrementStat("goals") },
                onDecrement: { viewModel.decrementStat("goals") },
                accentColor: Theme.Colors.success
            )
            
            StatCounter(
                label: "Assists",
                value: viewModel.assists,
                onIncrement: { viewModel.incrementStat("assists") },
                onDecrement: { viewModel.decrementStat("assists") },
                accentColor: Theme.Colors.accentEmerald
            )
            
            StatCounter(
                label: "Shots",
                value: viewModel.shots,
                onIncrement: { viewModel.incrementStat("shots") },
                onDecrement: { viewModel.decrementStat("shots") },
                accentColor: Theme.Colors.primary
            )
            
            StatCounter(
                label: "Ground Balls",
                value: viewModel.groundBalls,
                onIncrement: { viewModel.incrementStat("groundBalls") },
                onDecrement: { viewModel.decrementStat("groundBalls") },
                accentColor: Theme.Colors.accentTeal
            )
        }
    }
    
    var midfieldStatsView: some View {
        VStack(spacing: Theme.Spacing.sm) {
            StatCounter(
                label: "Goals",
                value: viewModel.goals,
                onIncrement: { viewModel.incrementStat("goals") },
                onDecrement: { viewModel.decrementStat("goals") },
                accentColor: Theme.Colors.success
            )
            
            StatCounter(
                label: "Assists",
                value: viewModel.assists,
                onIncrement: { viewModel.incrementStat("assists") },
                onDecrement: { viewModel.decrementStat("assists") },
                accentColor: Theme.Colors.accentEmerald
            )
            
            StatCounter(
                label: "Ground Balls",
                value: viewModel.groundBalls,
                onIncrement: { viewModel.incrementStat("groundBalls") },
                onDecrement: { viewModel.decrementStat("groundBalls") },
                accentColor: Theme.Colors.accentTeal
            )
            
            StatCounter(
                label: "Caused Turnovers",
                value: viewModel.causedTurnovers,
                onIncrement: { viewModel.incrementStat("causedTurnovers") },
                onDecrement: { viewModel.decrementStat("causedTurnovers") },
                accentColor: Theme.Colors.primary
            )
        }
    }
    
    var defenseStatsView: some View {
        VStack(spacing: Theme.Spacing.sm) {
            StatCounter(
                label: "Ground Balls",
                value: viewModel.groundBalls,
                onIncrement: { viewModel.incrementStat("groundBalls") },
                onDecrement: { viewModel.decrementStat("groundBalls") },
                accentColor: Theme.Colors.accentTeal
            )
            
            StatCounter(
                label: "Caused Turnovers",
                value: viewModel.causedTurnovers,
                onIncrement: { viewModel.incrementStat("causedTurnovers") },
                onDecrement: { viewModel.decrementStat("causedTurnovers") },
                accentColor: Theme.Colors.primary
            )
            
            StatCounter(
                label: "Assists",
                value: viewModel.assists,
                onIncrement: { viewModel.incrementStat("assists") },
                onDecrement: { viewModel.decrementStat("assists") },
                accentColor: Theme.Colors.accentEmerald
            )
            
            StatCounter(
                label: "Goals",
                value: viewModel.goals,
                onIncrement: { viewModel.incrementStat("goals") },
                onDecrement: { viewModel.decrementStat("goals") },
                accentColor: Theme.Colors.success
            )
        }
    }
    
    var fogoStatsView: some View {
        VStack(spacing: Theme.Spacing.sm) {
            StatCounter(
                label: "Faceoff Wins",
                value: viewModel.faceoffWins,
                onIncrement: { viewModel.incrementStat("faceoffWins") },
                onDecrement: { viewModel.decrementStat("faceoffWins") },
                accentColor: Theme.Colors.success
            )
            
            StatCounter(
                label: "Faceoff Losses",
                value: viewModel.faceoffLosses,
                onIncrement: { viewModel.incrementStat("faceoffLosses") },
                onDecrement: { viewModel.decrementStat("faceoffLosses") },
                accentColor: Theme.Colors.error
            )
            
            StatCounter(
                label: "Ground Balls",
                value: viewModel.groundBalls,
                onIncrement: { viewModel.incrementStat("groundBalls") },
                onDecrement: { viewModel.decrementStat("groundBalls") },
                accentColor: Theme.Colors.accentTeal
            )
            
            StatCounter(
                label: "Goals",
                value: viewModel.goals,
                onIncrement: { viewModel.incrementStat("goals") },
                onDecrement: { viewModel.decrementStat("goals") },
                accentColor: Theme.Colors.accentEmerald
            )
        }
    }
}

#Preview {
    let sampleProfile = AthleteProfile(
        userId: "123",
        firstName: "Jordan",
        lastName: "Smith",
        email: "jordan@example.com",
        sport: "lacrosse",
        teamGender: "boys",
        gradYear: 2026,
        level: "Varsity",
        position: "Goalie",
        aiTone: "Mentor",
        seasonGoals: [],
        onboardingCompleted: true,
        createdAt: Date()
    )
    
    AfterGameView(profile: sampleProfile)
}

