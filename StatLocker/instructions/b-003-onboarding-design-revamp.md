# Premium Onboarding Design System

## Overview

This document outlines the premium onboarding experience for StatLocker, featuring athletic-focused copy, personalized messaging, and clean white background design. The goal is to create a motivational, D1-quality experience that resonates with serious athletes.

---

## Approved Copy Per Step

### Step 1: Sport Selection ✅
- **Header:** "Ready to dominate, [Name]?"
- **Subhead:** "Choose your sport and unlock your athletic potential."
- **File:** `Step1SportSelectionView.swift`

### Step 2: Team Gender ✅
- **Header:** "Boys or girls game, [Name]?"
- **Subhead:** "Your stats, benchmarks, and competition level are built different."
- **File:** `Step2TeamGenderView.swift`

### Step 3: Profile Details ✅
- **Header:** "Class of 20XX awaits, [Name]"
- **Subhead:** "Set the foundation for tracking your elite progression."
- **File:** `Step3ProfileDetailsView.swift`

### Step 4: Position ✅
- **Header:** "Lock in your position, [Name]"
- **Subhead:** "Each position has elite-level metrics we'll track for you."
- **File:** `Step4PositionView.swift`

### Step 5: Team Info ✅
- **Header:** "Claim your home turf, [Name]"
- **Subhead:** "High school and club stats tracked separately, always."
- **File:** `Step5TeamInfoView.swift`

### Step 6: Season Goals ✅
- **Header:** "Set 3 targets, [Name]"
- **Subhead:** "Elite athletes chase numbers all season. Pick yours."
- **File:** `Step6SeasonGoalsView.swift`

### Step 7: Tone Quiz ✅
- **Header:** "Your coach, your vibe, [Name]"
- **Subhead:** "AI feedback tuned to how you compete."
- **File:** `Step7ToneQuizView.swift`

### Step 8: Review ✅
- **Header:** "You're locked in, [Name]"
- **Subhead:** "Your first game log is one tap away—let's go."
- **File:** `Step8ReviewView.swift`

---

## Design System (White Background)

### Typography Scale
```swift
// Premium typography scale for onboarding
static func headline(_ size: CGFloat = 32) -> Font { .system(size: size, weight: .bold, design: .rounded) }
static func title(_ size: CGFloat = 22) -> Font { .system(size: size, weight: .semibold, design: .default) }
static func body(_ size: CGFloat = 17) -> Font { .system(size: size, weight: .regular, design: .default) }
static func subhead(_ size: CGFloat = 17) -> Font { .system(size: size, weight: .regular, design: .default) }
static func number(_ size: CGFloat = 28, weight: Font.Weight = .semibold) -> Font { .system(size: size, weight: weight, design: .rounded) }
static func caption(_ size: CGFloat = 13) -> Font { .system(size: size, weight: .medium, design: .default) }
```

### Visual Polish
- **Background:** Clean white (`Theme.Colors.background`)
- **Card Elevation:** Soft shadows (0, 2, 8, rgba(0,0,0,0.06))
- **Selection States:** 
  - Scale 1.02x on tap
  - Primary border glow (no gradients)
  - Haptic feedback on all selections
- **Athletic Badges:** 
  - Freshman: 🔰
  - JV: ⭐
  - Varsity: 👑
- **Spacing:** Generous padding (Theme.Spacing.xxl between sections)

### Component Updates
- **BorderedSelectionCard:** Add scale animation on selection
- **PrimaryButton:** Ensure 56px height maintained
- **All headers:** Personalize with `viewModel.displayName`
- **Final CTA:** "Enter My Locker 🔓" with lock emoji

---

## Athletic Language Principles

### Core Messaging Framework
- **Aspirational:** "dominate", "elite", "champion"
- **Action-oriented:** "lock in", "chase", "set targets"
- **Team culture:** "rep", "crest", "home turf"
- **Competitive:** "built different", "level up"
- **Future-focused:** "awaits", "progression", "journey"

### Copy Guidelines
- Use first name throughout with `viewModel.displayName`
- Lead with aspiration, not features
- Athletic language over corporate speak
- Future-focused messaging
- Confident, not cautious tone

---

## Implementation Details

### Personalization
```swift
// Name extraction in OnboardingViewModel
var displayName: String {
    if !firstName.isEmpty {
        return firstName
    } else if let emailPrefix = email.split(separator: "@").first {
        return String(emailPrefix)
    } else {
        return "Athlete"
    }
}
```

### Dynamic Headers
- Step 3: "Class of \(viewModel.gradYear) awaits, \(viewModel.displayName)"
- All other steps: Use `viewModel.displayName` in headers

### Athletic Badges Implementation
```swift
private var athleticBadge: String {
    switch title {
    case "Freshman": return "🔰"
    case "JV": return "⭐"
    case "Varsity": return "👑"
    default: return ""
    }
}
```

---

## Success Metrics

- **Engagement:** Headers use personalized "[Name]" format
- **Athletic Tone:** Copy uses athletic language throughout
- **Visual Impact:** Typography feels premium and impactful
- **Consistency:** Clean white background maintained
- **Accessibility:** Athletic badges enhance level selection
- **Technical:** All changes compile successfully

---

## Technical Notes

- Maintain Theme.swift consistency for all colors
- Keep 56px touch targets for accessibility
- Preserve existing validation logic
- Athletic badges are emoji-based (no custom assets needed)
- "Class of 20XX" dynamically shows selected grad year
- Final button: "Enter My Locker 🔓" with lock emoji

---

## File Structure

```
StatLocker/
  CoreUI/
    Theme.swift                    // Updated typography scale
  Features/
    Onboarding/
      OnboardingCoordinator.swift  // Updated button text
      Views/
        Step1SportSelectionView.swift    // ✅ Updated copy
        Step2TeamGenderView.swift        // ✅ Updated copy
        Step3ProfileDetailsView.swift    // ✅ Updated copy + badges
        Step4PositionView.swift          // ✅ Updated copy
        Step5TeamInfoView.swift          // ✅ Updated copy
        Step6SeasonGoalsView.swift       // ✅ Updated copy
        Step7ToneQuizView.swift          // ✅ Updated copy
        Step8ReviewView.swift            // ✅ Updated copy
```

---

## Design Tokens Reference

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
Theme.Typography.headline(32) = .system(size: 32, weight: .bold, design: .rounded)
Theme.Typography.title(22) = .system(size: 22, weight: .semibold, design: .default)
Theme.Typography.body(17) = .system(size: 17, weight: .regular, design: .default)
Theme.Typography.subhead(17) = .system(size: 17, weight: .regular, design: .default)
Theme.Typography.number(28) = .system(size: 28, weight: .semibold, design: .rounded)
Theme.Typography.caption(13) = .system(size: 13, weight: .medium, design: .default)
```

---

## Notes

- All implementations maintain existing Theme.swift consistency
- Athletic badges enhance level selection without custom assets
- Personalization increases engagement by ~40% in similar apps
- Clean white background maintains premium feel
- 56px touch targets ensure accessibility compliance
- Haptic feedback enhances perceived app quality and responsiveness