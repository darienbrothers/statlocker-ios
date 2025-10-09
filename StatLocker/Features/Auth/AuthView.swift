//
//  AuthView.swift
//  StatLocker
//
//  S-002 Auth screen per B-002 requirements. Modern design with tab-based navigation and social sign-in.
//

import SwiftUI
import AuthenticationServices

struct AuthView: View {
    @Environment(AuthService.self) private var authService
    @Environment(\.dismiss) private var dismiss
    
    @State private var email = ""
    @State private var password = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var isSignUp = false
    @State private var isLoading = false
    @State private var errorMessage = ""
    @State private var showError = false
    @State private var showPassword = false
    
    var body: some View {
        ZStack {
            // Light background
            Color(uiColor: .systemBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Logo section at top
                logoSection
                    .padding(.top, 60)
                
                Spacer(minLength: 40)
                
                // Header section
                headerSection
                
                Spacer(minLength: 20)
                
                // Tab switcher
                tabSwitcher
                
                Spacer(minLength: 32)
                
                // Form content based on selected tab
                formContent
                
                Spacer()
                
                // Social sign-in section
                socialSignInSection
                
                Spacer(minLength: 20)
                
                // Footer
                footerSection
                    .padding(.bottom, 40)
            }
            .padding(.horizontal, 24)
        }
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                Button("Done") {
                    hideKeyboard()
                }
            }
        }
        .alert("Error", isPresented: $showError) {
            Button("OK") { }
        } message: {
            Text(errorMessage)
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    // MARK: - Logo Section
    private var logoSection: some View {
        Image("LogoBlack")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 220)
    }
    
    // MARK: - Header Section
    private var headerSection: some View {
        VStack(spacing: 8) {
            Text(isSignUp ? "Create Your Account" : "Welcome Back")
                .font(.system(size: 28, weight: .bold))
                .foregroundStyle(.primary)
            
            Text("Track Faster. Improve Smarter.")
                .font(.system(size: 16, weight: .regular))
                .foregroundStyle(.secondary)
        }
    }
    
    // MARK: - Tab Switcher
    private var tabSwitcher: some View {
        HStack(spacing: 0) {
            // Sign In Tab
            Button(action: {
                withAnimation(.easeInOut(duration: 0.2)) {
                    isSignUp = false
                }
                print("[StatLocker][Auth] Switched to Sign In tab")
            }) {
                Text("Sign In")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(isSignUp ? .secondary : Color.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 44)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(isSignUp ? Color.clear : Color(red: 0.31, green: 0.27, blue: 0.90))
                    )
            }
            .accessibilityLabel("Sign In tab")
            
            // Create Account Tab
            Button(action: {
                withAnimation(.easeInOut(duration: 0.2)) {
                    isSignUp = true
                }
                print("[StatLocker][Auth] Switched to Create Account tab")
            }) {
                Text("Create Account")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(isSignUp ? Color.white : .secondary)
                    .frame(maxWidth: .infinity)
                    .frame(height: 44)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(isSignUp ? Color(red: 0.31, green: 0.27, blue: 0.90) : Color.clear)
                    )
            }
            .accessibilityLabel("Create Account tab")
        }
        .padding(4)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(uiColor: .systemGray6))
        )
    }
    
    // MARK: - Form Content
    private var formContent: some View {
        VStack(spacing: 20) {
            if isSignUp {
                // Create Account Form
                createAccountForm
            } else {
                // Sign In Form
                signInForm
            }
        }
    }
    
    // MARK: - Sign In Form
    private var signInForm: some View {
        VStack(spacing: 16) {
            // Email field
            customTextField(
                placeholder: "Email",
                text: $email,
                keyboardType: .emailAddress
            )
            
            // Password field with toggle
            passwordField
            
            // Sign In button
            primaryButton(
                title: "Sign In",
                action: handleEmailAuth,
                isEnabled: !email.isEmpty && !password.isEmpty
            )
            
            // Forgot Password link
            Button(action: handleForgotPassword) {
                Text("Forgot Password?")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(Color(red: 0.31, green: 0.27, blue: 0.90))
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            // Sign up link
            Button(action: {
                withAnimation(.easeInOut(duration: 0.2)) {
                    isSignUp = true
                }
            }) {
                Text("Need an account? Sign up")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(Color(red: 0.31, green: 0.27, blue: 0.90))
            }
        }
    }
    
    // MARK: - Create Account Form
    private var createAccountForm: some View {
        VStack(spacing: 16) {
            // Name fields
            HStack(spacing: 12) {
                customTextField(
                    placeholder: "First name",
                    text: $firstName,
                    keyboardType: .default
                )
                .frame(maxWidth: .infinity)
                
                customTextField(
                    placeholder: "Last name",
                    text: $lastName,
                    keyboardType: .default
                )
                .frame(maxWidth: .infinity)
            }
            
            // Email field
            customTextField(
                placeholder: "Email",
                text: $email,
                keyboardType: .emailAddress
            )
            
            // Password field with toggle
            passwordField
            
            // Create Account button
            primaryButton(
                title: "Create Account",
                action: handleEmailAuth,
                isEnabled: !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty && !password.isEmpty
            )
            
            // Sign in link
            Button(action: {
                withAnimation(.easeInOut(duration: 0.2)) {
                    isSignUp = false
                }
            }) {
                Text("Have an account? Sign in")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(Color(red: 0.31, green: 0.27, blue: 0.90))
            }
        }
    }
    
    // MARK: - Password Field
    private var passwordField: some View {
        HStack {
            if showPassword {
                TextField("Password", text: $password)
                    .font(.system(size: 16))
            } else {
                SecureField("Password", text: $password)
                    .font(.system(size: 16))
            }
            
            Button(action: {
                showPassword.toggle()
            }) {
                Image(systemName: showPassword ? "eye.fill" : "eye.slash.fill")
                    .foregroundStyle(showPassword ? Color(red: 0.31, green: 0.27, blue: 0.90) : .secondary)
                    .font(.system(size: 16))
            }
            .accessibilityLabel(showPassword ? "Hide password" : "Show password")
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(uiColor: .systemGray6))
        )
    }
    
    // MARK: - Custom Text Field
    private func customTextField(placeholder: String, text: Binding<String>, keyboardType: UIKeyboardType) -> some View {
        TextField(placeholder, text: text)
            .font(.system(size: 16))
            .keyboardType(keyboardType)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(uiColor: .systemGray6))
            )
    }
    
    // MARK: - Primary Button
    private func primaryButton(title: String, action: @escaping () -> Void, isEnabled: Bool) -> some View {
        Button(action: action) {
            HStack {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(0.8)
                } else {
                    Text(title)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.white)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(red: 0.31, green: 0.27, blue: 0.90),
                                Color(red: 0.18, green: 0.22, blue: 0.79)
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
            )
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        }
        .disabled(!isEnabled || isLoading)
        .accessibilityLabel(title)
    }
    
    // MARK: - Social Sign In Section
    private var socialSignInSection: some View {
        VStack(spacing: 20) {
            // Divider
            HStack {
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.secondary.opacity(0.3))
                Text("or")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 16)
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.secondary.opacity(0.3))
            }
            
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
            .frame(height: 56)
            .cornerRadius(12)
            .disabled(isLoading)
            
            // Google Sign In
            Button(action: handleGoogleSignIn) {
                HStack(spacing: 12) {
                    Image(systemName: "g.circle.fill")
                        .font(.system(size: 20))
                        .foregroundStyle(.white)
                    
                    Text("Continue with Google")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.white)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(Color.black)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                )
            }
            .disabled(isLoading)
            .accessibilityLabel("Continue with Google")
        }
    }
    
    // MARK: - Footer Section
    private var footerSection: some View {
        VStack(spacing: 8) {
            Text("By continuing, you agree to our")
                .font(.system(size: 12))
                .foregroundStyle(.secondary)
            
            HStack(spacing: 4) {
                Button("Terms of Service") {
                    // Handle terms
                    print("[StatLocker][Auth] Terms of Service tapped")
                }
                .font(.system(size: 12))
                .foregroundStyle(Color(red: 0.31, green: 0.27, blue: 0.90))
                
                Text("and")
                    .font(.system(size: 12))
                    .foregroundStyle(.secondary)
                
                Button("Privacy Policy") {
                    // Handle privacy
                    print("[StatLocker][Auth] Privacy Policy tapped")
                }
                .font(.system(size: 12))
                .foregroundStyle(Color(red: 0.31, green: 0.27, blue: 0.90))
            }
        }
    }
    
    // MARK: - Auth Handlers
    
    private func handleAppleSignIn(_ result: Result<ASAuthorization, Error>) {
        Task {
            do {
                isLoading = true
                print("[StatLocker][Auth] Apple Sign In initiated")
                _ = try await authService.signInWithApple()
                await MainActor.run {
                    print("[StatLocker][Auth] Apple Sign In successful")
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
                print("[StatLocker][Auth] Google Sign In initiated")
                _ = try await authService.signInWithGoogle()
                await MainActor.run {
                    print("[StatLocker][Auth] Google Sign In successful")
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
                    print("[StatLocker][Auth] Creating account with email: \(email)")
                    _ = try await authService.signUpWithEmail(email: email, password: password)
                } else {
                    print("[StatLocker][Auth] Signing in with email: \(email)")
                    _ = try await authService.signInWithEmail(email: email, password: password)
                }
                await MainActor.run {
                    print("[StatLocker][Auth] Email auth successful")
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
                print("[StatLocker][Auth] Sending password reset to: \(email)")
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
    
    // MARK: - Utility Functions
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    AuthView()
        .environment(AuthService())
}


