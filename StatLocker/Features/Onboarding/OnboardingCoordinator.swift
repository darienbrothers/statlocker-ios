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
    var isEditMode: Bool = false // Track if we're editing from review screen
    
    // MARK: - Initialization
    
    init(userId: String, displayName: String?, email: String?) {
        self.viewModel = OnboardingViewModel(userId: userId, displayName: displayName, email: email)
        self.currentStep = viewModel.currentStep
        
        // Ensure we start at step 0 for new users
        if currentStep != 0 && viewModel.sport.isEmpty {
            print("[StatLocker][Onboarding] Detected incomplete saved progress, resetting to step 0")
            currentStep = 0
            viewModel.currentStep = 0
        }
        
        print("[StatLocker][Onboarding] Coordinator initialized at step \(currentStep)")
    }
    
    /// Convenience initializer for FirebaseAuth.User
    convenience init(user: User) {
        self.init(userId: user.uid, displayName: user.displayName, email: user.email)
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
        
        // If in edit mode, return to review screen (step 9)
        if isEditMode && currentStep != 9 {
            print("[StatLocker][Onboarding] Edit mode: returning to review screen")
            currentStep = 9
            viewModel.currentStep = 9
            isEditMode = false
            return
        }
        
        // Move to next step or complete
        if currentStep < 8 {
            currentStep += 1
            viewModel.currentStep = currentStep
            print("[StatLocker][Onboarding] Advanced to step \(currentStep)")
        } else {
            // Step 8 (review) complete - finalize onboarding
            Task {
                await completeOnboarding()
            }
        }
    }
    
    /// Move to previous step
    func previousStep() {
        guard currentStep > 0 else {
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
        guard step >= 0 && step <= 8 else {
            print("[StatLocker][Onboarding] Invalid step number: \(step)")
            return
        }
        
        // Enable edit mode when navigating from review screen
        if currentStep == 8 && step != 8 {
            isEditMode = true
            print("[StatLocker][Onboarding] Entering edit mode from review screen")
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
        Double(currentStep) / 9.0
    }
    
    /// Progress label for display
    var progressLabel: String {
        "Step \(currentStep + 1) of 9"
    }
    
    /// Check if on first step
    var isFirstStep: Bool {
        currentStep == 0
    }
    
    /// Check if on last step
    var isLastStep: Bool {
        currentStep == 8
    }
    
    /// Button text based on step
    var continueButtonText: String {
        if currentStep == 8 {
            return "Enter My Locker 🔓"
        } else {
            return "Continue"
        }
    }
}

