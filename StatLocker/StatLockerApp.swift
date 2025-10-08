//
//  StatLockerApp.swift
//  StatLocker
//
//  Created by Darien Brothers on 10/6/25.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn

// MARK: - App Delegate for Firebase Setup

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Configure Firebase at app launch
        FirebaseApp.configure()
        print("[StatLocker][Boot] Firebase configured")
        return true
    }
}

// MARK: - App Entry

@main
struct StatLockerApp: App {
    // Register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    private let flags = FeatureFlags.load()
    
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
                }
        }
    }
}