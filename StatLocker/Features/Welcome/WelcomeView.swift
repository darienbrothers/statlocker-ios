//
//  WelcomeView.swift
//  StatLocker
//
//  S-001 Welcome screen per B-002. Uses system fonts, theme colors, and a background image with opacity.
//

import SwiftUI
import UIKit

struct WelcomeScreen: View {
    @State private var isAuthPresented = false
    @State private var currentPage = 0
    @State private var authService = AuthService()
    
    private let totalPages = 4
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 0) {
                ZStack(alignment: .bottom) {
                    Image("AthleteBG")
                        .resizable()
                        .scaledToFill()
                        .frame(height: UIScreen.main.bounds.height * 0.7)
                        .clipped()

                    LinearGradient(colors: [Color.clear, Color.black.opacity(0.2), Color.black.opacity(0.6), .black], startPoint: .top, endPoint: .bottom)
                        .frame(height: UIScreen.main.bounds.height * 0.35)
                }
                Spacer()
            }

            LinearGradient(colors: [Color.clear, Color.clear, Color.black.opacity(0.25), Color.black.opacity(0.7), .black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            content
        }
        .onAppear { print("[StatLocker][Welcome] Appeared") }
    }

    private var content: some View {
        VStack(alignment: .center, spacing: 0) {
            // Flexible top spacing
            Spacer(minLength: 60)

            // Page content
            TabView(selection: $currentPage) {
                // Page 1: Welcome
                VStack(spacing: 14) {
                    Text("Your Game. Your Stats. Your Story.")
                        .font(.system(size: 28, weight: .bold))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color.white)
                        .padding(.horizontal, 20)
                        .minimumScaleFactor(0.8)
                        .lineLimit(3)

                    Text("Discover how StatLocker helps you track official games and improve.")
                        .font(.system(size: 15))
                        .foregroundStyle(Color.white.opacity(0.85))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                        .minimumScaleFactor(0.8)
                        .lineLimit(4)

                    Text("Swipe to explore! →")
                        .font(.system(size: 14))
                        .foregroundStyle(Color.white.opacity(0.85))
                        .multilineTextAlignment(.center)
                        .minimumScaleFactor(0.8)
                }
                .tag(0)

                // Page 2: TrackSmarter
                VStack(spacing: 12) {
                    Spacer(minLength: 60) // Reduced space for visuals
                    
                    Text("Track your performance, effortlessly.")
                        .font(.system(size: 28, weight: .bold))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color.white)
                        .padding(.horizontal, 20)
                        .minimumScaleFactor(0.8)
                        .lineLimit(3)

                    Text("Log your stats after every game — StatLocker turns your numbers into a story you can see")
                        .font(.system(size: 15))
                        .foregroundStyle(Color.white.opacity(0.85))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                        .minimumScaleFactor(0.8)
                        .lineLimit(4)
                }
                .tag(1)

                // Page 3: UnlockAIInsights
                VStack(spacing: 12) {
                    Spacer(minLength: 60) // Reduced space for visuals
                    
                    Text("See patterns. Find your edge.")
                        .font(.system(size: 28, weight: .bold))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color.white)
                        .padding(.horizontal, 20)
                        .minimumScaleFactor(0.8)
                        .lineLimit(3)

                    Text("AI-powered insights reveal trends, strengths, and areas for improvement — giving you the data to perform at your best.")
                        .font(.system(size: 15))
                        .foregroundStyle(Color.white.opacity(0.85))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                        .minimumScaleFactor(0.8)
                        .lineLimit(4)
                }
                .tag(2)

                // Page 4: StayOrganizedAndMotivated
                VStack(spacing: 12) {
                    Spacer(minLength: 60) // Reduced space for visuals
                    
                    Text("Stay organized. Stay locked in.")
                        .font(.system(size: 28, weight: .bold))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color.white)
                        .padding(.horizontal, 20)
                        .minimumScaleFactor(0.8)
                        .lineLimit(3)

                    Text("Plan your recruiting journey, set season goals, and earn badges as you improve — everything you need to stay focused and motivated.")
                        .font(.system(size: 15))
                        .foregroundStyle(Color.white.opacity(0.85))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                        .minimumScaleFactor(0.8)
                        .lineLimit(4)
                }
                .tag(3)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(maxHeight: 200) // Flexible height

            // Push buttons to bottom
            Spacer()

            // Pagination dots
            HStack(spacing: 8) {
                ForEach(0..<totalPages, id: \.self) { index in
                    Circle()
                        .fill(index == currentPage ? Color.white : Color.white.opacity(0.35))
                        .frame(width: 8, height: 8)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                currentPage = index
                            }
                        }
                }
            }
            .padding(.bottom, 16)

            // Bottom-anchored buttons
            VStack(spacing: 12) {
                Button(action: {
                    print("[StatLocker][Welcome] Get Started tapped")
                    isAuthPresented = true
                }) {
                    Text("Get Started")
                        .font(.system(size: 18, weight: .semibold))
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(
                            LinearGradient(colors: [Color(red: 0.31, green: 0.27, blue: 0.90), Color(red: 0.18, green: 0.22, blue: 0.79)], startPoint: .leading, endPoint: .trailing)
                        )
                        .foregroundStyle(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: 28, style: .continuous)
                                .stroke(Color.white.opacity(0.15), lineWidth: 1)
                        )
                        .contentShape(Rectangle())
                }
                .padding(.horizontal, 20)
                .accessibilityLabel("Get Started")

                // Quick Sign In Options
                VStack(spacing: 8) {
                    Text("Quick Sign In")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(Color.white.opacity(0.8))
                    
                    HStack(spacing: 12) {
                        // Apple Sign In
                        Button(action: {
                            Task {
                                do {
                                    _ = try await authService.signInWithApple()
                                    print("[StatLocker][Welcome] Apple Sign In successful")
                                } catch {
                                    print("[StatLocker][Welcome] Apple Sign In failed: \(error.localizedDescription)")
                                }
                            }
                        }) {
                            Image(systemName: "applelogo")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundStyle(Color.white)
                                .frame(width: 44, height: 44)
                                .background(Color.black)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                                )
                        }
                        .accessibilityLabel("Sign in with Apple")
                        
                        // Google Sign In
                        Button(action: {
                            Task {
                                do {
                                    _ = try await authService.signInWithGoogle()
                                    print("[StatLocker][Welcome] Google Sign In successful")
                                } catch {
                                    print("[StatLocker][Welcome] Google Sign In failed: \(error.localizedDescription)")
                                }
                            }
                        }) {
                            Image(systemName: "globe")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundStyle(Color.white)
                                .frame(width: 44, height: 44)
                                .background(Color.red)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                                )
                        }
                        .accessibilityLabel("Sign in with Google")
                    }
                }

                Button(action: {
                    print("[StatLocker][Welcome] Log In tapped")
                    isAuthPresented = true
                }) {
                    HStack(spacing: 4) {
                        Text("Already have an account?")
                            .font(.system(size: 15))
                            .foregroundStyle(Color.white.opacity(0.8))
                        Text("Log In")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(Color.white)
                    }
                }
                .padding(.bottom, 20)
            }
        }
        .sheet(isPresented: $isAuthPresented) {
            AuthView()
        }
    }
}

#Preview {
    WelcomeScreen()
}
