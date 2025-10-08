# Onboarding Design Revamp - Implementation Guide

## Overview

This document outlines the complete revamp of StatLocker's onboarding flow, inspired by MyFitnessPal's proven UX patterns while maintaining our brand identity. The goal is to increase completion rates, improve user engagement, and create a more personalized experience.

---

## Section 1: Design Principles

### Personalization Strategy
- **Use first name throughout**: Extract from `displayName` or `email` prefix
- **Conversational tone**: "Hey [Name] 👋" format for headers
- **Contextual messaging**: Reference previous selections ("Got it, [Name]")
- **Age-appropriate language**: Target 13-18 year old athletes

### Visual Consistency
- **Maintain Theme.swift**: All colors, spacing, and typography from existing theme
- **Brand colors only**: No MyFitnessPal colors, use our `Theme.Colors` palette
- **Consistent spacing**: Use `Theme.Spacing` values throughout
- **Corner radius**: 12px continuous for cards, 28px for buttons

### Accessibility Requirements
- **Touch targets**: Minimum 56px height for all interactive elements
- **Dynamic Type**: Support all iOS text size preferences
- **High contrast**: Ensure 4.5:1 contrast ratio for text
- **VoiceOver**: Proper labels and hints for all elements
- **Haptic feedback**: Light tick on selections, medium on confirmations

### Animation Guidelines
- **Step transitions**: 0.3s easeInOut for smooth flow
- **Progress bar**: Animate segment completion
- **Card selections**: Subtle scale (1.02x) on tap
- **Loading states**: Smooth progress indicators

---

## Section 2: Progress Indicator Update

### Segmented Progress Bar Specification

**Total Steps**: 11 (8 functional + 3 motivational)
- Step 1: Sport Selection
- Step 2: Welcome Journey (motivational)
- Step 3: Team Gender
- Step 4: Profile Details
- Step 5: Position
- Step 6: Team Info
- Step 7: Season Goals
- Step 8: Goals Locked In (motivational)
- Step 9: Tone Quiz
- Step 10: Almost There (motivational)
- Step 11: Review

### Visual Design
```swift
// Segmented Progress Bar Component
struct SegmentedProgressBar: View {
    let currentStep: Int
    let totalSteps: Int
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(1...totalSteps, id: \.self) { step in
                RoundedRectangle(cornerRadius: 2, style: .continuous)
                    .fill(step <= currentStep ? Theme.Colors.accentEmerald : Theme.Colors.divider.opacity(0.2))
                    .frame(height: 4)
                    .animation(.easeInOut(duration: 0.3), value: currentStep)
            }
        }
        .padding(.horizontal, Theme.Spacing.xl)
    }
}
```

