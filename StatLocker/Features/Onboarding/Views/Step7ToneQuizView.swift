//
//  Step7ToneQuizView.swift
//  StatLocker
//
//  Step 7 of onboarding: AI Coach tone selection.
//  Shows 4 tone options with example copy per B-003.
//

import SwiftUI
import FirebaseAuth

struct Step7ToneQuizView: View {
    @Bindable var viewModel: OnboardingViewModel
    
    private let toneOptions: [ToneOption] = [
        ToneOption(
            id: "Hype",
            name: "Hype",
            icon: "🔥",
            example: "You brought it today. Keep that edge."
        ),
        ToneOption(
            id: "Mentor",
            name: "Mentor",
            icon: "🎯",
            example: "Strong step forward. Let's compound it."
        ),
        ToneOption(
            id: "Analyst",
            name: "Analyst",
            icon: "📊",
            example: "Save% +7 vs season avg. Lateral speed trending up."
        ),
        ToneOption(
            id: "Captain",
            name: "Captain",
            icon: "⚡️",
            example: "Leaders show up—keep stacking wins."
        )
    ]
    
    var body: some View {
        VStack(spacing: Theme.Spacing.xl) {
            Spacer()
            
            // MARK: - Header
            VStack(spacing: Theme.Spacing.md) {
                Text("How should your AI coach talk to you?")
                    .font(Theme.Typography.headline(28))
                    .foregroundStyle(Theme.Colors.textPrimary)
                    .multilineTextAlignment(.center)
                    .accessibilityAddTraits(.isHeader)
                
                Text("Choose the coaching style that motivates you most")
                    .font(Theme.Typography.body(16))
                    .foregroundStyle(Theme.Colors.textSecondary)
                    .multilineTextAlignment(.center)
            }
            
            // MARK: - Tone Cards
            VStack(spacing: Theme.Spacing.md) {
                ForEach(toneOptions) { tone in
                    ToneSelectionCard(
                        tone: tone,
                        isSelected: viewModel.aiTone == tone.id,
                        action: {
                            viewModel.aiTone = tone.id
                            print("[StatLocker][Onboarding] Tone selected: \(tone.id)")
                        }
                    )
                }
            }
            .padding(.horizontal, Theme.Spacing.xl)
            
            Spacer()
            
            // Helper Text
            Text("You can change this anytime in Settings.")
                .font(Theme.Typography.caption(14))
                .foregroundStyle(Theme.Colors.textTertiary)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.horizontal, Theme.Spacing.xl)
        }
        .padding(Theme.Spacing.xl)
        .background(Theme.Colors.backgroundPrimary)
    }
}

// MARK: - Tone Option Model

struct ToneOption: Identifiable {
    let id: String
    let name: String
    let icon: String
    let example: String
}

// MARK: - Tone Selection Card Component

struct ToneSelectionCard: View {
    let tone: ToneOption
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: Theme.Spacing.md) {
                // Header
                HStack(spacing: Theme.Spacing.sm) {
                    Text(tone.icon)
                        .font(.system(size: 28))
                    
                    Text(tone.name)
                        .font(Theme.Typography.body(18))
                        .fontWeight(isSelected ? .semibold : .medium)
                        .foregroundStyle(Theme.Colors.textPrimary)
                    
                    Spacer()
                    
                    if isSelected {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 24))
                            .foregroundStyle(Theme.Colors.primary)
                    } else {
                        Image(systemName: "circle")
                            .font(.system(size: 24))
                            .foregroundStyle(Theme.Colors.divider)
                    }
                }
                
                // Example Copy
                Text(tone.example)
                    .font(Theme.Typography.body(15))
                    .foregroundStyle(Theme.Colors.textSecondary)
                    .italic()
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(Theme.Spacing.lg)
            .background(Theme.Colors.backgroundSecondary)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(
                        isSelected ? Theme.Colors.primary : Theme.Colors.divider,
                        lineWidth: isSelected ? 2 : 1
                    )
            )
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .scaleEffect(isSelected ? 1.02 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: isSelected)
        }
        .buttonStyle(.plain)
        .accessibilityLabel("\(tone.name) tone")
        .accessibilityValue("Example: \(tone.example)")
        .accessibilityAddTraits(isSelected ? [.isSelected, .isButton] : .isButton)
    }
}

// MARK: - Preview

#Preview("Step 7 - Not Selected") {
    Step7ToneQuizView(viewModel: OnboardingViewModel(userId: "preview", displayName: "John Doe", email: "john@example.com"))
}

#Preview("Step 7 - Hype Selected") {
    let vm = OnboardingViewModel(userId: "preview", displayName: "John Doe", email: "john@example.com")
    vm.aiTone = "Hype"
    return Step7ToneQuizView(viewModel: vm)
}

