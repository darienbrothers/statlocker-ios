//
//  WelcomeView.swift
//  StatLocker
//
//  S-001 Welcome screen per B-002. Clean athlete background with headline, tagline, and CTA buttons.
//

import SwiftUI
import UIKit

struct WelcomeScreen: View {
    @State private var isAuthPresented = false
    @Environment(AuthService.self) private var authService
    
    var body: some View {
        ZStack {
            // Background image - full screen with subtle dark overlay
            Image("AthleteBG")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .clipped()
                .overlay(
                    Color.black.opacity(0.4) // Subtle overlay for text readability
                )
                .ignoresSafeArea()
            
            // Main content - positioned in lower portion like the reference image
            VStack(spacing: 0) {
                Spacer(minLength: 100)
                
                // Welcome headline
                Text("Welcome to StatLocker")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundStyle(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                    .shadow(color: Color.black.opacity(0.5), radius: 8, x: 0, y: 2)
                
                Spacer(minLength: 20)
                
                // Tagline
                Text("Your Game. Your Stats. Your Story.")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                    .shadow(color: Color.black.opacity(0.5), radius: 6, x: 0, y: 2)
                
                Spacer(minLength: 40)
                
                // CTA section
                VStack(spacing: 20) {
                    // Get Started button - full width with our theme gradient
                    Button(action: {
                        print("[StatLocker][Welcome] Get Started tapped")
                        isAuthPresented = true
                    }) {
                        Text("Get Started")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(Color.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(
                                LinearGradient(
                                    colors: [
                                        Color(red: 0.31, green: 0.27, blue: 0.90),
                                        Color(red: 0.18, green: 0.22, blue: 0.79)
                                    ],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
                            .contentShape(Rectangle())
                            .shadow(color: Color.black.opacity(0.3), radius: 8, x: 0, y: 4)
                    }
                    .padding(.horizontal, 30)
                    .accessibilityLabel("Get Started")
                    
                    // Log In text link - bold and white
                    Button(action: {
                        print("[StatLocker][Welcome] Log In tapped")
                        isAuthPresented = true
                    }) {
                        Text("Already have an account? Log In")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(Color.white)
                            .multilineTextAlignment(.center)
                    }
                    .accessibilityLabel("Log In")
                }
                
                Spacer(minLength: 50)
            }
        }
        .onAppear { print("[StatLocker][Welcome] Appeared") }
        .sheet(isPresented: $isAuthPresented) {
            AuthView()
                .environment(authService)
        }
    }
}

#Preview {
    WelcomeScreen()
        .environment(AuthService())
}
