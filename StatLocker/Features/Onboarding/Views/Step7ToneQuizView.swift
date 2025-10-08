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
        VStack(alignment: .leading, spacing: 0) {
            
            // MARK: - Header
            
            VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                Text("How should your AI Coach sound?")
                    .font(Theme.Typography.headline(28))
                    .foregroundStyle(Theme.Colors.textPrimary)
                    .accessibilityAddTraits(.isHeader)
                
                Text("This shapes how we give you feedback.")
                    .font(Theme.Typography.body(16))
                    .foregroundStyle(Theme.Colors.textSecondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.horizontal, Theme.Spacing.xl)
            .padding(.top, Theme.Spacing.xxl)
            .padding(.bottom, Theme.Spacing.xl)
            
            // MARK: - Tone Cards
            
            ScrollView {
                VStack(spacing: Theme.Spacing.md) {
                    ForEach(toneOptions) { tone in
                        ToneCard(
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
                    .frame(height: Theme.Spacing.md)
                
                // Helper Text
                Text("You can change this anytime in Settings.")
                    .font(Theme.Typography.caption(14))
                    .foregroundStyle(Theme.Colors.muted)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.bottom, Theme.Spacing.xl)
            }
        }
    }
}

// MARK: - Tone Option Model

struct ToneOption: Identifiable {
    let id: String
    let name: String
    let icon: String
    let example: String
}

// MARK: - Tone Card Component

struct ToneCard: View {
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
                            .foregroundStyle(Theme.Colors.accentEmerald)
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
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(isSelected ? Theme.Colors.accentEmerald.opacity(0.05) : Theme.Colors.cardSurface)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(
                        isSelected ? Theme.Colors.accentEmerald : Theme.Colors.divider,
                        lineWidth: isSelected ? 2 : 1
                    )
            )
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
        .background(Theme.Colors.background)
}

#Preview("Step 7 - Hype Selected") {
    let vm = OnboardingViewModel(userId: "preview", displayName: "John Doe", email: "john@example.com")
    vm.aiTone = "Hype"
    return Step7ToneQuizView(viewModel: vm)
        .background(Theme.Colors.background)
}

