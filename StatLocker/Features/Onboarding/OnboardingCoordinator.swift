//
//  OnboardingCoordinator.swift
//  StatLocker
//
//  Coordinator for managing onboarding navigation and flow.
//  Handles step progression, validation, and completion per B-003.
//

import SwiftUI
import FirebaseAuth

// MARK: - Onboarding Coordinator

@Observable
class OnboardingCoordinator {
    
    // MARK: - Properties
    
    var currentStep: Int = 1
    var viewModel: OnboardingViewModel
    var isCompleted: Bool = false
    var showError: Bool = false
    
    // MARK: - Initialization
    
    init(user: User) {
        self.viewModel = OnboardingViewModel(user: user)
        self.currentStep = viewModel.currentStep
        print("[StatLocker][Onboarding] Coordinator initialized at step \(currentStep)")
    }
    
    // MARK: - Navigation
    
    /// Move to next step with validation
    func nextStep() {
        // Validate current step
        guard viewModel.validateCurrentStep() else {
            showError = true
            print("[StatLocker][Onboarding] Cannot proceed: validation failed at step \(currentStep)")
            return
        }
        
        // Log step completion
        viewModel.logStepCompletion()
        
        // Save progress
        viewModel.saveProgress()
        
        // Move to next step or complete
        if currentStep < 8 {
            currentStep += 1
            viewModel.currentStep = currentStep
            print("[StatLocker][Onboarding] Advanced to step \(currentStep)")
        } else {
            // Step 8 complete - finalize onboarding
            Task {
                await completeOnboarding()
            }
        }
    }
    
    /// Move to previous step
    func previousStep() {
        guard currentStep > 1 else {
            print("[StatLocker][Onboarding] Already at first step")
            return
        }
        
        currentStep -= 1
        viewModel.currentStep = currentStep
        
        // Save progress when going back
        viewModel.saveProgress()
        
        print("[StatLocker][Onboarding] Returned to step \(currentStep)")
    }
    
    /// Jump to specific step (for Edit from Review)
    func goToStep(_ step: Int) {
        guard step >= 1 && step <= 8 else {
            print("[StatLocker][Onboarding] Invalid step number: \(step)")
            return
        }
        
        currentStep = step
        viewModel.currentStep = step
        print("[StatLocker][Onboarding] Jumped to step \(currentStep)")
    }
    
    // MARK: - Completion
    
    /// Complete onboarding and save to Firebase
    @MainActor
    func completeOnboarding() async {
        print("[StatLocker][Onboarding] Starting completion process...")
        
        do {
            try await viewModel.completeOnboarding()
            isCompleted = true
            print("[StatLocker][Onboarding] ✅ Onboarding completed successfully")
        } catch {
            showError = true
            print("[StatLocker][Onboarding] ❌ Completion failed: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Progress Helpers
    
    /// Progress as a fraction (for progress bar)
    var progressFraction: Double {
        Double(currentStep) / 8.0
    }
    
    /// Progress label for display
    var progressLabel: String {
        "Step \(currentStep) of 8"
    }
    
    /// Check if on first step
    var isFirstStep: Bool {
        currentStep == 1
    }
    
    /// Check if on last step
    var isLastStep: Bool {
        currentStep == 8
    }
    
    /// Button text based on step
    var continueButtonText: String {
        if currentStep == 8 {
            return "Enter Your Locker"
        } else {
            return "Continue"
        }
    }
}

