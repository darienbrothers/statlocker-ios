# B-003: Onboarding Flow Implementation (UPDATED)

## Overview
Create a 6-step onboarding experience that collects athlete profile and team data, with auto-save progress, tone quiz for AI personalization, and position-specific goal selection from a curated goals library.

## Data Models (CoreKit/Models.swift)

### AthleteProfile (D-001)
```swift
struct AthleteProfile: Codable, Identifiable {
    var id: String = UUID().uuidString
    var userId: String
    var firstName: String
    var lastName: String
    var email: String
    var teamGender: String // "boys" | "girls"
    var gradYear: Int // 2025-2028
    var level: String // "Freshman" | "JV" | "Varsity"
    var position: String // Boys: Goalie, Attack, Midfield, Defense, FOGO, LSM | Girls: Goalie, Attack, Midfield, Defense
    var aiTone: String // "Hype" | "Mentor" | "Analyst" | "Captain"
    var seasonGoals: [SeasonGoal] // Array of 3 goals
    var onboardingCompleted: Bool
    var createdAt: Date
}

struct SeasonGoal: Codable, Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var targetValue: Double
    var currentValue: Double = 0
    var unit: String // "saves", "goals", "%", etc.
    var metricType: String // "count", "percent", "rate", "max"
    var trackingKey: String // Maps to stat field
    var isCustom: Bool = false
}
```

### TeamInfo (D-002)
```swift
struct TeamInfo: Codable {
    var hsTeamName: String
    var hsCity: String
    var hsState: String
    var hasClubTeam: Bool
    var clubTeamName: String?
    var clubCity: String?
    var clubState: String?
}
```

### GoalsLibrary (CoreKit/GoalsLibrary.swift)
```swift
struct GoalTemplate: Identifiable {
    var id: String
    var position: String
    var level: String
    var title: String
    var metricType: String
    var target: Double
    var unit: String
    var trackingKey: String
}

// Port from goalsLibrary.ts - filter by position + level
class GoalsLibrary {
    static let shared = GoalsLibrary()
    
    func getGoals(for position: String, level: String) -> [GoalTemplate] {
        // Returns filtered list based on position + level
    }
}
```

## Onboarding Steps & Updated Copy

### Step 1: Team Identity
**Screen Title:** "Let's build your Locker"  
**Subtitle:** "Every stat tells your story — start with the basics."

**Fields:**
- **Gender Selector:** Boys | Girls (segmented control, 44pt height)
- **Helper Copy:** "This helps us show the right positions and benchmarks."

**Validation:**
- Gender required before continuing

**Debug Log:** `[StatLocker][Onboarding] Step 1 completed: gender={gender}`

---

### Step 2: Profile Details
**Title:** "Tell us about yourself"  
**Subtitle:** "We use this to build your recruiting timeline."

**Fields:**
- **Grad Year:** Picker wheel (2025, 2026, 2027, 2028)
- **Level:** Freshman | JV | Varsity (chip selection, single-select)

**Helper Copy:** "Your level helps us suggest realistic season goals."

**Validation:**
- Both fields required

**Debug Log:** `[StatLocker][Onboarding] Step 2 completed: gradYear={year}, level={level}`

---

### Step 3: Position (UPDATED)
**Title:** "What's your primary position?"  
**Subtitle:** "Your position shapes the stats we track."

**Position Options (Gender-Aware):**

**Boys Positions:**
1. **Goalie** 
   - Tooltip: "We track: Save %, Saves, Goals Against, Clears, Save Zones"
2. **Attack**
   - Tooltip: "We track: Goals, Assists, Shots, Shooting %, Ground Balls, Turnovers"
3. **Midfield**
   - Tooltip: "We track: Goals, Assists, Ground Balls, Clears, Faceoffs, Caused Turnovers"
4. **Defense**
   - Tooltip: "We track: Ground Balls, Caused Turnovers, Clears, Penalties"
5. **FOGO**
   - Tooltip: "We track: Faceoff Win %, FO Wins, Ground Balls, Violations, Transition Points"
6. **LSM**
   - Tooltip: "We track: Ground Balls, Caused Turnovers, Clears, Penalties, Transition Points"

