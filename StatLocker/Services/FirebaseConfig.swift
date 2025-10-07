//
//  FirebaseConfig.swift
//  StatLocker
//
//  Firebase configuration and initialization per B-002 Auth requirements.
//  [StatLocker][Auth] logs included per project rules.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import FirebaseAnalytics

class FirebaseConfig {
    static let shared = FirebaseConfig()
    
    private init() {
        configureFirebase()
    }
    
    private func configureFirebase() {
        guard let path = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist") else {
            print("[StatLocker][Auth] GoogleService-Info.plist not found — using fallback config")
            configureWithFallback()
            return
        }
        
        guard let options = FirebaseOptions(contentsOfFile: path) else {
            print("[StatLocker][Auth] Failed to load Firebase options — using fallback config")
            configureWithFallback()
            return
        }
        
        FirebaseApp.configure(options: options)
        print("[StatLocker][Auth] Firebase configured successfully")
    }
    
    private func configureWithFallback() {
        // Fallback configuration for development
        let options = FirebaseOptions(googleAppID: "1:454030243479:ios:695cd340d53344486c1bd2",
                                    gcmSenderID: "454030243479")
        options.apiKey = "AIzaSyDkFOcjU04aONSbQWUu_KRtXLrLOxmBU5E"
        options.projectID = "the-statlocker"
        options.storageBucket = "the-statlocker.firebasestorage.app"
        options.databaseURL = "https://the-statlocker-default-rtdb.firebaseio.com"
        
        FirebaseApp.configure(options: options)
        print("[StatLocker][Auth] Firebase configured with fallback settings")
    }
}
