//
//  OnboardingView.swift
//  StatLocker
//
//  Main onboarding view that coordinates all 8 steps.
//  Handles navigation, validation, and completion per B-003.
//

import SwiftUI
import FirebaseAuth

struct OnboardingView: View {
    @Environment(\.dismiss) var dismiss
    
    var onComplete: () -> Void
    
    @State private var coordinator: OnboardingCoordinator
    
    init(userId: String, displayName: String?, email: String?, onComplete: @escaping () -> Void) {
        self.onComplete = onComplete
        self._coordinator = State(initialValue: OnboardingCoordinator(userId: userId, displayName: displayName, email: email))
    }
    
    /// Convenience initializer for FirebaseAuth.User
    init(user: User, onComplete: @escaping () -> Void) {
        self.init(userId: user.uid, displayName: user.displayName, email: user.email, onComplete: onComplete)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            
            // MARK: - Progress Bar
            
            VStack(spacing: Theme.Spacing.xs) {
                // Progress Label
                Text(coordinator.progressLabel)
                    .font(Theme.Typography.caption(12))
                    .foregroundStyle(Theme.Colors.muted)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, Theme.Spacing.md)
                
                // Segmented Progress Bar
                SegmentedProgressBar(currentStep: coordinator.currentStep, totalSteps: 11)
            }
            
            // MARK: - Step Content
            
            ZStack {
                switch coordinator.currentStep {
                case 1:
                    Step1SportSelectionView(viewModel: coordinator.viewModel)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                case 2:
                    WelcomeJourneyView(name: coordinator.viewModel.displayName) {
                        coordinator.nextStep()
                    }
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                case 3:
                    Step2TeamGenderView(viewModel: coordinator.viewModel)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                case 4:
                    Step3ProfileDetailsView(viewModel: coordinator.viewModel)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                case 5:
                    Step4PositionView(viewModel: coordinator.viewModel)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                case 6:
                    Step5TeamInfoView(viewModel: coordinator.viewModel)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                case 7:
                    Step6SeasonGoalsView(viewModel: coordinator.viewModel)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                case 8:
                    GoalsLockedInView(name: coordinator.viewModel.displayName) {
                        coordinator.nextStep()
                    }
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                case 9:
                    Step7ToneQuizView(viewModel: coordinator.viewModel)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                case 10:
                    AlmostThereView(name: coordinator.viewModel.displayName) {
                        coordinator.nextStep()
                    }
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                case 11:
                    Step8ReviewView(viewModel: coordinator.viewModel) { step in
                        coordinator.goToStep(step)
                    }
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                default:
                    Text("Invalid Step")
                }
            }
            .animation(.easeInOut(duration: 0.3), value: coordinator.currentStep)
            
            // MARK: - Navigation Buttons (only for functional steps)
            
            if !isMotivationalStep(coordinator.currentStep) {
                VStack(spacing: Theme.Spacing.md) {
                    
                    // Error Message
                    if let error = coordinator.viewModel.errorMessage {
                        HStack(spacing: Theme.Spacing.sm) {
                            Image(systemName: "exclamationmark.circle.fill")
                                .foregroundStyle(Theme.Colors.error)
                            
                            Text(error)
                                .font(Theme.Typography.caption(14))
                                .foregroundStyle(Theme.Colors.error)
                        }
                        .padding(Theme.Spacing.sm)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .fill(Theme.Colors.error.opacity(0.1))
                        )
                        .padding(.horizontal, Theme.Spacing.xl)
                        .transition(.move(edge: .top).combined(with: .opacity))
                    }
                    
                    // Continue Button
                    PrimaryButton(
                        title: coordinator.continueButtonText,
                        isLoading: coordinator.viewModel.isLoading,
                        action: coordinator.nextStep
                    )
                    .padding(.horizontal, Theme.Spacing.xl)
                    .accessibilityLabel(coordinator.continueButtonText)
                    
                    // Back Button
                    if !coordinator.isFirstStep {
                        Button {
                            coordinator.previousStep()
                        } label: {
                            Text("Back")
                                .font(Theme.Typography.body(16))
                                .foregroundStyle(Theme.Colors.primary)
                                .frame(maxWidth: .infinity)
                                .frame(height: 44)
                        }
                        .buttonStyle(.plain)
                        .padding(.horizontal, Theme.Spacing.xl)
                        .accessibilityLabel("Go back to previous step")
                    }
                }
                .padding(.vertical, Theme.Spacing.md)
            }
        }
        .background(Theme.Colors.background)
        .onChange(of: coordinator.isCompleted) { oldValue, newValue in
            if newValue {
                print("[StatLocker][Onboarding] Flow completed, dismissing")
                onComplete()
            }
        }
    }
    
    // MARK: - Helper Functions
    
    /// Check if current step is a motivational screen
    private func isMotivationalStep(_ step: Int) -> Bool {
        return step == 2 || step == 8 || step == 10 // Welcome Journey, Goals Locked In, Almost There
    }
}

// MARK: - Preview

#Preview("Onboarding - Step 1") {
    OnboardingView(userId: "preview", displayName: "John Doe", email: "john@example.com") {
        print("Onboarding complete")
    }
}

