//
//  Step2TeamGenderView.swift
//  StatLocker
//
//  Step 2 of onboarding: Team gender selection (Boys/Girls).
//  Clean, Calm-inspired design with accessibility support.
//

import SwiftUI

struct Step2TeamGenderView: View {
    @Bindable var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            // MARK: - Header
            
            VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                Text("Let's build your Locker")
                    .font(Theme.Typography.headline(28))
                    .foregroundStyle(Theme.Colors.textPrimary)
                    .accessibilityAddTraits(.isHeader)
                
                Text("Every stat tells your story — start with the basics.")
                    .font(Theme.Typography.body(16))
                    .foregroundStyle(Theme.Colors.textSecondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.horizontal, Theme.Spacing.xl)
            .padding(.top, Theme.Spacing.xxl)
            .padding(.bottom, Theme.Spacing.xl)
            
            Spacer()
                .frame(height: Theme.Spacing.xxl)
            
            // MARK: - Gender Selector
            
            VStack(alignment: .leading, spacing: Theme.Spacing.md) {
                
                // Gender Segmented Control
                HStack(spacing: Theme.Spacing.sm) {
                    
                    // Boys Button
                    GenderButton(
                        title: "Boys",
                        isSelected: viewModel.teamGender == "boys",
                        action: {
                            viewModel.teamGender = "boys"
                            print("[StatLocker][Onboarding] Gender selected: boys")
                        }
                    )
                    
                    // Girls Button
                    GenderButton(
                        title: "Girls",
                        isSelected: viewModel.teamGender == "girls",
                        action: {
                            viewModel.teamGender = "girls"
                            print("[StatLocker][Onboarding] Gender selected: girls")
                        }
                    )
                }
                .padding(.horizontal, Theme.Spacing.xl)
                
                // Helper Text
                Text("This helps us show the right positions and benchmarks.")
                    .font(Theme.Typography.caption(14))
                    .foregroundStyle(Theme.Colors.muted)
                    .padding(.horizontal, Theme.Spacing.xl)
                    .padding(.top, Theme.Spacing.xs)
            }
            
            Spacer()
        }
    }
}

// MARK: - Gender Button Component

struct GenderButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(Theme.Typography.body(17))
                .fontWeight(isSelected ? .semibold : .regular)
                .foregroundStyle(isSelected ? .white : Theme.Colors.textPrimary)
                .frame(maxWidth: .infinity)
                .frame(height: 56) // 56pt for comfortable tap target
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(isSelected ? Theme.Colors.primary : Theme.Colors.cardSurface)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .stroke(isSelected ? Theme.Colors.primary : Theme.Colors.divider, lineWidth: isSelected ? 2 : 1)
                )
        }
        .buttonStyle(.plain)
        .accessibilityLabel("\(title) team")
        .accessibilityHint("Tap to select \(title.lowercased()) lacrosse")
        .accessibilityAddTraits(isSelected ? [.isSelected, .isButton] : .isButton)
    }
}

// MARK: - Preview

#Preview("Step 2 - Not Selected") {
    Step2TeamGenderView(viewModel: OnboardingViewModel(user: MockUser()))
        .background(Theme.Colors.background)
}

#Preview("Step 2 - Boys Selected") {
    let vm = OnboardingViewModel(user: MockUser())
    vm.teamGender = "boys"
    Step2TeamGenderView(viewModel: vm)
        .background(Theme.Colors.background)
}

// MARK: - Mock User for Previews

struct MockUser: User {
    var uid: String = "preview-user-123"
    var displayName: String? = "John Doe"
    var email: String? = "john@example.com"
    var phoneNumber: String?
    var photoURL: URL?
    var isAnonymous: Bool = false
    var isEmailVerified: Bool = false
    var metadata: UserMetadata = MockUserMetadata()
    var providerData: [UserInfo] = []
    var refreshToken: String?
    var tenantID: String?
    
    func reload() async throws {}
    func reload(completion: ((Error?) -> Void)?) {}
    func reauthenticate(with credential: AuthCredential) async throws -> AuthDataResult { throw NSError(domain: "", code: 0) }
    func reauthenticate(with credential: AuthCredential, completion: ((AuthDataResult?, Error?) -> Void)?) {}
    func getIDTokenResult() async throws -> AuthTokenResult { throw NSError(domain: "", code: 0) }
    func getIDTokenResult(completion: ((AuthTokenResult?, Error?) -> Void)?) {}
    func getIDTokenResult(forcingRefresh: Bool) async throws -> AuthTokenResult { throw NSError(domain: "", code: 0) }
    func getIDTokenResult(forcingRefresh: Bool, completion: ((AuthTokenResult?, Error?) -> Void)?) {}
    func getIDToken() async throws -> String { throw NSError(domain: "", code: 0) }
    func getIDToken(completion: ((String?, Error?) -> Void)?) {}
    func getIDTokenForcingRefresh(_ forceRefresh: Bool) async throws -> String { throw NSError(domain: "", code: 0) }
    func getIDTokenForcingRefresh(_ forceRefresh: Bool, completion: ((String?, Error?) -> Void)?) {}
    func link(with credential: AuthCredential) async throws -> AuthDataResult { throw NSError(domain: "", code: 0) }
    func link(with credential: AuthCredential, completion: ((AuthDataResult?, Error?) -> Void)?) {}
    func unlink(fromProvider provider: String) async throws -> User { throw NSError(domain: "", code: 0) }
    func unlink(fromProvider provider: String, completion: ((User?, Error?) -> Void)?) {}
    func sendEmailVerification() async throws {}
    func sendEmailVerification(completion: ((Error?) -> Void)?) {}
    func sendEmailVerification(with actionCodeSettings: ActionCodeSettings) async throws {}
    func sendEmailVerification(with actionCodeSettings: ActionCodeSettings?, completion: ((Error?) -> Void)?) {}
    func delete() async throws {}
    func delete(completion: ((Error?) -> Void)?) {}
    func updateEmail(to email: String) async throws {}
    func updateEmail(to email: String, completion: ((Error?) -> Void)?) {}
    func updatePassword(to password: String) async throws {}
    func updatePassword(to password: String, completion: ((Error?) -> Void)?) {}
    func createProfileChangeRequest() -> UserProfileChangeRequest { MockProfileChangeRequest() }
}

struct MockUserMetadata: UserMetadata {
    var lastSignInDate: Date?
    var creationDate: Date?
}

class MockProfileChangeRequest: UserProfileChangeRequest {
    override var displayName: String? {
        get { return nil }
        set {}
    }
    override var photoURL: URL? {
        get { return nil }
        set {}
    }
    override func commitChanges() async throws {}
    override func commitChanges(completion: ((Error?) -> Void)?) {}
}