**Girls Positions:**
1. **Goalie**
   - Tooltip: "We track: Save %, Saves, Goals Against, Clears"
2. **Attack**
   - Tooltip: "We track: Goals, Assists, Shots, Shooting %, Ground Balls, Draw Controls"
3. **Midfield**
   - Tooltip: "We track: Goals, Assists, Ground Balls, Draw Controls, Caused Turnovers"
4. **Defense**
   - Tooltip: "We track: Ground Balls, Caused Turnovers, Clears, Draw Controls"

**UI Details:**
- Display as large tappable cards with position name + icon
- Tap card to show tooltip overlay with tracked stats
- Selected card shows emerald accent border
- Tooltips use 14pt SF Regular, light background

**Validation:**
- Position required

**Debug Log:** `[StatLocker][Onboarding] Step 3 completed: position={position}`

---

### Step 4: Team Info
**Title:** "Where do you play?"  
**Subtitle:** "We'll use this for your recruiting profile."

**Fields:**
- **HS Team Name:** Text field (placeholder: "Duxbury High School")
- **City:** Text field (placeholder: "Duxbury")
- **State:** Picker/Dropdown (US states)
- **Club Toggle:** "I also play for a club team" (iOS switch)

**Conditional Fields (if club toggle ON):**
- **Club Team Name:** Text field
- **Club City:** Text field
- **Club State:** Picker

**Helper Copy (below toggle):** "Club stats will be tracked separately from HS."

**Validation:**
- HS name, city, state required
- If club toggle ON: club fields also required

**Debug Log:** `[StatLocker][Onboarding] Step 4 completed: hs={name}, hasClub={bool}`

---

### Step 5: Season Goals (UPDATED WITH GOALS LIBRARY)
**Title:** "Pick your top 3 season goals"  
**Subtitle:** "These keep you locked in all season."

**Goal Selection UI:**

**Display:** Scrollable list of goal cards filtered by:
- `position` (from Step 3)
- `level` (from Step 2)

**Goal Card Format:**
```
[Checkmark if selected] Goal Title
Target: {target} {unit}
```

**Example for Goalie + Varsity:**
- ☐ 60%+ save percentage
- ☐ 200+ saves (season)
- ☐ 12.0+ saves per game
- ☐ ≤8.0 goals against per game
- ☐ 90%+ clear success
- ☐ 2+ goalie assists (season)
- ☐ **Custom Goal** (tap to add)

**Custom Goal Input:**
When "Custom Goal" is tapped:
- Modal appears with fields:
  - **Goal Name:** Text field (e.g., "Improve weak-side coverage")
  - **Target:** Number input (optional, can be qualitative)
  - **Unit:** Text field (e.g., "games", "saves", or leave blank)
- Save adds to selectable goals list
- Custom goals marked with `isCustom: true`

**Selection Rules:**
- Must select exactly 3 goals
- Can select 0-3 custom goals
- Selected goals show emerald checkmark
- Counter at top: "2/3 goals selected"

**Helper Copy:** "You can change these anytime in Settings."

**Validation:**
- Exactly 3 goals required

**Debug Log:** `[StatLocker][Onboarding] Step 5 completed: goals=[{goal1}, {goal2}, {goal3}], customCount={n}`

---

### Step 6: Tone Quiz
**Title:** "How should your AI Coach sound?"  
**Subtitle:** "This shapes how we give you feedback."

**Options (tap to select, shows example copy):**

1. **Hype**  
   Example: "🔥 You brought it today. Keep that edge."

2. **Mentor**  
   Example: "Strong step forward. Let's compound it."

3. **Analyst**  
   Example: "Save% +7 vs season avg. Lateral speed trending up."

4. **Captain**  
   Example: "Leaders show up—keep stacking wins."

**UI Details:**
- Large tappable cards with tone name + example
- Selected card shows emerald accent
- Only one selectable

**Helper Copy:** "You can change this anytime in Settings."

**Validation:**
- Tone required

**Debug Log:** `[StatLocker][Onboarding] Step 6 completed: tone={tone}`

---

### Step 7: Review
**Title:** "You're all set!"  
**Subtitle:** "Review your info before entering your Locker."

