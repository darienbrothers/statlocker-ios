//
//  AuthView.swift
//  StatLocker
//
//  S-002 Auth screen per B-002 requirements. Apple/Google/Email sign-in with graceful fallbacks.
//

import SwiftUI
import AuthenticationServices

struct AuthView: View {
    @Environment(AuthService.self) private var authService
    @Environment(\.dismiss) private var dismiss
    
    @State private var email = ""
    @State private var password = ""
    @State private var isSignUp = false
    @State private var isLoading = false
    @State private var errorMessage = ""
    @State private var showError = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                // Header
                VStack(spacing: 8) {
                    Text("Welcome Back")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(.primary)
                    
                    Text(isSignUp ? "Create your StatLocker account" : "Sign in to continue tracking your stats")
                        .font(.system(size: 16))
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 40)
                
                Spacer()
                
                // Auth Methods
                VStack(spacing: 16) {
                    // Apple Sign In
                    SignInWithAppleButton(
                        onRequest: { request in
                            request.requestedScopes = [.fullName, .email]
                        },
                        onCompletion: { result in
                            handleAppleSignIn(result)
                        }
                    )
                    .signInWithAppleButtonStyle(.black)
                    .frame(height: 50)
                    .cornerRadius(12)
                    
                    // Google Sign In
                    Button(action: handleGoogleSignIn) {
                        HStack {
                            Image(systemName: "globe")
                                .foregroundStyle(.primary)
                            Text("Continue with Google")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundStyle(.primary)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color(uiColor: .systemGray6))
                        .cornerRadius(12)
                    }
                    .disabled(isLoading)
                    
                    // Divider
                    HStack {
                        Rectangle()
                            .frame(height: 1)
                            .foregroundStyle(.secondary.opacity(0.3))
                        Text("or")
                            .font(.system(size: 14))
                            .foregroundStyle(.secondary)
                            .padding(.horizontal, 16)
                        Rectangle()
                            .frame(height: 1)
                            .foregroundStyle(.secondary.opacity(0.3))
                    }
                    
                    // Email/Password Form
                    VStack(spacing: 16) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Email")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundStyle(.primary)
                            
                            TextField("Enter your email", text: $email)
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Password")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundStyle(.primary)
                            
                            SecureField("Enter your password", text: $password)
                                .textFieldStyle(.roundedBorder)
                        }
                        
                        // Sign In/Up Button
                        Button(action: handleEmailAuth) {
                            HStack {
                                if isLoading {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                        .scaleEffect(0.8)
                                }
                                Text(isSignUp ? "Create Account" : "Sign In")
                                    .font(.system(size: 16, weight: .semibold))
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(email.isEmpty || password.isEmpty ? Color.gray : Color.blue)
                            .foregroundStyle(.white)
                            .cornerRadius(12)
                        }
                        .disabled(email.isEmpty || password.isEmpty || isLoading)
                        
                        // Toggle Sign In/Up
                        Button(action: { isSignUp.toggle() }) {
                            Text(isSignUp ? "Already have an account? Sign In" : "Don't have an account? Sign Up")
                                .font(.system(size: 14))
                                .foregroundStyle(.blue)
                        }
                        
                        // Forgot Password
                        if !isSignUp {
                            Button(action: handleForgotPassword) {
                                Text("Forgot Password?")
                                    .font(.system(size: 14))
                                    .foregroundStyle(.blue)
                            }
                        }
                    }
                }
                .padding(.horizontal, 24)
                
                Spacer()
                
                // Footer
                VStack(spacing: 8) {
                    Text("By continuing, you agree to our")
                        .font(.system(size: 12))
                        .foregroundStyle(.secondary)
                    
                    HStack(spacing: 4) {
                        Button("Terms of Service") {
                            // Handle terms
                        }
                        .font(.system(size: 12))
                        .foregroundStyle(.blue)
                        
                        Text("and")
                            .font(.system(size: 12))
                            .foregroundStyle(.secondary)
                        
                        Button("Privacy Policy") {
                            // Handle privacy
                        }
                        .font(.system(size: 12))
                        .foregroundStyle(.blue)
                    }
                }
                .padding(.bottom, 20)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
        .alert("Error", isPresented: $showError) {
            Button("OK") { }
        } message: {
            Text(errorMessage)
        }
    }
    
    // MARK: - Auth Handlers
    
    private func handleAppleSignIn(_ result: Result<ASAuthorization, Error>) {
        Task {
            do {
                isLoading = true
                _ = try await authService.signInWithApple()
                await MainActor.run {
                    dismiss()
                }
            } catch {
                await MainActor.run {
                    showError(error)
                }
            }
        }
    }
    
    private func handleGoogleSignIn() {
        Task {
            do {
                isLoading = true
                _ = try await authService.signInWithGoogle()
                await MainActor.run {
                    dismiss()
                }
            } catch {
                await MainActor.run {
                    showError(error)
                }
            }
        }
    }
    
    private func handleEmailAuth() {
        Task {
            do {
                isLoading = true
                if isSignUp {
                    _ = try await authService.signUpWithEmail(email: email, password: password)
                } else {
                    _ = try await authService.signInWithEmail(email: email, password: password)
                }
                await MainActor.run {
                    dismiss()
                }
            } catch {
                await MainActor.run {
                    showError(error)
                }
            }
        }
    }
    
    private func handleForgotPassword() {
        guard !email.isEmpty else {
            errorMessage = "Please enter your email address first"
            showError = true
            return
        }
        
        Task {
            do {
                try await authService.resetPassword(email: email)
                await MainActor.run {
                    errorMessage = "Password reset email sent to \(email)"
                    showError = true
                }
            } catch {
                await MainActor.run {
                    showError(error)
                }
            }
        }
    }
    
    private func showError(_ error: Error) {
        isLoading = false
        errorMessage = error.localizedDescription
        showError = true
        print("[StatLocker][Auth] Error: \(error.localizedDescription)")
    }
}

#Preview {
    AuthView()
        .environment(AuthService())
}


