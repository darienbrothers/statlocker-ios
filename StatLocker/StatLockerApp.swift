//
//  StatLockerApp.swift
//  StatLocker
//
//  Created by Darien Brothers on 10/6/25.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn  // ADD THIS

@main
struct StatLockerApp: App {
    private let flags = FeatureFlags.load()
    
    init() {
        // Initialize Firebase
        FirebaseConfig.shared
    }
    
    var body: some Scene {
        WindowGroup {
            WelcomeScreen()
                .onAppear {
                    print("[StatLocker][Boot] App launched — iOS 17+ SwiftUI")
                }
                .onOpenURL { url in
                    // Handle Google Sign-In redirect
                    GIDSignIn.sharedInstance.handle(url)
                    print("[StatLocker][Auth] Handled URL redirect: \(url)")
                }  // ADD THIS
        }
    }
}