**Display (Read-only Summary):**
```
Name: {firstName} {lastName}
Position: {position} | Class of {gradYear}
Level: {level}

High School Team:
{hsTeamName} – {city}, {state}

[If club] Club Team:
{clubTeamName} – {city}, {state}

Season Goals:
1. {goal1.title}
2. {goal2.title}
3. {goal3.title}

AI Coach Tone: {tone}
```

**Actions:**
- **Primary Button:** "Enter Your Locker" (full width, indigo, 50pt height)
- **Secondary Link:** "Edit" (tap to return to any step)

**On Completion:**
1. Save profile to Firebase `/users/{uid}/profile`
2. Save teamInfo to Firebase `/users/{uid}/team`
3. Set `onboardingCompleted = true`
4. Clear UserDefaults progress
5. Navigate to Dashboard
6. Show welcome toast: "Welcome to StatLocker, {firstName}!"

**Debug Log:** `[StatLocker][Onboarding] Completed and saved to Firebase for user={uid}`

---

## File Structure

```
StatLocker/
  CoreKit/
    Models.swift                    // AthleteProfile, TeamInfo, SeasonGoal
    GoalsLibrary.swift              // GoalTemplate, filter logic
  Features/
    Onboarding/
      OnboardingCoordinator.swift   // Navigation + state management
      OnboardingViewModel.swift     // Business logic + Firebase save
      Views/
        Step1TeamIdentityView.swift
        Step2ProfileDetailsView.swift
        Step3PositionView.swift     // Includes position tooltips
        Step4TeamInfoView.swift
        Step5SeasonGoalsView.swift  // Goals library + custom input
        Step6ToneQuizView.swift
        Step7ReviewView.swift
      Components/
        PositionCard.swift           // Reusable position card with tooltip
        GoalCard.swift               // Reusable goal selection card
        CustomGoalSheet.swift        // Modal for custom goal input
```

---

## Implementation Details

### OnboardingCoordinator.swift
```swift
@Observable class OnboardingCoordinator {
    var currentStep: Int = 1
    var viewModel: OnboardingViewModel
    
    func nextStep() {
        guard viewModel.validateCurrentStep() else { return }
        viewModel.saveProgress()
        if currentStep < 7 {
            currentStep += 1
        } else {
            Task {
                await completeOnboarding()
            }
        }
    }
    
    func previousStep() {
        if currentStep > 1 {
            currentStep -= 1
        }
    }
    
    func completeOnboarding() async {
        do {
            try await viewModel.completeOnboarding()
            // Navigate to Dashboard
        } catch {
            print("[StatLocker][Onboarding] Error: \(error)")
        }
    }
}
```

### OnboardingViewModel.swift
```swift
@Observable class OnboardingViewModel {
    // Step 1
    var teamGender: String = ""
    
    // Step 2
    var gradYear: Int = 2025
    var level: String = ""
    
    // Step 3
    var position: String = ""
    
    // Step 4
    var hsTeamName: String = ""
    var hsCity: String = ""
    var hsState: String = ""
    var hasClubTeam: Bool = false
    var clubTeamName: String = ""
    var clubCity: String = ""
    var clubState: String = ""
    
    // Step 5
    var selectedGoals: [SeasonGoal] = []
    
    // Step 6
    var aiTone: String = ""
    
    // User info
    var userId: String
    var firstName: String
    var lastName: String
    var email: String
    
    func validateCurrentStep() -> Bool {
        // Validation logic per step
    }
    
    func saveProgress() {
        // Save to UserDefaults
        let progress = OnboardingProgress(/* ... */)
        UserDefaults.standard.set(try? JSONEncoder().encode(progress), forKey: "onboarding_progress_\(userId)")
    }
    
    func loadProgress() {
        // Load from UserDefaults if exists
    }
    
    func completeOnboarding() async throws {
        let profile = AthleteProfile(
            userId: userId,
            firstName: firstName,
            lastName: lastName,
            email: email,
            teamGender: teamGender,
            gradYear: gradYear,
            level: level,
            position: position,
            aiTone: aiTone,
            seasonGoals: selectedGoals,
            onboardingCompleted: true,
            createdAt: Date()
        )
        
        let teamInfo = TeamInfo(
            hsTeamName: hsTeamName,
            hsCity: hsCity,
            hsState: hsState,
            hasClubTeam: hasClubTeam,
            clubTeamName: clubTeamName.isEmpty ? nil : clubTeamName,
            clubCity: clubCity.isEmpty ? nil : clubCity,
            clubState: clubState.isEmpty ? nil : clubState
        )
        
        // Save to Firebase
        try await FirebaseService.shared.saveProfile(profile)
        try await FirebaseService.shared.saveTeamInfo(teamInfo, for: userId)
        
        // Clear UserDefaults
        UserDefaults.standard.removeObject(forKey: "onboarding_progress_\(userId)")
        
        print("[StatLocker][Onboarding] Saved profile and team info for \(userId)")
    }
}
```