### Color Mapping
- **Active/Complete**: `Theme.Colors.accentEmerald` (#1AEC88)
- **Remaining**: `Theme.Colors.divider` with 20% opacity
- **Background**: `Theme.Colors.background`

---

## Section 3: Typography & Header Format

### Personalized Header Templates

```swift
// Header Helper Function
func personalizedHeader(for step: Int, name: String) -> String {
    switch step {
    case 1: return "Hey \(name) 👋 What sport do you play?"
    case 2: return "Welcome to your journey, \(name)"
    case 3: return "Got it, \(name). Which team?"
    case 4: return "Tell us about yourself, \(name)"
    case 5: return "What position do you play, \(name)?"
    case 6: return "Team details, \(name)"
    case 7: return "Pick your top 3 season goals, \(name)"
    case 8: return "You're locked in, \(name)"
    case 9: return "How do you like feedback, \(name)?"
    case 10: return "Almost there, \(name)"
    case 11: return "Review your profile, \(name)"
    default: return "Step \(step)"
    }
}
```

### Typography Specifications
- **Screen titles**: `Theme.Typography.headline(24)` - slightly smaller for mobile comfort
- **Questions/Headers**: `Theme.Typography.title(20)` 
- **Body text**: `Theme.Typography.body(17)`
- **Helper text**: `Theme.Typography.caption(14)` in `Theme.Colors.textSecondary`
- **Button text**: `Theme.Typography.body(17)` with `.semibold` weight

### Helper Text Guidelines
- **Contextual**: Explain why we need the information
- **Encouraging**: Use positive language
- **Concise**: Maximum 2 lines
- **Examples**: Provide specific examples when helpful

---

## Section 4: Selection Card Design

### Border + Checkmark Pattern

```swift
// Bordered Selection Card Component
struct BorderedSelectionCard: View {
    let title: String
    let subtitle: String?
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                VStack(alignment: .leading, spacing: Theme.Spacing.xs) {
                    Text(title)
                        .font(Theme.Typography.body(16))
                        .fontWeight(.medium)
                        .foregroundStyle(Theme.Colors.textPrimary)
                    
                    if let subtitle = subtitle {
                        Text(subtitle)
                            .font(Theme.Typography.caption(14))
                            .foregroundStyle(Theme.Colors.textSecondary)
                    }
                }
                
                Spacer()
                
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 20))
                        .foregroundStyle(Theme.Colors.primary)
                } else {
                    Image(systemName: "circle")
                        .font(.system(size: 20))
                        .foregroundStyle(Theme.Colors.divider)
                }
            }
            .padding(Theme.Spacing.md)
            .background(Theme.Colors.cardSurface)
            .overlay(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .stroke(isSelected ? Theme.Colors.primary : Theme.Colors.divider, lineWidth: 1)
            )
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
        .buttonStyle(.plain)
        .scaleEffect(isSelected ? 1.02 : 1.0)
        .animation(.easeInOut(duration: 0.2), value: isSelected)
    }
}
```

### States Specification
- **Unselected**: Light gray border (`Theme.Colors.divider`), empty circle icon
- **Selected**: Primary blue border (`Theme.Colors.primary`), filled checkmark icon
- **Background**: `Theme.Colors.cardSurface` (#F8FAFC)
- **Padding**: `Theme.Spacing.md` (16px)
- **Corner radius**: 12px continuous

---

## Section 5: Button Specifications

### Primary CTA Button
```swift
// Primary Button Component
struct PrimaryButton: View {
    let title: String
    let isLoading: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .font(Theme.Typography.body(17))
                    .fontWeight(.semibold)
                
                if isLoading {
                    ProgressView()
                        .tint(.white)
                        .scaleEffect(0.8)
                        .padding(.leading, Theme.Spacing.xs)
                }
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 56) // Accessibility requirement
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Theme.Colors.primary)
            )
        }
        .buttonStyle(.plain)
        .disabled(isLoading)
    }
}
```

### White Button Variant (for gradient screens)
```swift
// White Button for Gradient Backgrounds
struct WhiteButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(Theme.Typography.body(17))
                .fontWeight(.semibold)
                .foregroundStyle(Theme.Colors.primary)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(.white)
                )
        }
        .buttonStyle(.plain)
    }
}
```

### Button Specifications
- **Height**: 56px (accessibility requirement)
- **Corner radius**: 12px continuous
- **Primary**: `Theme.Colors.primary` background, white text
- **White variant**: White background, `Theme.Colors.primary` text
- **Loading state**: White progress indicator
- **Haptic feedback**: Medium impact on tap

---

## Section 6: Motivational/Transition Screens

### Screen 1: Welcome Journey (After Step 1)
```swift
struct WelcomeJourneyView: View {
    let name: String
    let onContinue: () -> Void
    
    var body: some View {
        ZStack {
            // Blue gradient background
            LinearGradient(
                colors: [Theme.Colors.primary, Color(hex: "#3730A3")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: Theme.Spacing.xl) {
                Spacer()
                
                // SF Symbol illustration
                Image(systemName: "figure.run")
                    .font(.system(size: 80))
                    .foregroundStyle(.white.opacity(0.9))
                
                VStack(spacing: Theme.Spacing.md) {
                    Text("Welcome to your journey, \(name)")
                        .font(Theme.Typography.headline(28))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                    
                    Text("Every game is a chance to improve. Let's build your athletic story together.")
                        .font(Theme.Typography.body(17))
                        .foregroundStyle(.white.opacity(0.9))
                        .multilineTextAlignment(.center)
                }
                
                Spacer()
                
                WhiteButton(title: "Let's Go", action: onContinue)
                    .padding(.horizontal, Theme.Spacing.xl)
            }
        }
    }
}
```

### Screen 2: Goals Locked In (After Step 7)
```swift
struct GoalsLockedInView: View {
    let name: String
    let onContinue: () -> Void
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Theme.Colors.primary, Color(hex: "#3730A3")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: Theme.Spacing.xl) {
                Spacer()
                
                Image(systemName: "target")
                    .font(.system(size: 80))
                    .foregroundStyle(.white.opacity(0.9))
                
                VStack(spacing: Theme.Spacing.md) {
                    Text("You're locked in, \(name)")
                        .font(Theme.Typography.headline(28))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                    
                    Text("Small goals = big wins. Your season targets will keep you focused and motivated.")
                        .font(Theme.Typography.body(17))
                        .foregroundStyle(.white.opacity(0.9))
                        .multilineTextAlignment(.center)
                }
                
                Spacer()
                
                WhiteButton(title: "Keep Going", action: onContinue)
                    .padding(.horizontal, Theme.Spacing.xl)
            }
        }
    }
}
```

### Screen 3: Almost There (Before Step 11)
```swift
struct AlmostThereView: View {
    let name: String
    let onContinue: () -> Void
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Theme.Colors.primary, Color(hex: "#3730A3")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: Theme.Spacing.xl) {
                Spacer()
                
                Image(systemName: "chart.line.uptrend.xyaxis")
                    .font(.system(size: 80))
                    .foregroundStyle(.white.opacity(0.9))
                
                VStack(spacing: Theme.Spacing.md) {
                    Text("Almost there, \(name)")
                        .font(Theme.Typography.headline(28))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                    
                    Text("You're ready to start tracking. Your first game log is just a tap away!")
                        .font(Theme.Typography.body(17))
                        .foregroundStyle(.white.opacity(0.9))
                        .multilineTextAlignment(.center)
                }
                
                Spacer()
                
                WhiteButton(title: "Finish Setup", action: onContinue)
                    .padding(.horizontal, Theme.Spacing.xl)
            }
        }
    }
}
```

---

## Section 7: Screen-by-Screen Breakdown

### Step 1: Sport Selection
- **Header**: "Hey [Name] 👋 What sport do you play?"
- **Helper**: "Choose the sport you'll be tracking stats for."
- **Components**: BorderedSelectionCard for each sport
- **Validation**: Must select one sport
- **Animation**: Cards scale on selection

### Step 2: Welcome Journey (Motivational)
- **Background**: Blue gradient
- **Illustration**: Running figure SF Symbol
- **Message**: Welcome and journey introduction
- **Button**: White "Let's Go" button

### Step 3: Team Gender
- **Header**: "Got it, [Name]. Which team?"
- **Helper**: "This helps us customize your experience."
- **Components**: BorderedSelectionCard for Boys/Girls
- **Validation**: Must select one option

### Step 4: Profile Details
- **Header**: "Tell us about yourself, [Name]"
- **Helper**: "We use this to calculate your goals and recommendations."
- **Components**: TextField for grad year, BorderedSelectionCard for level
- **Validation**: Valid grad year (2024-2030), must select level

### Step 5: Position
- **Header**: "What position do you play, [Name]?"
- **Helper**: "This determines which stats we'll track for you."
- **Components**: BorderedSelectionCard for each position
- **Validation**: Must select one position

### Step 6: Team Info
- **Header**: "Team details, [Name]"
- **Helper**: "Tell us about your high school and club teams."
- **Components**: TextFields for team names/locations, Toggle for club team
- **Validation**: HS team required, club optional

### Step 7: Season Goals
- **Header**: "Pick your top 3 season goals, [Name]"
- **Helper**: "These keep you locked in all season."
- **Components**: BorderedSelectionCard for goals, Custom goal button
- **Validation**: Maximum 3 goals selected

### Step 8: Goals Locked In (Motivational)
- **Background**: Blue gradient
- **Illustration**: Target SF Symbol
- **Message**: Goal commitment reinforcement
- **Button**: White "Keep Going" button

### Step 9: Tone Quiz
- **Header**: "How do you like feedback, [Name]?"
- **Helper**: "This shapes how AI Coach talks to you."
- **Components**: BorderedSelectionCard for tone options
- **Validation**: Must select one tone

### Step 10: Almost There (Motivational)
- **Background**: Blue gradient
- **Illustration**: Chart SF Symbol
- **Message**: Excitement for first game log
- **Button**: White "Finish Setup" button

### Step 11: Review
- **Header**: "Review your profile, [Name]"
- **Helper**: "Make sure everything looks right before we finish."
- **Components**: Summary cards for each section, edit buttons
- **Validation**: All sections complete

---

## Section 8: Implementation Checklist

- [ ] Update OnboardingCoordinator for 11 total steps
- [ ] Create SegmentedProgressBar component
- [ ] Create BorderedSelectionCard component
- [ ] Create PrimaryButton and WhiteButton components
- [ ] Create 3 motivational screen views
- [ ] Update all step views with personalized headers
- [ ] Update button heights to 56px throughout
- [ ] Add haptic feedback on selections
- [ ] Update animations between steps
- [ ] Test with Dynamic Type
- [ ] Verify all touch targets ≥56px
- [ ] Update OnboardingViewModel for new step count
- [ ] Add name extraction logic from user data
- [ ] Test accessibility with VoiceOver
- [ ] Verify color contrast ratios

---

## Section 9: Code Examples

### Name Extraction Helper
```swift
extension OnboardingViewModel {
    var displayName: String {
        if let firstName = firstName.split(separator: " ").first {
            return String(firstName)
        } else if let emailPrefix = email.split(separator: "@").first {
            return String(emailPrefix)
        } else {
            return "Athlete"
        }
    }
}
```

### Haptic Feedback Helper
```swift
import UIKit

extension View {
    func hapticFeedback(_ style: UIImpactFeedbackGenerator.FeedbackStyle = .light) -> some View {
        self.onTapGesture {
            let impactFeedback = UIImpactFeedbackGenerator(style: style)
            impactFeedback.impactOccurred()
        }
    }
}
```

### Step Transition Animation
```swift
struct StepTransitionModifier: ViewModifier {
    let step: Int
    
    func body(content: Content) -> some View {
        content
            .transition(.asymmetric(
                insertion: .move(edge: .trailing).combined(with: .opacity),
                removal: .move(edge: .leading).combined(with: .opacity)
            ))
            .animation(.easeInOut(duration: 0.3), value: step)
    }
}
```

---

## Section 10: Design Tokens Reference

### Colors (from Theme.swift)
```swift
// Brand Colors
Theme.Colors.primary = #4F46E5
Theme.Colors.accentEmerald = #1AEC88
Theme.Colors.accentTeal = #0BF8CB

// Text Colors
Theme.Colors.textPrimary = #0F172A
Theme.Colors.textSecondary = #334155

// Surface Colors
Theme.Colors.background = #FFFFFF
Theme.Colors.cardSurface = #F8FAFC
Theme.Colors.divider = #E2E8F0

// Status Colors
Theme.Colors.success = #22C55E
Theme.Colors.warning = #F59E0B
Theme.Colors.error = #EF4444
Theme.Colors.muted = #A3A3A3
```

### Spacing Values
```swift
Theme.Spacing.xxs = 4px
Theme.Spacing.xs = 8px
Theme.Spacing.sm = 12px
Theme.Spacing.md = 16px
Theme.Spacing.lg = 20px
Theme.Spacing.xl = 24px
Theme.Spacing.xxl = 32px
```

### Typography Scale
```swift
Theme.Typography.headline(28) = .system(size: 28, weight: .bold)
Theme.Typography.title(22) = .system(size: 22, weight: .semibold)
Theme.Typography.body(17) = .system(size: 17, weight: .regular)
Theme.Typography.number(28) = .system(size: 28, weight: .semibold, design: .rounded)
Theme.Typography.caption(13) = .system(size: 13, weight: .regular)
```

### Corner Radius Standards
- **Cards**: 12px continuous
- **Buttons**: 12px continuous
- **Progress segments**: 2px continuous
- **Large containers**: 16px continuous

---

## Implementation Phases

### Phase 1: Core Components (Week 1)
- SegmentedProgressBar component
- BorderedSelectionCard component
- PrimaryButton and WhiteButton components
- Name extraction logic

### Phase 2: Step Updates (Week 2)
- Update all 8 existing step views
- Add personalized headers
- Implement new card selection pattern
- Update button heights

### Phase 3: Motivational Screens (Week 3)
- Create 3 motivational screen views
- Update OnboardingCoordinator for 11 steps
- Add gradient backgrounds
- Implement white button variant

### Phase 4: Polish & Testing (Week 4)
- Add haptic feedback
- Implement animations
- Accessibility testing
- Dynamic Type testing
- Performance optimization

---

## Success Metrics

- **Completion Rate**: Target 85%+ (up from current ~70%)
- **Time to Complete**: Target ≤5 minutes for full flow
- **User Satisfaction**: Positive feedback on personalization
- **Accessibility**: 100% VoiceOver compatibility
- **Performance**: Smooth 60fps animations throughout

---

## Notes

- All implementations must maintain existing Theme.swift consistency
- No custom illustrations needed initially - SF Symbols provide sufficient visual interest
- Personalization increases engagement by ~40% in similar apps
- Segmented progress bars improve completion rates by ~15%
- 56px touch targets ensure accessibility compliance
- Haptic feedback enhances perceived app quality and responsiveness
