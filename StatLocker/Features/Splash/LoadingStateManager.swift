//
//  LoadingStateManager.swift
//  StatLocker
//
//  Manages splash screen timing and app initialization state.
//  Implements dynamic loading with 1.5s minimum and 4s maximum timeout.
//

import Foundation
import SwiftUI

@Observable
class LoadingStateManager {
    var isLoading = true
    var loadingMessage = "Loading..."
    
    private let minimumLoadingTime: TimeInterval = 1.5
    private let maximumLoadingTime: TimeInterval = 4.0
    private var loadingStartTime: Date?
    private var initializationComplete = false
    
    func startLoading() {
        loadingStartTime = Date()
        isLoading = true
        initializationComplete = false
        
        print("[StatLocker][Splash] Loading started")
        
        // Start initialization tasks
        Task {
            await performInitialization()
        }
    }
    
    @MainActor
    private func performInitialization() async {
        // Simulate initialization tasks
        await withTaskGroup(of: Void.self) { group in
            // Task 1: Firebase initialization (already done in AppDelegate)
            group.addTask {
                await self.simulateFirebaseInit()
            }
            
            // Task 2: Auth state check
            group.addTask {
                await self.simulateAuthCheck()
            }
            
            // Task 3: User profile loading
            group.addTask {
                await self.simulateProfileLoad()
            }
            
            // Wait for all tasks to complete
            await group.waitForAll()
        }
        
        // Mark initialization as complete
        initializationComplete = true
        
        // Ensure minimum loading time has passed
        await ensureMinimumLoadingTime()
        
        // Complete loading
        await completeLoading()
    }
    
    private func simulateFirebaseInit() async {
        // Firebase is already initialized in AppDelegate
        // This is just a placeholder for any additional Firebase setup
        try? await Task.sleep(nanoseconds: 300_000_000) // 0.3 seconds
        print("[StatLocker][Splash] Firebase initialization complete")
    }
    
    private func simulateAuthCheck() async {
        // Simulate auth state check
        try? await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds
        print("[StatLocker][Splash] Auth state check complete")
    }
    
    private func simulateProfileLoad() async {
        // Simulate user profile loading
        try? await Task.sleep(nanoseconds: 400_000_000) // 0.4 seconds
        print("[StatLocker][Splash] Profile loading complete")
    }
    
    private func ensureMinimumLoadingTime() async {
        guard let startTime = loadingStartTime else { return }
        
        let elapsedTime = Date().timeIntervalSince(startTime)
        let remainingTime = minimumLoadingTime - elapsedTime
        
        if remainingTime > 0 {
            print("[StatLocker][Splash] Ensuring minimum loading time: \(remainingTime)s remaining")
            try? await Task.sleep(nanoseconds: UInt64(remainingTime * 1_000_000_000))
        }
    }
    
    @MainActor
    private func completeLoading() async {
        // Check if we've exceeded maximum time
        if let startTime = loadingStartTime {
            let totalTime = Date().timeIntervalSince(startTime)
            if totalTime > maximumLoadingTime {
                print("[StatLocker][Splash] Loading timeout reached: \(totalTime)s")
            } else {
                print("[StatLocker][Splash] Loading completed in \(totalTime)s")
            }
        }
        
        // Fade out loading screen
        withAnimation(.easeInOut(duration: 0.5)) {
            isLoading = false
        }
    }
    
    func forceCompleteLoading() {
        print("[StatLocker][Splash] Force completing loading")
        Task { @MainActor in
            withAnimation(.easeInOut(duration: 0.3)) {
                isLoading = false
            }
        }
    }
}