### GoalsLibrary.swift
```swift
class GoalsLibrary {
    static let shared = GoalsLibrary()
    
    private var allGoals: [GoalTemplate] = []
    
    init() {
        loadGoals()
    }
    
    private func loadGoals() {
        // Port from goalsLibrary.ts
        // Create GoalTemplate instances for each position/level combination
        
        // Example Goalie Varsity goals:
        allGoals.append(GoalTemplate(
            id: "gk-var-savepct-60",
            position: "Goalie",
            level: "Varsity",
            title: "60%+ save percentage",
            metricType: "percent",
            target: 0.6,
            unit: "%",
            trackingKey: "save_pct"
        ))
        
        // ... add all goals from goalsLibrary.ts
    }
    
    func getGoals(for position: String, level: String) -> [GoalTemplate] {
        return allGoals.filter { goal in
            goal.position == position && goal.level == level
        }
    }
}
```

---

## Auth Flow Integration (StatLockerApp.swift)

After successful authentication:

```swift
struct StatLockerApp: App {
    @State private var authService = AuthService()
    @State private var showOnboarding = false
    @State private var showDashboard = false
    
    var body: some Scene {
        WindowGroup {
            if authService.isAuthenticated {
                if showOnboarding {
                    OnboardingCoordinator()
                } else if showDashboard {
                    DashboardView()
                }
            } else {
                WelcomeScreen()
            }
        }
        .onChange(of: authService.currentUser) { oldValue, newValue in
            if let user = newValue {
                Task {
                    await checkOnboardingStatus(for: user.uid)
                }
            }
        }
    }
    
    func checkOnboardingStatus(for userId: String) async {
        // Check Firebase for profile
        if let profile = await FirebaseService.shared.fetchProfile(for: userId) {
            if profile.onboardingCompleted {
                showDashboard = true
            } else {
                showOnboarding = true
            }
        } else {
            // Check UserDefaults for partial progress
            showOnboarding = true
        }
    }
}
```

---

## Progress Persistence

**UserDefaults Key:** `onboarding_progress_{userId}`

**Stored Data:**
```swift
struct OnboardingProgress: Codable {
    var currentStep: Int
    var teamGender: String
    var gradYear: Int
    var level: String
    var position: String
    var hsTeamName: String
    var hsCity: String
    var hsState: String
    var hasClubTeam: Bool
    var clubTeamName: String?
    var clubCity: String?
    var clubState: String?
    var selectedGoals: [SeasonGoal]
    var aiTone: String
}
```

**Behavior:**
- Save after each step completion
- Load on app launch if onboarding incomplete
- Clear on successful completion

---

## UI/UX Details

**Global:**
- Progress indicator: "Step 1 of 7", "Step 2 of 7"... at top (12pt SF Regular, muted gray)
- Back button: "<" icon (44pt tap target)
- Continue button: "Continue" (primary indigo, 50pt height, full width)
- Smooth slide transitions between steps
- All text fields: 44pt minimum height
- Error states: red accent with helper text below field

**Colors:**
- Primary: #4F46E5 (indigo)
- Accent: #1AEC88 (emerald)
- Text Primary: #0F172A
- Text Secondary: #334155
- Muted: #A3A3A3
- Error: #EF4444

**Typography:**
- Headers: SF Rounded Semibold 24pt
- Subtitles: SF Regular 16pt
- Body: SF Regular 14pt
- Helper text: SF Regular 12pt, text-secondary

---

## Validation Rules Summary

