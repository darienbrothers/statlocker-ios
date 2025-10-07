//
//  AuthService.swift
//  StatLocker
//
//  Authentication service with Apple/Google/Email sign-in per B-002 requirements.
//  Protocol-based with graceful fallbacks and debug logs.
//

import Foundation
import FirebaseAuth
import AuthenticationServices
import GoogleSignIn
import SwiftUI

// MARK: - Auth Protocol

protocol AuthServiceProtocol {
    var currentUser: User? { get }
    var isAuthenticated: Bool { get }
    
    func signInWithApple() async throws -> User
    func signInWithGoogle() async throws -> User
    func signInWithEmail(email: String, password: String) async throws -> User
    func signUpWithEmail(email: String, password: String) async throws -> User
    func signOut() async throws
    func resetPassword(email: String) async throws
}

// MARK: - Auth Service Implementation

class AuthService: AuthServiceProtocol, ObservableObject {
    @Published var currentUser: User?
    @Published var isAuthenticated = false
    
    private let auth = Auth.auth()
    
    init() {
        setupAuthStateListener()
        print("[StatLocker][Auth] AuthService initialized")
    }
    
    private func setupAuthStateListener() {
        auth.addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                self?.currentUser = user
                self?.isAuthenticated = user != nil
                print("[StatLocker][Auth] Auth state changed - authenticated: \(user != nil)")
            }
        }
    }
    
    // MARK: - Apple Sign In
    
    func signInWithApple() async throws -> User {
        print("[StatLocker][Auth] Starting Apple Sign In")
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        
        return try await withCheckedThrowingContinuation { continuation in
            let delegate = AppleSignInDelegate { result in
                continuation.resume(with: result)
            }
            
            authorizationController.delegate = delegate
            authorizationController.presentationContextProvider = delegate
            authorizationController.performRequests()
        }
    }
    
    // MARK: - Google Sign In
    
    func signInWithGoogle() async throws -> User {
        print("[StatLocker][Auth] Starting Google Sign In")
        
        guard let presentingViewController = UIApplication.shared.windows.first?.rootViewController else {
            throw AuthError.noPresentingViewController
        }
        
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            throw AuthError.missingClientID
        }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController)
        
        guard let idToken = result.user.idToken?.tokenString else {
            throw AuthError.missingIDToken
        }
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: result.user.accessToken.tokenString)
        
        let authResult = try await auth.signIn(with: credential)
        print("[StatLocker][Auth] Google Sign In successful")
        
        return authResult.user
    }
    
    // MARK: - Email/Password Auth
    
    func signInWithEmail(email: String, password: String) async throws -> User {
        print("[StatLocker][Auth] Starting Email Sign In")
        
        let result = try await auth.signIn(withEmail: email, password: password)
        print("[StatLocker][Auth] Email Sign In successful")
        
        return result.user
    }
    
    func signUpWithEmail(email: String, password: String) async throws -> User {
        print("[StatLocker][Auth] Starting Email Sign Up")
        
        let result = try await auth.createUser(withEmail: email, password: password)
        print("[StatLocker][Auth] Email Sign Up successful")
        
        return result.user
    }
    
    func signOut() async throws {
        print("[StatLocker][Auth] Signing out")
        try auth.signOut()
        print("[StatLocker][Auth] Sign out successful")
    }
    
    func resetPassword(email: String) async throws {
        print("[StatLocker][Auth] Resetting password for: \(email)")
        try await auth.sendPasswordReset(withEmail: email)
        print("[StatLocker][Auth] Password reset email sent")
    }
}

// MARK: - Apple Sign In Delegate

private class AppleSignInDelegate: NSObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    private let completion: (Result<User, Error>) -> Void
    
    init(completion: @escaping (Result<User, Error>) -> Void) {
        self.completion = completion
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
              let identityToken = appleIDCredential.identityToken,
              let identityTokenString = String(data: identityToken, encoding: .utf8) else {
            completion(.failure(AuthError.missingAppleCredential))
            return
        }
        
        let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: identityTokenString, rawNonce: nil)
        
        Task {
            do {
                let result = try await Auth.auth().signIn(with: credential)
                await MainActor.run {
                    completion(.success(result.user))
                }
            } catch {
                await MainActor.run {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        completion(.failure(error))
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return UIApplication.shared.windows.first { $0.isKeyWindow } ?? ASPresentationAnchor()
    }
}

// MARK: - Auth Errors

enum AuthError: LocalizedError {
    case noPresentingViewController
    case missingClientID
    case missingIDToken
    case missingAppleCredential
    case invalidEmail
    case weakPassword
    case userNotFound
    case wrongPassword
    case emailAlreadyInUse
    case networkError
    
    var errorDescription: String? {
        switch self {
        case .noPresentingViewController:
            return "Unable to present sign-in interface"
        case .missingClientID:
            return "Missing Google client ID"
        case .missingIDToken:
            return "Missing Google ID token"
        case .missingAppleCredential:
            return "Missing Apple credential"
        case .invalidEmail:
            return "Invalid email address"
        case .weakPassword:
            return "Password is too weak"
        case .userNotFound:
            return "No account found with this email"
        case .wrongPassword:
            return "Incorrect password"
        case .emailAlreadyInUse:
            return "Email is already in use"
        case .networkError:
            return "Network connection error"
        }
    }
}

// MARK: - Mock Auth Service for Development

class MockAuthService: AuthServiceProtocol {
    var currentUser: User? = nil
    var isAuthenticated: Bool = false
    
    func signInWithApple() async throws -> User {
        print("[StatLocker][Auth] Mock Apple Sign In")
        throw AuthError.networkError
    }
    
    func signInWithGoogle() async throws -> User {
        print("[StatLocker][Auth] Mock Google Sign In")
        throw AuthError.networkError
    }
    
    func signInWithEmail(email: String, password: String) async throws -> User {
        print("[StatLocker][Auth] Mock Email Sign In")
        throw AuthError.networkError
    }
    
    func signUpWithEmail(email: String, password: String) async throws -> User {
        print("[StatLocker][Auth] Mock Email Sign Up")
        throw AuthError.networkError
    }
    
    func signOut() async throws {
        print("[StatLocker][Auth] Mock Sign Out")
    }
    
    func resetPassword(email: String) async throws {
        print("[StatLocker][Auth] Mock Password Reset")
    }
}
