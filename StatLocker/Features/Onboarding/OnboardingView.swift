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
    
    let user: User
    var onComplete: () -> Void
    
    @State private var coordinator: OnboardingCoordinator
    
    init(user: User, onComplete: @escaping () -> Void) {
        self.user = user
        self.onComplete = onComplete
        self._coordinator = State(initialValue: OnboardingCoordinator(user: user))
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
                
                // Progress Bar
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        // Background
                        RoundedRectangle(cornerRadius: 2, style: .continuous)
                            .fill(Theme.Colors.divider)
                            .frame(height: 4)
                        
                        // Progress
                        RoundedRectangle(cornerRadius: 2, style: .continuous)
                            .fill(Theme.Colors.accentEmerald)
                            .frame(width: geometry.size.width * coordinator.progressFraction, height: 4)
                            .animation(.easeInOut(duration: 0.3), value: coordinator.currentStep)
                    }
                }
                .frame(height: 4)
                .padding(.horizontal, Theme.Spacing.xl)
            }
            
            // MARK: - Step Content
            
            ZStack {
                switch coordinator.currentStep {
                case 1:
                    Step1SportSelectionView(viewModel: coordinator.viewModel)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                case 2:
                    Step2TeamGenderView(viewModel: coordinator.viewModel)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                case 3:
                    Step3ProfileDetailsView(viewModel: coordinator.viewModel)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                case 4:
                    Step4PositionView(viewModel: coordinator.viewModel)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                case 5:
                    Step5TeamInfoView(viewModel: coordinator.viewModel)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                case 6:
                    Step6SeasonGoalsView(viewModel: coordinator.viewModel)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                case 7:
                    Step7ToneQuizView(viewModel: coordinator.viewModel)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                case 8:
                    Step8ReviewView(viewModel: coordinator.viewModel) { step in
                        coordinator.goToStep(step)
                    }
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                default:
                    Text("Invalid Step")
                }
            }
            .animation(.easeInOut(duration: 0.3), value: coordinator.currentStep)
            
            // MARK: - Navigation Buttons
            
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
                Button {
                    coordinator.nextStep()
                } label: {
                    HStack {
                        Text(coordinator.continueButtonText)
                            .font(Theme.Typography.body(17))
                            .fontWeight(.semibold)
                        
                        if coordinator.viewModel.isLoading {
                            ProgressView()
                                .tint(.white)
                                .padding(.leading, Theme.Spacing.xs)
                        }
                    }
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(Theme.Colors.primary)
                    )
                }
                .buttonStyle(.plain)
                .disabled(coordinator.viewModel.isLoading)
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
        .background(Theme.Colors.background)
        .onChange(of: coordinator.isCompleted) { oldValue, newValue in
            if newValue {
                print("[StatLocker][Onboarding] Flow completed, dismissing")
                onComplete()
            }
        }
    }
}

// MARK: - Preview

#Preview("Onboarding - Step 1") {
    OnboardingView(user: MockUser()) {
        print("Onboarding complete")
    }
}

