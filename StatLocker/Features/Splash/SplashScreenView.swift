//
//  SplashScreenView.swift
//  StatLocker
//
//  Premium splash screen with logo animation and loading indicator.
//  Matches design specification with black background and white elements.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var logoScale: CGFloat = 1.0
    @State private var logoOpacity: Double = 1.0 // Start visible for debugging
    @State private var loadingOpacity: Double = 0.0
    
    var body: some View {
        ZStack {
            // Black background
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top spacer
                Spacer()
                
                // Logo section - centered in middle of screen
                VStack(spacing: 0) {
                    Image("BrandLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 360) // 3x bigger logo
                        .scaleEffect(logoScale)
                        .opacity(logoOpacity)
                        .accessibilityLabel("StatLocker logo")
                        .onAppear {
                            print("[StatLocker][Splash] Logo appeared")
                        }
                }
                
                // Bottom spacer
                Spacer()
                
                // Loading section at bottom
                VStack(spacing: 16) {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(1.2)
                        .opacity(loadingOpacity)
                    
                    Text("Loading...")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.white)
                        .opacity(loadingOpacity)
                }
                .padding(.bottom, 100) // Space above home indicator
            }
        }
        .onAppear {
            startAnimations()
        }
    }
    
    private func startAnimations() {
        print("[StatLocker][Splash] Starting animations")
        
        // Logo is already visible, just add subtle scale animation
        withAnimation(.easeInOut(duration: 2.0).delay(0.5)) {
            logoScale = 1.05
        }
        
        withAnimation(.easeInOut(duration: 1.5).delay(2.5)) {
            logoScale = 1.0
        }
        
        // Loading indicator fade-in
        withAnimation(.easeInOut(duration: 0.6).delay(0.8)) {
            loadingOpacity = 1.0
        }
    }
}

// MARK: - Preview

#Preview {
    SplashScreenView()
        .preferredColorScheme(.dark)
}