| Step | Required Fields | Validation |
|------|----------------|------------|
| 1 | teamGender | Must select Boys or Girls |
| 2 | gradYear, level | Both required |
| 3 | position | Must select one position |
| 4 | hsTeamName, hsCity, hsState | All HS fields required; club fields required only if toggle ON |
| 5 | selectedGoals | Exactly 3 goals required |
| 6 | aiTone | Must select one tone |
| 7 | N/A | Review only, no validation |

---

## Next Steps After Onboarding

1. Navigate to Dashboard
2. Show greeting: "Welcome to StatLocker, {firstName}!"
3. Display empty state with: "Log your first game to start tracking"
4. FAB available (center tab or floating)
5. Trial starts when first game is logged (not immediately)

---

## Copy Principles (Applied Throughout)

- Motivational, not intimidating
- Use "You" and "Your" consistently
- Explain WHY we collect each field (builds trust)
- Keep microcopy ≤ 240 chars
- Celebrate progress and completion
- Never use jargon or technical terms
- Debug logs prefix: `[StatLocker][Onboarding]`

---

## Implementation Todo List

**Phase 1: Core Models & Infrastructure**
- [x] Task 1: Create AthleteProfile, TeamInfo, and SeasonGoal models in CoreKit/Models.swift
- [x] Task 2: Port GoalsLibrary.swift from goalsLibrary.ts with all position/level goals
- [x] Task 3: Create OnboardingProgress model for UserDefaults persistence

**Phase 2: View Models & Coordinators**
- [x] Task 4: Build OnboardingViewModel with state management, validation, and progress save/load
- [x] Task 5: Build OnboardingCoordinator for navigation and step management
- [x] Task 6: Implement Firebase save logic for profile and teamInfo

**Phase 3: Step Views**
- [ ] Task 7: Create Step1TeamIdentityView with gender selector (Boys/Girls segmented control)
- [ ] Task 8: Create Step2ProfileDetailsView with grad year picker and level chips
- [ ] Task 9: Create Step3PositionView with gender-aware position list and tooltips
- [ ] Task 10: Create Step4TeamInfoView with HS fields and conditional club toggle
- [ ] Task 11: Create Step5SeasonGoalsView with goals library filtering and custom goal modal
- [ ] Task 12: Create Step6ToneQuizView with 4 tone options and example copy
- [ ] Task 13: Create Step7ReviewView with read-only summary and edit capability

**Phase 4: Reusable Components**
- [ ] Task 14: Create PositionCard component with tooltip overlay
- [ ] Task 15: Create GoalCard component for goal selection
- [ ] Task 16: Create CustomGoalSheet modal component

**Phase 5: Integration**
- [ ] Task 17: Update StatLockerApp to check profile existence after auth
- [ ] Task 18: Implement routing logic: auth → onboarding vs dashboard
- [ ] Task 19: Add onboarding progress resume logic from UserDefaults
- [ ] Task 20: Connect OnboardingCoordinator to main app navigation

**Phase 6: Testing & Polish**
- [ ] Task 21: Test all validation rules per step
- [ ] Task 22: Test progress persistence and resume
- [ ] Task 23: Test Firebase save/load functionality
- [ ] Task 24: Add VoiceOver labels and accessibility
- [ ] Task 25: Test Dynamic Type support
- [ ] Task 26: Verify dark mode colors
- [ ] Task 27: Test gender-specific position filtering
- [ ] Task 28: Test goals library filtering by position + level
- [ ] Task 29: Test custom goal creation and selection
- [ ] Task 30: End-to-end onboarding flow test

---

## Testing Checklist

- [ ] Gender selection affects position list (boys vs girls)
- [ ] Position tooltips display correct stats for each position
- [ ] Goals filter correctly by position + level
- [ ] Custom goals can be added and selected
- [ ] Exactly 3 goals enforced
- [ ] Club toggle shows/hides conditional fields
- [ ] Back button preserves data
- [ ] Progress saves to UserDefaults after each step
- [ ] Progress resumes on app relaunch
- [ ] Firebase save succeeds on completion
- [ ] UserDefaults clears on completion
- [ ] Navigation to Dashboard works
- [ ] All validation rules enforced
- [ ] VoiceOver labels present
- [ ] Dynamic Type supported
- [ ] Dark mode colors correct

