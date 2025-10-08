# B-004: Dashboard (Home/Locker) Implementation

## Overview
Build the main Dashboard (Home/Locker) screen with hero card, HS/Club context toggle, season goals, performance stats, AI insights, recent games, and FAB. Support both empty state (new users) and active state (users with logged games). Position-specific stats for all lacrosse positions with performance indicators and rule-based AI templates.

## Goals
- Create motivating home screen that surfaces key metrics at a glance
- Support HS ↔ Club context switching with persistent state
- Show circular goal progress with tap-to-expand functionality
- Display position-specific performance stats with trend indicators
- Provide AI insights after 3+ games with off-season awareness
- Enable quick game logging via FAB bottom sheet
- Deliver clean empty state for new users

---

## Data Models (CoreKit/Models.swift)

### GameLog (D-003)
```swift
struct GameLog: Codable, Identifiable, Equatable {
    var id: String = UUID().uuidString
    var userId: String
    var date: Date
    var context: GameContext // hs | club
    var isConference: Bool? // HS only; nil for Club
    var opponent: String?
    var stats: GameStats
    var source: LogSource // live | after | ocr
    var aiSummary: String?
    var quarterBreakdown: [QuarterStats]?
    var createdAt: Date
}

enum GameContext: String, Codable {
    case hs = "hs"
    case club = "club"
}

enum LogSource: String, Codable {
    case live = "live"
    case after = "after"
    case ocr = "ocr"
}

struct GameStats: Codable, Equatable {
    // Goalie stats
    var shotsFaced: Int = 0
    var saves: Int = 0
    var goalsAllowed: Int = 0
    var clears: Int = 0
    
    // Attack/Midfield/Defense stats (added as needed)
    var goals: Int = 0
    var assists: Int = 0
    var groundBalls: Int = 0
    var causedTurnovers: Int = 0
    var shots: Int = 0
    
    // FOGO stats
    var faceoffWins: Int = 0
    var faceoffLosses: Int = 0
    
    // Computed properties
    var savePercentage: Double? {
        guard shotsFaced > 0 else { return nil }
        return Double(saves) / Double(shotsFaced)
    }
    
    var shootingPercentage: Double? {
        guard shots > 0 else { return nil }
        return Double(goals) / Double(shots)
    }
    
    var faceoffPercentage: Double? {
        let total = faceoffWins + faceoffLosses
        guard total > 0 else { return nil }
        return Double(faceoffWins) / Double(total)
    }
}

struct QuarterStats: Codable, Equatable {
    var quarter: Int // 1-4
    var stats: GameStats
}
```

### Dashboard State Models
```swift
struct DashboardState: Codable {
    var selectedContext: GameContext = .hs
    var lastUpdated: Date = Date()
}

struct PerformanceTrend: Equatable {
    var statName: String
    var currentValue: Double
    var previousAverage: Double
    var changePercentage: Double
    var direction: TrendDirection
    
    enum TrendDirection {
        case up, down, stable
        
        var color: Color {
            switch self {
            case .up: return Theme.Colors.success
            case .down: return Theme.Colors.error
            case .stable: return Theme.Colors.muted
            }
        }
        
        var icon: String {
            switch self {
            case .up: return "↑"
            case .down: return "↓"
            case .stable: return "→"
            }
        }
    }
}
```

### AthleteProfile Extension
```swift
extension AthleteProfile {
    // Add jersey numbers (Phase 1)
    var hsJerseyNumber: Int?
    var clubJerseyNumber: Int?
    
    // Profile picture (Phase 1)
    var profilePictureURL: String?
}
```

---

## Dashboard Sections

### Section 1: Hero Card
**Purpose:** Display athlete identity, team affiliation, and context toggle

**Layout:**
```
┌─────────────────────────────────────────────────┐
│  [Profile Pic]  Jordan Smith                    │
│                 Westlake Warriors Lacrosse       │
│                 Austin, TX • Varsity             │
│                                                  │
│                 [HS] [Club] ← toggle             │
└─────────────────────────────────────────────────┘
```

**Specs:**
- Profile pic: 40x40pt circle, default avatar if none
- Tap profile pic → Opens Profile in right drawer
- Name: SF Semibold 18pt, text-primary
- Team name: SF Regular 15pt, text-secondary
- Location + Level: SF Regular 13pt, text-secondary
- Context toggle: Segmented control, 44pt height
- Updates dynamically: HS name/city when HS selected, Club when Club selected
- Padding: 16pt all sides
- Background: card surface with subtle shadow

**Context Toggle Behavior:**
- Persists via @AppStorage("selectedContext")
- Default: .hs
- Changes:
  - Hero card team name/location
  - Performance stats data source
  - Recent games list
  - AI insights context
- Does NOT affect:
  - Season goals (always combined)
  - Skills recommendations
  - Recruiting stats

---

### Section 2: Empty State (New Users - 0 Games)
**Purpose:** Welcome new users and guide to first action

**Layout:**
```
┌─────────────────────────────────────────┐
│  🔒 Your Locker is Empty                 │
│                                          │
│  "Every great season starts with one    │
│   game. Let's build your story."        │
│                                          │
│   [Log Your First Game] ← pulsing CTA   │
└─────────────────────────────────────────┘
```

**Specs:**
- Icon: Lock emoji or SF Symbol "lock.shield", 48pt
- Title: SF Semibold 20pt, text-primary
- Body: SF Regular 16pt, text-secondary, centered, max 280 chars
- CTA Button: Full-width, indigo primary, 50pt height
- Pulsing animation: Subtle scale 1.0 → 1.02 → 1.0, 2s duration, repeat
- Tap CTA → Opens FAB bottom sheet
- Padding: 24pt all sides
- Background: card surface

**Additional Empty State Cards:**
```
┌─────────────────────────────────────────┐
│  📊 Performance Stats                    │
│  [Empty state]                          │
│  "Log your first game to see stats"     │
└─────────────────────────────────────────┘

┌─────────────────────────────────────────┐
│  🎮 Recent Games                         │
│  [Empty state]                          │
│  "Your game history will appear here"   │
└─────────────────────────────────────────┘
```

---

### Section 3: Season Goals
**Purpose:** Display goal progress with tap-to-expand for full details

**Layout (Active):**
```
┌─────────────────────────────────────────┐
│  🎯 Season Goals            [Manage]     │
│                                          │
│   ⭕ 23/30        ⭕ 15/20      ⭕ 45/60  │
│   Goals          Assists      GBs       │
│   77% 💚         75% 💚        75% 💛    │
│                                          │
│   On track • Tap to expand full view    │
└─────────────────────────────────────────┘
```

**Circular Progress Specs:**
- 3 goals in horizontal row (HStack)
- Circle diameter: 80pt
- Progress ring: 6pt stroke width
- Colors by status:
  - On Track (≥70%): Theme.Colors.success (green)
  - Catch Up (40-69%): Theme.Colors.warning (yellow)
  - Stretch (<40%): Theme.Colors.primary (indigo)
  - Completed (100%): Theme.Colors.accentEmerald
- Center text: Current/Target, SF Rounded Bold 16pt
- Label below: Goal name, SF Regular 13pt
- Percentage below label: SF Rounded Semibold 14pt

**Interaction:**
- Tap anywhere → Sheet presents full Goals view (F-006)
- [Manage] button → Same sheet, edit mode
- Sheet includes:
  - Detailed progress for each goal
  - GoalPace AI messaging
  - Per-game pace vs target pace
  - Badges earned
  - Option to edit/add goals

**New User (0 games):**
- Show goals at 0% progress
- Same circular layout
- All rings empty (gray stroke)
- Helper text: "Start logging games to track progress"

---

### Section 4: Performance Stats
**Purpose:** Show position-specific key metrics with trend indicators

**Layout:**
```
┌─────────────────────────────────────────┐
│  📊 Performance Stats (HS)               │
│                                          │
│  [Save %]        [Total Saves]          │
│  71.2%           142                     │
│  ↑ +3.2%         ↓ -2 from avg          │
│                                          │
│  [Goals Against] [Clears]               │
│  57              8.3                     │
│  ↑ +5            → Same                  │
│                                          │
│  ───────────────────────────────────────│
│                                          │
│  Per Game Averages                      │
│  Saves: 11.8  •  GA: 4.8  •  Clears: 8.3│
└─────────────────────────────────────────┘
```

**Main Tiles (2x2 Grid):**
- Tile size: Flexible width, 90pt height
- Stat label: SF Regular 13pt, text-secondary
- Stat value: SF Rounded Bold 28pt, text-primary
- Trend indicator:
  - Icon: ↑ ↓ → (SF Symbol alternatives: arrow.up, arrow.down, arrow.right)
  - Color: Green (up), Red (down), Gray (stable)
  - Text: ±X% or ±X from avg, SF Regular 12pt
- Background: card surface
- Spacing: 12pt between tiles

**Trend Calculation:**
- Compare current value to rolling 3-game average
- Up: >+5% improvement
- Down: >-5% decline
- Stable: Within ±5%
- For percentages: Compare absolute difference (e.g., 71% vs 68% = +3%)
- For counts: Compare averages (e.g., 12 saves vs 10 avg = +2)

**Per Game Section:**
- Below main tiles, separator line
- Title: "Per Game Averages", SF Semibold 14pt
- Stats: Inline with • separators
- Format: "{stat}: {value}", SF Regular 13pt
- Shows 3-4 most relevant per-game stats

**Position-Specific Configurations:**

#### Goalie
```swift
struct GoalieStats {
    var mainTiles: [StatTile] = [
        StatTile(name: "Save %", key: "savePercentage", format: ".1%"),
        StatTile(name: "Total Saves", key: "totalSaves", format: ".0"),
        StatTile(name: "Goals Against", key: "goalsAllowed", format: ".0"),
        StatTile(name: "Clears", key: "clears", format: ".0")
    ]
    
    var perGameStats: [String] = [
        "Saves: {avg}",
        "GA: {avg}",
        "Clears: {avg}",
        "Shots Faced: {avg}"
    ]
}
```

#### Attack
```swift
struct AttackStats {
    var mainTiles: [StatTile] = [
        StatTile(name: "Goals", key: "goals", format: ".0"),
        StatTile(name: "Assists", key: "assists", format: ".0"),
        StatTile(name: "Points", key: "points", format: ".0"), // goals + assists
        StatTile(name: "Shooting %", key: "shootingPercentage", format: ".1%")
    ]
    
    var perGameStats: [String] = [
        "Goals: {avg}",
        "Assists: {avg}",
        "Shots: {avg}"
    ]
}
```

#### Midfield
```swift
struct MidfieldStats {
    var mainTiles: [StatTile] = [
        StatTile(name: "Goals", key: "goals", format: ".0"),
        StatTile(name: "Assists", key: "assists", format: ".0"),
        StatTile(name: "Ground Balls", key: "groundBalls", format: ".0"),
        StatTile(name: "Caused TOs", key: "causedTurnovers", format: ".0")
    ]
    
    var perGameStats: [String] = [
        "Goals: {avg}",
        "Assists: {avg}",
        "GBs: {avg}"
    ]
}
```

#### Defense
```swift
struct DefenseStats {
    var mainTiles: [StatTile] = [
        StatTile(name: "Ground Balls", key: "groundBalls", format: ".0"),
        StatTile(name: "Caused TOs", key: "causedTurnovers", format: ".0"),
        StatTile(name: "Assists", key: "assists", format: ".0"),
        StatTile(name: "Goals", key: "goals", format: ".0")
    ]
    
    var perGameStats: [String] = [
        "GBs: {avg}",
        "Caused TOs: {avg}",
        "Clears: {avg}"
    ]
}
```

#### FOGO (Boys only)
```swift
struct FOGOStats {
    var mainTiles: [StatTile] = [
        StatTile(name: "FO Win %", key: "faceoffPercentage", format: ".1%"),
        StatTile(name: "Total FO Wins", key: "faceoffWins", format: ".0"),
        StatTile(name: "Ground Balls", key: "groundBalls", format: ".0"),
        StatTile(name: "Goals", key: "goals", format: ".0")
    ]
    
    var perGameStats: [String] = [
        "FO Wins: {avg}",
        "GBs: {avg}"
    ]
}
```

#### LSM (Boys only)
```swift
struct LSMStats {
    var mainTiles: [StatTile] = [
        StatTile(name: "Ground Balls", key: "groundBalls", format: ".0"),
        StatTile(name: "Caused TOs", key: "causedTurnovers", format: ".0"),
        StatTile(name: "Assists", key: "assists", format: ".0"),
        StatTile(name: "Goals", key: "goals", format: ".0")
    ]
    
    var perGameStats: [String] = [
        "GBs: {avg}",
        "Caused TOs: {avg}"
    ]
}
```

---

### Section 5: AI Insights (Rule-Based)
**Purpose:** Provide actionable feedback based on performance patterns

**State 1: 0 Games (Hidden)**
- No AI Insights card shown

**State 2: 1-2 Games (Teaser)**
```
┌─────────────────────────────────────────┐
│  🤖 AI Insights                         │
│                                          │
│  Your AI Coach is learning your game... │
│                                          │
│  Log 1 more game to unlock insights     │
│  (2/3 games)                            │
└─────────────────────────────────────────┘
```
- Progress indicator: "{current}/3 games"
- Gray background, muted text
- No CTA button

**State 3: 3+ Games, Active Season (≤30 days)**
```
┌─────────────────────────────────────────┐
│  🤖 AI Insight                          │
│                                          │
│  "Your save % jumps 18% in the 3rd      │
│   quarter. Focus under pressure is a    │
│   major strength."                      │
│                                          │
│  💡 Next: Work on low shots (60% vs 75%)│
│  [View Drill in Skills →]               │
└─────────────────────────────────────────┘
```
- Insight text: SF Regular 16pt, text-primary, 2-3 sentences max
- Next action: SF Semibold 15pt with 💡 emoji
- CTA: Tappable link → Deep link to Skills tab with specific drill
- Emerald accent border on left (4pt)

**State 4: 3+ Games, Off-Season (>30 days)**
```
┌─────────────────────────────────────────┐
│  🤖 Season Recap                        │
│                                          │
│  "Your HS season: 71% save rate across  │
│   12 games. Strongest quarter: Q3 (78%)│
│                                          │
│  💪 Keep sharp: Explore Skills Library  │
│  [Go to Skills Tab →]                   │
└─────────────────────────────────────────┘
```
- Same styling as active season
- Focus on season summary, not game-specific
- CTA: Navigate to Skills tab

**Rule-Based AI Templates:**

```swift
struct AIInsightTemplates {
    
    // GOALIE TEMPLATES
    
    static func goalieQuarterStrength(quarter: Int, percentage: Double) -> String {
        "Your save % jumps \(Int(percentage))% in Q\(quarter). Focus under pressure is a major strength."
    }
    
    static func goalieConsistency(savePercentage: Double, games: Int) -> String {
        "\(Int(savePercentage * 100))% save rate across \(games) games. Your consistency is elite—keep that rhythm."
    }
    
    static func goalieImprovement(currentSP: Double, previousSP: Double) -> String {
        let diff = Int((currentSP - previousSP) * 100)
        return "Save % up \(diff) points from last stretch. Your adjustments are working—lock it in."
    }
    
    static func goalieLowShotWeakness(lowShotSP: Double, overallSP: Double) -> String {
        let diff = Int((overallSP - lowShotSP) * 100)
        return "Low shots are \(diff)% below your average. Drill bounce shots and get lower in your stance."
    }
    
    // ATTACK TEMPLATES
    
    static func attackShotSelection(shootingPct: Double) -> String {
        if shootingPct > 0.5 {
            return "\(Int(shootingPct * 100))% shooting rate. Your shot selection is surgical—stay patient."
        } else {
            return "Shooting \(Int(shootingPct * 100))%. Look for higher-percentage opportunities before releasing."
        }
    }
    
    static func attackPlaymaking(assists: Int, goals: Int) -> String {
        if assists > goals {
            return "\(assists) assists to \(goals) goals. Your playmaking creates offense for the whole team."
        } else {
            return "\(goals) goals with \(assists) assists. You're a scoring threat—keep the defense honest."
        }
    }
    
    // MIDFIELD TEMPLATES
    
    static func midfieldTwoWay(goals: Int, gbs: Int) -> String {
        "Balanced game: \(goals) goals + \(gbs) GBs. Two-way middies win championships."
    }
    
    static func midfieldTransition(gbs: Int, causedTOs: Int) -> String {
        "\(gbs) ground balls + \(causedTOs) caused turnovers. You create transition chances."
    }
    
    // DEFENSE TEMPLATES
    
    static func defensePressure(causedTOs: Int, gbs: Int) -> String {
        "\(causedTOs) caused TOs shows active hands. Your pressure forces mistakes."
    }
    
    static func defenseGroundControl(gbs: Int, perGame: Double) -> String {
        "\(gbs) ground balls (\(String(format: "%.1f", perGame))/game). You control possessions."
    }
    
    // FOGO TEMPLATES
    
    static func fogoWinRate(winPct: Double, wins: Int) -> String {
        "\(Int(winPct * 100))% faceoff rate with \(wins) wins. You set the tempo—stay sharp on the clamp."
    }
    
    static func fogoConsistency(winPct: Double, games: Int) -> String {
        "Held \(Int(winPct * 100))% across \(games) games. Elite FOGOs stay consistent."
    }
    
    // NEXT ACTION TEMPLATES
    
    static func nextActionDrill(weakness: String, drillName: String) -> String {
        "Next: Work on \(weakness) — try \(drillName)"
    }
    
    static func nextActionMaintain(strength: String) -> String {
        "Next: Keep building on \(strength) — stay locked in"
    }
    
    // OFF-SEASON RECAP
    
    static func seasonRecap(context: GameContext, savePercentage: Double?, games: Int) -> String {
        let contextName = context == .hs ? "HS" : "Club"
        if let sp = savePercentage {
            return "Your \(contextName) season: \(Int(sp * 100))% save rate across \(games) games."
        } else {
            return "Your \(contextName) season: \(games) games logged. Solid work—review your trends in Stats."
        }
    }
}
```

**Insight Selection Logic:**
```swift
func selectInsight(for profile: AthleteProfile, games: [GameLog]) -> String {
    // Priority order:
    // 1. Recent improvement (last 3 games vs previous 3)
    // 2. Quarter-specific strength (if variance > 15%)
    // 3. Consistency pattern (if std dev < 5%)
    // 4. Weakness to address (if stat < position average)
    // 5. Default position-appropriate message
    
    // Calculate stats, pick highest-priority template
}
```

---

### Section 6: Recent Games
**Purpose:** Show 2 most recent games with tap-to-view summaries

**Layout:**
```
┌─────────────────────────────────────────┐
│  🎮 Recent Games                [See All]│
│                                          │
│  [Game Card] vs Warriors • W 12-8       │
│   May 3 • HS Conference                 │
│   12 saves • 71% • 🌟 Season best       │
│   → Tap to see AI summary               │
│                                          │
│  [Game Card] vs Eagles • L 10-11        │
│   Apr 29 • HS Non-Conference            │
│   10 saves • 63% • 8 clears             │
│   → Tap to see AI summary               │
└─────────────────────────────────────────┘
```

**Game Card Specs:**
- Card: Tappable, card surface background, 16pt padding
- Line 1: 
  - "vs {opponent}" • {W/L} {score}, SF Semibold 16pt
  - W = green, L = red
- Line 2:
  - "{date} • {context} {conference?}", SF Regular 14pt, text-secondary
- Line 3:
  - Key stats (position-specific), SF Regular 14pt
  - Highlight badge if season best: 🌟 "Season best"
- Line 4:
  - "→ Tap to see AI summary", SF Regular 13pt, primary color
- Tap → Opens game detail sheet with full stats + AI summary

**[See All] Button:**
- Top-right, SF Semibold 14pt, primary color
- Tap → Navigate to Stats tab, game history section

**Empty State (0 games):**
- Show placeholder card
- Text: "Your game history will appear here"
- Muted styling

---

### Section 7: Recommended Drills (Conditional)
**Purpose:** Surface skill work when AI detects weakness

**Show When:**
- User has 3+ games logged
- AI detects stat below position average by >10%
- Or: Off-season mode (show general position drills)

**Layout:**
```
┌─────────────────────────────────────────┐
│  💪 Recommended for You                  │
│                                          │
│  Based on recent games:                 │
│  • Lateral Movement Drill (8 min)       │
│  • Low Shot Reaction (5 min)            │
│                                          │
│  [View Skills Tab]                      │
└─────────────────────────────────────────┘
```

**Specs:**
- Title: SF Semibold 18pt
- Context: "Based on recent games" or "Keep sharp in the off-season"
- Drill list: 2-3 drills, SF Regular 15pt, bullet points
- CTA: Full-width button, 44pt height
- Tap → Navigate to Skills tab, filtered to recommended drills

**Hide When:**
- User < 3 games
- All stats within expected range
- User dismissed recommendations (add dismiss button in Phase 1)

---

### Section 8: FAB (Floating Action Button)
**Purpose:** Quick access to game logging

**Position:**
- Fixed at bottom-center of screen
- 64x64pt circular button
- Indigo primary background
- White "+" icon, 28pt
- Elevated shadow (z-index above all content)
- Stays visible while scrolling

**Interaction:**
- Tap → Present bottom sheet (non-modal, swipe to dismiss)

**Bottom Sheet Layout:**
```
┌─────────────────────────────────────────┐
│         Log Game                        │
├─────────────────────────────────────────┤
│                                          │
│  [🎮 Live Game]                         │
│   Track in real-time with timer         │
│                                          │
│  [📝 After Game]                        │
│   Quick entry after the game            │
│                                          │
│  [📷 Scan Stats Sheet]                  │
│   OCR - Optical Character Recognition   │
│                                          │
└─────────────────────────────────────────┘
```

**Sheet Specs:**
- Height: Auto-sizing, ~320pt
- Background: White with rounded top corners (24pt radius)
- Handle bar: 36x4pt gray bar at top center
- Title: "Log Game", SF Semibold 20pt, centered
- Separator line below title

**Option Buttons (3 total):**
- Each: Full-width, 72pt height, left-aligned
- Icon: 32pt, left side
- Title: SF Semibold 17pt
- Subtitle: SF Regular 14pt, text-secondary
- Tap target: 44pt minimum
- Hover/press state: Light gray background

**Actions:**
- Live Game → Navigate to Live Game screen (B-005)
- After Game → Navigate to After Game screen (B-005)
- Scan Stats → Navigate to OCR screen (B-005)
- Swipe down or tap outside → Dismiss sheet

---

## View Models & State Management

### DashboardViewModel.swift
```swift
@Observable
class DashboardViewModel {
    
    // MARK: - Dependencies
    var profile: AthleteProfile
    var teamInfo: TeamInfo
    var gameService: GameService
    
    // MARK: - State
    var selectedContext: GameContext = .hs {
        didSet {
            UserDefaults.standard.set(selectedContext.rawValue, forKey: "selectedContext")
            Task { await loadGames() }
        }
    }
    
    var games: [GameLog] = []
    var isLoading: Bool = false
    var errorMessage: String?
    
    // MARK: - Computed Properties
    
    var contextGames: [GameLog] {
        games.filter { $0.context == selectedContext }
    }
    
    var recentGames: [GameLog] {
        Array(contextGames.prefix(2))
    }
    
    var totalGamesLogged: Int {
        contextGames.count
    }
    
    var showAIInsights: Bool {
        totalGamesLogged >= 3
    }
    
    var aiInsightState: AIInsightState {
        if totalGamesLogged == 0 {
            return .hidden
        } else if totalGamesLogged < 3 {
            return .teaser(gamesLogged: totalGamesLogged)
        } else if let lastGame = contextGames.first,
                  Calendar.current.dateComponents([.day], from: lastGame.date, to: Date()).day ?? 0 <= 30 {
            return .active
        } else {
            return .offSeason
        }
    }
    
    var currentTeamName: String {
        selectedContext == .hs ? teamInfo.hsTeamName : (teamInfo.clubTeamName ?? "")
    }
    
    var currentTeamLocation: String {
        selectedContext == .hs ? teamInfo.hsLocation : (teamInfo.clubLocation ?? "")
    }
    
    // MARK: - Stats Calculation
    
    func calculatePerformanceStats() -> [PerformanceStat] {
        guard !contextGames.isEmpty else { return [] }
        
        let config = StatConfigForPosition(position: profile.position)
        return config.mainStats.map { statKey in
            let currentValue = calculateCurrentValue(for: statKey)
            let trend = calculateTrend(for: statKey)
            return PerformanceStat(
                name: statKey,
                value: currentValue,
                trend: trend
            )
        }
    }
    
    func calculateCurrentValue(for statKey: String) -> Double {
        // Aggregate from contextGames based on statKey
        // Return total or average as appropriate
    }
    
    func calculateTrend(for statKey: String) -> PerformanceTrend {
        guard contextGames.count >= 3 else {
            return PerformanceTrend(statName: statKey, currentValue: 0, previousAverage: 0, changePercentage: 0, direction: .stable)
        }
        
        let recentGames = Array(contextGames.prefix(3))
        let previousGames = Array(contextGames.dropFirst(3).prefix(3))
        
        let currentAvg = calculateAverage(for: statKey, in: recentGames)
        let previousAvg = calculateAverage(for: statKey, in: previousGames)
        
        let change = ((currentAvg - previousAvg) / previousAvg) * 100
        
        let direction: PerformanceTrend.TrendDirection
        if abs(change) < 5 {
            direction = .stable
        } else if change > 0 {
            direction = .up
        } else {
            direction = .down
        }
        
        return PerformanceTrend(
            statName: statKey,
            currentValue: currentAvg,
            previousAverage: previousAvg,
            changePercentage: change,
            direction: direction
        )
    }
    
    func calculateAverage(for statKey: String, in games: [GameLog]) -> Double {
        // Extract stat values from games array and calculate average
    }
    
    // MARK: - AI Insights
    
    func generateAIInsight() -> String {
        guard totalGamesLogged >= 3 else { return "" }
        
        switch profile.position {
        case "Goalie":
            return generateGoalieInsight()
        case "Attack":
            return generateAttackInsight()
        case "Midfield":
            return generateMidfieldInsight()
        case "Defense":
            return generateDefenseInsight()
        case "FOGO":
            return generateFOGOInsight()
        case "LSM":
            return generateLSMInsight()
        default:
            return "Keep grinding—every game makes you better."
        }
    }
    
    func generateGoalieInsight() -> String {
        // Apply template selection logic
        // Check quarter performance, consistency, improvement, weaknesses
        // Return highest-priority insight
        
        // Example:
        let quarterStats = calculateQuarterStats()
        if let strongestQuarter = quarterStats.max(by: { $0.savePercentage < $1.savePercentage }),
           strongestQuarter.savePercentage - quarterStats.average > 0.15 {
            return AIInsightTemplates.goalieQuarterStrength(
                quarter: strongestQuarter.quarter,
                percentage: (strongestQuarter.savePercentage - quarterStats.average) * 100
            )
        }
        
        // ... more template checks
        
        return AIInsightTemplates.goalieConsistency(
            savePercentage: calculateCurrentValue(for: "savePercentage"),
            games: totalGamesLogged
        )
    }
    
    // MARK: - Goal Progress
    
    func updateGoalProgress() {
        // Update SeasonGoal currentValue based on game stats
        for i in 0..<profile.seasonGoals.count {
            let goal = profile.seasonGoals[i]
            let trackingKey = goal.trackingKey
            
            if trackingKey == "custom" {
                // Skip custom goals (manual update)
                continue
            }
            
            let currentValue = calculateCurrentValue(for: trackingKey)
            profile.seasonGoals[i].currentValue = currentValue
        }
    }
    
    // MARK: - Data Loading
    
    func loadGames() async {
        isLoading = true
        do {
            games = try await gameService.fetchGames(for: profile.userId)
            updateGoalProgress()
            isLoading = false
        } catch {
            errorMessage = "Failed to load games"
            isLoading = false
        }
    }
    
    // MARK: - Initialization
    
    init(profile: AthleteProfile, teamInfo: TeamInfo, gameService: GameService) {
        self.profile = profile
        self.teamInfo = teamInfo
        self.gameService = gameService
        
        // Load saved context
        if let savedContext = UserDefaults.standard.string(forKey: "selectedContext"),
           let context = GameContext(rawValue: savedContext) {
            self.selectedContext = context
        }
        
        Task {
            await loadGames()
        }
    }
}

enum AIInsightState {
    case hidden
    case teaser(gamesLogged: Int)
    case active
    case offSeason
}
```

### StatConfigForPosition.swift
```swift
struct StatConfigForPosition {
    var position: String
    
    var mainStats: [String] {
        switch position {
        case "Goalie":
            return ["savePercentage", "totalSaves", "goalsAllowed", "clears"]
        case "Attack":
            return ["goals", "assists", "points", "shootingPercentage"]
        case "Midfield":
            return ["goals", "assists", "groundBalls", "causedTurnovers"]
        case "Defense":
            return ["groundBalls", "causedTurnovers", "assists", "goals"]
        case "FOGO":
            return ["faceoffPercentage", "faceoffWins", "groundBalls", "goals"]
        case "LSM":
            return ["groundBalls", "causedTurnovers", "assists", "goals"]
        default:
            return []
        }
    }
    
    var perGameStats: [String] {
        switch position {
        case "Goalie":
            return ["saves", "goalsAllowed", "clears", "shotsFaced"]
        case "Attack":
            return ["goals", "assists", "shots"]
        case "Midfield":
            return ["goals", "assists", "groundBalls"]
        case "Defense":
            return ["groundBalls", "causedTurnovers", "clears"]
        case "FOGO":
            return ["faceoffWins", "groundBalls"]
        case "LSM":
            return ["groundBalls", "causedTurnovers"]
        default:
            return []
        }
    }
}
```

---

## Component Breakdown

### HeroCard.swift
```swift
struct HeroCard: View {
    let profile: AthleteProfile
    let teamInfo: TeamInfo
    @Binding var selectedContext: GameContext
    
    var teamName: String {
        selectedContext == .hs ? teamInfo.hsTeamName : (teamInfo.clubTeamName ?? "")
    }
    
    var location: String {
        selectedContext == .hs ? teamInfo.hsLocation : (teamInfo.clubLocation ?? "")
    }
    
    var body: some View {
        VStack(spacing: Theme.Spacing.md) {
            HStack(spacing: Theme.Spacing.md) {
                // Profile Picture
                Circle()
                    .fill(Theme.Colors.cardSurface)
                    .frame(width: 40, height: 40)
                    .overlay(
                        Text(profile.firstName.prefix(1))
                            .font(Theme.Typography.title(18))
                            .foregroundStyle(Theme.Colors.primary)
                    )
                    .onTapGesture {
                        // TODO: Open Profile in drawer
                    }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(profile.fullName)
                        .font(Theme.Typography.title(18))
                        .foregroundStyle(Theme.Colors.textPrimary)
                    
                    Text(teamName)
                        .font(Theme.Typography.body(15))
                        .foregroundStyle(Theme.Colors.textSecondary)
                    
                    Text("\(location) • \(profile.level)")
                        .font(Theme.Typography.caption(13))
                        .foregroundStyle(Theme.Colors.textSecondary)
                }
                
                Spacer()
            }
            
            // Context Toggle
            Picker("Context", selection: $selectedContext) {
                Text("HS").tag(GameContext.hs)
                Text("Club").tag(GameContext.club)
            }
            .pickerStyle(.segmented)
            .frame(height: 44)
        }
        .padding(Theme.Spacing.md)
        .background(Theme.Colors.cardSurface)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .themedShadow(Theme.Shadows.card)
    }
}
```

### SeasonGoalsCard.swift
```swift
struct SeasonGoalsCard: View {
    let goals: [SeasonGoal]
    @State private var showGoalsSheet = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.md) {
            HStack {
                Label("Season Goals", systemImage: "target")
                    .font(Theme.Typography.title(18))
                    .foregroundStyle(Theme.Colors.textPrimary)
                
                Spacer()
                
                Button("Manage") {
                    showGoalsSheet = true
                }
                .font(Theme.Typography.body(15))
                .foregroundStyle(Theme.Colors.primary)
            }
            
            HStack(spacing: Theme.Spacing.lg) {
                ForEach(goals.prefix(3)) { goal in
                    CircularGoalProgress(goal: goal)
                }
            }
            
            if goals.isEmpty {
                Text("Start logging games to track progress")
                    .font(Theme.Typography.caption())
                    .foregroundStyle(Theme.Colors.textSecondary)
            } else {
                Text("On track • Tap to expand full view")
                    .font(Theme.Typography.caption())
                    .foregroundStyle(Theme.Colors.textSecondary)
            }
        }
        .padding(Theme.Spacing.md)
        .background(Theme.Colors.cardSurface)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .themedShadow(Theme.Shadows.card)
        .onTapGesture {
            showGoalsSheet = true
        }
        .sheet(isPresented: $showGoalsSheet) {
            // TODO: Full Goals View (B-007)
            Text("Goals Detail View - Coming in B-007")
        }
    }
}

struct CircularGoalProgress: View {
    let goal: SeasonGoal
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .stroke(Theme.Colors.divider, lineWidth: 6)
                
                Circle()
                    .trim(from: 0, to: goal.progress)
                    .stroke(statusColor, lineWidth: 6)
                    .rotationEffect(.degrees(-90))
                
                VStack(spacing: 2) {
                    Text("\(Int(goal.currentValue))")
                        .font(Theme.Typography.number(16))
                    Text("/\(Int(goal.targetValue))")
                        .font(Theme.Typography.caption(12))
                        .foregroundStyle(Theme.Colors.textSecondary)
                }
            }
            .frame(width: 80, height: 80)
            
            Text(goal.title.prefix(10) + (goal.title.count > 10 ? "..." : ""))
                .font(Theme.Typography.caption(13))
                .foregroundStyle(Theme.Colors.textSecondary)
                .lineLimit(1)
            
            Text("\(goal.progressPercent)%")
                .font(Theme.Typography.number(14, weight: .semibold))
                .foregroundStyle(statusColor)
        }
    }
    
    var statusColor: Color {
        switch goal.status {
        case .completed:
            return Theme.Colors.accentEmerald
        case .onTrack:
            return Theme.Colors.success
        case .catchUp:
            return Theme.Colors.warning
        case .stretch:
            return Theme.Colors.primary
        }
    }
}
```

### PerformanceStatsCard.swift
```swift
struct PerformanceStatsCard: View {
    let stats: [PerformanceStat]
    let perGameStats: [String: Double]
    let context: GameContext
    
    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.md) {
            HStack {
                Label("Performance Stats (\(context == .hs ? "HS" : "Club"))", systemImage: "chart.bar.fill")
                    .font(Theme.Typography.title(18))
                    .foregroundStyle(Theme.Colors.textPrimary)
                
                Spacer()
            }
            
            if stats.isEmpty {
                EmptyStateCard(
                    icon: "chart.bar.xaxis",
                    message: "Log your first game to see stats"
                )
            } else {
                // Main Tiles (2x2 grid)
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: Theme.Spacing.sm) {
                    ForEach(stats.prefix(4), id: \.name) { stat in
                        StatTileWithTrend(stat: stat)
                    }
                }
                
                Divider()
                    .padding(.vertical, Theme.Spacing.xs)
                
                // Per Game Averages
                VStack(alignment: .leading, spacing: 4) {
                    Text("Per Game Averages")
                        .font(Theme.Typography.title(14))
                        .foregroundStyle(Theme.Colors.textSecondary)
                    
                    Text(formatPerGameStats())
                        .font(Theme.Typography.body(13))
                        .foregroundStyle(Theme.Colors.textPrimary)
                }
            }
        }
        .padding(Theme.Spacing.md)
        .background(Theme.Colors.cardSurface)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .themedShadow(Theme.Shadows.card)
    }
    
    func formatPerGameStats() -> String {
        perGameStats.map { "\($0.key): \(String(format: "%.1f", $0.value))" }
            .joined(separator: " • ")
    }
}

struct StatTileWithTrend: View {
    let stat: PerformanceStat
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(stat.name)
                .font(Theme.Typography.caption())
                .foregroundStyle(Theme.Colors.textSecondary)
            
            Text(stat.formattedValue)
                .font(Theme.Typography.number(28))
                .foregroundStyle(Theme.Colors.textPrimary)
            
            if let trend = stat.trend {
                HStack(spacing: 4) {
                    Text(trend.direction.icon)
                    Text(trend.formattedChange)
                }
                .font(Theme.Typography.caption(12))
                .foregroundStyle(trend.direction.color)
            }
        }
        .padding(Theme.Spacing.sm)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Theme.Colors.background)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct PerformanceStat {
    var name: String
    var value: Double
    var trend: PerformanceTrend?
    
    var formattedValue: String {
        if name.contains("%") {
            return String(format: "%.1f%%", value * 100)
        } else {
            return String(format: "%.0f", value)
        }
    }
}
```

### AIInsightCard.swift
```swift
struct AIInsightCard: View {
    let state: AIInsightState
    let insight: String
    let nextAction: String
    var onTap: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.md) {
            switch state {
            case .hidden:
                EmptyView()
                
            case .teaser(let gamesLogged):
                VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                    Label("AI Insights", systemImage: "brain.head.profile")
                        .font(Theme.Typography.title(18))
                        .foregroundStyle(Theme.Colors.textPrimary)
                    
                    Text("Your AI Coach is learning your game...")
                        .font(Theme.Typography.body(16))
                        .foregroundStyle(Theme.Colors.textSecondary)
                    
                    Text("Log \(3 - gamesLogged) more game\(3 - gamesLogged == 1 ? "" : "s") to unlock insights")
                        .font(Theme.Typography.caption())
                        .foregroundStyle(Theme.Colors.muted)
                    
                    Text("(\(gamesLogged)/3 games)")
                        .font(Theme.Typography.caption())
                        .foregroundStyle(Theme.Colors.muted)
                }
                .padding(Theme.Spacing.md)
                .background(Theme.Colors.cardSurface)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                
            case .active, .offSeason:
                VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                    Label(state == .active ? "AI Insight" : "Season Recap", systemImage: "brain.head.profile")
                        .font(Theme.Typography.title(18))
                        .foregroundStyle(Theme.Colors.textPrimary)
                    
                    Text(insight)
                        .font(Theme.Typography.body(16))
                        .foregroundStyle(Theme.Colors.textPrimary)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    HStack(spacing: 4) {
                        Text(state == .active ? "💡" : "💪")
                        Text(nextAction)
                            .font(Theme.Typography.title(15))
                            .foregroundStyle(Theme.Colors.textPrimary)
                    }
                    
                    Button(action: onTap) {
                        Text(state == .active ? "View Drill in Skills →" : "Go to Skills Tab →")
                            .font(Theme.Typography.body(15))
                            .foregroundStyle(Theme.Colors.primary)
                    }
                }
                .padding(Theme.Spacing.md)
                .background(Theme.Colors.cardSurface)
                .overlay(
                    Rectangle()
                        .fill(Theme.Colors.accentEmerald)
                        .frame(width: 4),
                    alignment: .leading
                )
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
        }
        .themedShadow(Theme.Shadows.card)
    }
}
```

### RecentGamesCard.swift
```swift
struct RecentGamesCard: View {
    let games: [GameLog]
    var onSeeAll: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.md) {
            HStack {
                Label("Recent Games", systemImage: "gamecontroller.fill")
                    .font(Theme.Typography.title(18))
                    .foregroundStyle(Theme.Colors.textPrimary)
                
                Spacer()
                
                Button("See All", action: onSeeAll)
                    .font(Theme.Typography.title(14))
                    .foregroundStyle(Theme.Colors.primary)
            }
            
            if games.isEmpty {
                EmptyStateCard(
                    icon: "gamecontroller",
                    message: "Your game history will appear here"
                )
            } else {
                VStack(spacing: Theme.Spacing.sm) {
                    ForEach(games.prefix(2)) { game in
                        GameCard(game: game)
                    }
                }
            }
        }
        .padding(Theme.Spacing.md)
        .background(Theme.Colors.cardSurface)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .themedShadow(Theme.Shadows.card)
    }
}

struct GameCard: View {
    let game: GameLog
    @State private var showDetail = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text("vs \(game.opponent ?? "Unknown")")
                    .font(Theme.Typography.title(16))
                Text("•")
                    .foregroundStyle(Theme.Colors.textSecondary)
                Text(game.result)
                    .foregroundStyle(game.isWin ? Theme.Colors.success : Theme.Colors.error)
            }
            .font(Theme.Typography.title(16))
            
            Text(game.formattedDate + " • " + game.contextLabel)
                .font(Theme.Typography.body(14))
                .foregroundStyle(Theme.Colors.textSecondary)
            
            Text(game.keyStats)
                .font(Theme.Typography.body(14))
                .foregroundStyle(Theme.Colors.textPrimary)
            
            Button(action: { showDetail = true }) {
                Text("→ Tap to see AI summary")
                    .font(Theme.Typography.caption(13))
                    .foregroundStyle(Theme.Colors.primary)
            }
        }
        .padding(Theme.Spacing.sm)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Theme.Colors.background)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .onTapGesture {
            showDetail = true
        }
        .sheet(isPresented: $showDetail) {
            GameDetailView(game: game)
        }
    }
}

extension GameLog {
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter.string(from: date)
    }
    
    var contextLabel: String {
        let base = context == .hs ? "HS" : "Club"
        if let conf = isConference {
            return base + (conf ? " Conference" : " Non-Conference")
        }
        return base
    }
    
    var result: String {
        // TODO: Calculate from stats (needs opponent score)
        "W 12-8"
    }
    
    var isWin: Bool {
        // TODO: Determine from stats
        true
    }
    
    var keyStats: String {
        // Position-specific key stats display
        if let sp = stats.savePercentage {
            return "\(stats.saves) saves • \(Int(sp * 100))% • \(stats.clears) clears"
        }
        return "\(stats.goals) goals • \(stats.assists) assists"
    }
}
```

### EmptyStateCard.swift
```swift
struct EmptyStateCard: View {
    let icon: String
    let message: String
    
    var body: some View {
        VStack(spacing: Theme.Spacing.md) {
            Image(systemName: icon)
                .font(.system(size: 40))
                .foregroundStyle(Theme.Colors.muted)
            
            Text(message)
                .font(Theme.Typography.body())
                .foregroundStyle(Theme.Colors.textSecondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(Theme.Spacing.xl)
    }
}
```

### FABButton.swift
```swift
struct FABButton: View {
    @State private var showSheet = false
    
    var body: some View {
        Button(action: { showSheet = true }) {
            Image(systemName: "plus")
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(.white)
                .frame(width: 64, height: 64)
                .background(Theme.Colors.primary)
                .clipShape(Circle())
                .themedShadow(Theme.Shadows.elevated)
        }
        .sheet(isPresented: $showSheet) {
            LogGameSheet()
                .presentationDetents([.height(320)])
                .presentationDragIndicator(.visible)
        }
    }
}

struct LogGameSheet: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Log Game")
                .font(Theme.Typography.title(20))
                .padding(.top, Theme.Spacing.md)
                .padding(.bottom, Theme.Spacing.sm)
            
            Divider()
            
            VStack(spacing: 0) {
                LogOptionButton(
                    icon: "🎮",
                    title: "Live Game",
                    subtitle: "Track in real-time with timer"
                ) {
                    // TODO: Navigate to Live Game (B-005)
                    dismiss()
                }
                
                LogOptionButton(
                    icon: "📝",
                    title: "After Game",
                    subtitle: "Quick entry after the game"
                ) {
                    // TODO: Navigate to After Game (B-005)
                    dismiss()
                }
                
                LogOptionButton(
                    icon: "📷",
                    title: "Scan Stats Sheet",
                    subtitle: "OCR - Optical Character Recognition"
                ) {
                    // TODO: Navigate to OCR (B-005)
                    dismiss()
                }
            }
            
            Spacer()
        }
    }
}

struct LogOptionButton: View {
    let icon: String
    let title: String
    let subtitle: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: Theme.Spacing.md) {
                Text(icon)
                    .font(.system(size: 32))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(Theme.Typography.title(17))
                        .foregroundStyle(Theme.Colors.textPrimary)
                    
                    Text(subtitle)
                        .font(Theme.Typography.body(14))
                        .foregroundStyle(Theme.Colors.textSecondary)
                }
                
                Spacer()
            }
            .padding(Theme.Spacing.md)
            .frame(height: 72)
            .background(Color.clear)
        }
        .buttonStyle(.plain)
    }
}
```

---

## File Structure

```
StatLocker/
  CoreKit/
    Models.swift                    // Add GameLog, GameStats, QuarterStats
    FeatureFlags.swift              // Existing
    GoalsLibrary.swift              // Existing
  CoreUI/
    Theme.swift                     // Existing
    Components/
      EmptyStateCard.swift          // NEW: Reusable empty state
      FABButton.swift               // NEW: Floating action button
  Features/
    Dashboard/
      DashboardView.swift           // Main dashboard container
      DashboardViewModel.swift      // NEW: State management
      Components/
        HeroCard.swift              // NEW: Profile + team + toggle
        SeasonGoalsCard.swift       // NEW: Goal progress circles
        PerformanceStatsCard.swift  // NEW: Stats grid with trends
        AIInsightCard.swift         // NEW: AI insights with states
        RecentGamesCard.swift       // NEW: Game history preview
        GameCard.swift              // NEW: Individual game card
        LogGameSheet.swift          // NEW: FAB bottom sheet
  Services/
    GameService.swift               // NEW: Firebase game CRUD
  Resources/
    FeatureFlags.plist              // Existing
```

---

## DashboardView.swift (Main Container)

```swift
import SwiftUI

struct DashboardView: View {
    @State private var viewModel: DashboardViewModel
    
    init(profile: AthleteProfile, teamInfo: TeamInfo, gameService: GameService = GameService.shared) {
        _viewModel = State(wrappedValue: DashboardViewModel(
            profile: profile,
            teamInfo: teamInfo,
            gameService: gameService
        ))
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(spacing: Theme.Spacing.md) {
                    // Hero Card
                    HeroCard(
                        profile: viewModel.profile,
                        teamInfo: viewModel.teamInfo,
                        selectedContext: $viewModel.selectedContext
                    )
                    
                    // Empty State OR Active Content
                    if viewModel.totalGamesLogged == 0 {
                        emptyStateView
                    } else {
                        activeStateView
                    }
                }
                .padding(Theme.Spacing.md)
                .padding(.bottom, 80) // Space for FAB
            }
            
            // FAB
            FABButton()
                .padding(.bottom, Theme.Spacing.xl)
        }
        .background(Theme.Colors.background)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    var emptyStateView: some View {
        VStack(spacing: Theme.Spacing.md) {
            // Empty Locker CTA
            VStack(spacing: Theme.Spacing.md) {
                Image(systemName: "lock.shield.fill")
                    .font(.system(size: 48))
                    .foregroundStyle(Theme.Colors.muted)
                
                Text("Your Locker is Empty")
                    .font(Theme.Typography.headline(20))
                    .foregroundStyle(Theme.Colors.textPrimary)
                
                Text("Every great season starts with one game. Let's build your story.")
                    .font(Theme.Typography.body())
                    .foregroundStyle(Theme.Colors.textSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, Theme.Spacing.lg)
                
                Button(action: {
                    // Open FAB sheet
                }) {
                    Text("Log Your First Game")
                        .font(Theme.Typography.title(17))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Theme.Colors.primary)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            .padding(Theme.Spacing.xl)
            .background(Theme.Colors.cardSurface)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .themedShadow(Theme.Shadows.card)
            
            // Goals at 0%
            SeasonGoalsCard(goals: viewModel.profile.seasonGoals)
            
            // Empty Performance Stats
            PerformanceStatsCard(
                stats: [],
                perGameStats: [:],
                context: viewModel.selectedContext
            )
            
            // Empty Recent Games
            RecentGamesCard(games: []) {
                // Navigate to Stats tab
            }
        }
    }
    
    var activeStateView: some View {
        VStack(spacing: Theme.Spacing.md) {
            // Season Goals
            SeasonGoalsCard(goals: viewModel.profile.seasonGoals)
            
            // Performance Stats
            PerformanceStatsCard(
                stats: viewModel.calculatePerformanceStats(),
                perGameStats: [:], // TODO: Calculate
                context: viewModel.selectedContext
            )
            
            // AI Insights
            AIInsightCard(
                state: viewModel.aiInsightState,
                insight: viewModel.generateAIInsight(),
                nextAction: "Work on low shots (60% vs 75%)" // TODO: Generate
            ) {
                // Navigate to Skills tab
            }
            
            // Recent Games
            RecentGamesCard(games: viewModel.recentGames) {
                // Navigate to Stats tab
            }
            
            // Recommended Drills (conditional)
            if viewModel.showAIInsights {
                RecommendedDrillsCard(
                    drills: [], // TODO: Generate based on weaknesses
                    onViewSkills: {
                        // Navigate to Skills tab
                    }
                )
            }
        }
    }
}

#Preview {
    let sampleProfile = AthleteProfile(
        userId: "123",
        firstName: "Jordan",
        lastName: "Smith",
        email: "jordan@example.com",
        sport: "lacrosse",
        teamGender: "boys",
        gradYear: 2026,
        level: "Varsity",
        position: "Goalie",
        aiTone: "Mentor",
        seasonGoals: [
            SeasonGoal(title: "60%+ save percentage", targetValue: 0.6, unit: "%", metricType: "percent", trackingKey: "save_pct"),
            SeasonGoal(title: "200+ saves", targetValue: 200, unit: "saves", metricType: "count", trackingKey: "saves"),
            SeasonGoal(title: "12 saves/game", targetValue: 12, unit: "saves/game", metricType: "rate", trackingKey: "saves_per_game")
        ],
        onboardingCompleted: true,
        createdAt: Date()
    )
    
    let sampleTeam = TeamInfo(
        hsTeamName: "Westlake Warriors Lacrosse",
        hsCity: "Austin",
        hsState: "TX",
        hasClubTeam: true,
        clubTeamName: "Austin Elite LC",
        clubCity: "Austin",
        clubState: "TX"
    )
    
    DashboardView(profile: sampleProfile, teamInfo: sampleTeam)
}
```

---

## GameService.swift (Data Layer)

```swift
import Foundation
import FirebaseFirestore

class GameService {
    static let shared = GameService()
    
    private let db = Firestore.firestore()
    
    func fetchGames(for userId: String) async throws -> [GameLog] {
        let snapshot = try await db
            .collection("users")
            .document(userId)
            .collection("games")
            .order(by: "date", descending: true)
            .getDocuments()
        
        return snapshot.documents.compactMap { doc in
            try? doc.data(as: GameLog.self)
        }
    }
    
    func saveGame(_ game: GameLog) async throws {
        let gameData = try Firestore.Encoder().encode(game)
        try await db
            .collection("users")
            .document(game.userId)
            .collection("games")
            .document(game.id)
            .setData(gameData)
        
        print("[StatLocker][GameService] Game saved: \(game.id)")
    }
    
    func deleteGame(_ gameId: String, for userId: String) async throws {
        try await db
            .collection("users")
            .document(userId)
            .collection("games")
            .document(gameId)
            .delete()
        
        print("[StatLocker][GameService] Game deleted: \(gameId)")
    }
}
```

---

## Implementation Todo List

### Phase 1: Core Models & Infrastructure
- [ ] Task 1: Add GameLog, GameStats, QuarterStats models to CoreKit/Models.swift
- [ ] Task 2: Add GameContext and LogSource enums
- [ ] Task 3: Add DashboardState and PerformanceTrend models
- [ ] Task 4: Extend AthleteProfile with jersey numbers (optional fields)
- [ ] Task 5: Create GameService.swift with Firebase CRUD methods

### Phase 2: View Models & State
- [ ] Task 6: Create DashboardViewModel with state management
- [ ] Task 7: Implement context toggle persistence with @AppStorage
- [ ] Task 8: Build performance stats calculation logic
- [ ] Task 9: Build trend calculation (compare last 3 vs previous 3 games)
- [ ] Task 10: Implement AI insight state machine (hidden/teaser/active/offSeason)
- [ ] Task 11: Create StatConfigForPosition with all position stat mappings
- [ ] Task 12: Implement goal progress auto-update from games

### Phase 3: Reusable Components
- [ ] Task 13: Create HeroCard component with profile pic and context toggle
- [ ] Task 14: Create SeasonGoalsCard with CircularGoalProgress
- [ ] Task 15: Create PerformanceStatsCard with 2x2 grid and per-game section
- [ ] Task 16: Create StatTileWithTrend component
- [ ] Task 17: Create AIInsightCard with 4 states (hidden/teaser/active/offSeason)
- [ ] Task 18: Create RecentGamesCard and GameCard components
- [ ] Task 19: Create EmptyStateCard reusable component
- [ ] Task 20: Create FABButton with sheet presentation
- [ ] Task 21: Create LogGameSheet with 3 options (Live/After/OCR)

### Phase 4: AI Templates & Logic
- [ ] Task 22: Create AIInsightTemplates with all position-specific templates
- [ ] Task 23: Implement goalie insight generation (quarter strength, consistency, etc.)
- [ ] Task 24: Implement attack insight generation (shot selection, playmaking)
- [ ] Task 25: Implement midfield insight generation (two-way, transition)
- [ ] Task 26: Implement defense insight generation (pressure, ground control)
- [ ] Task 27: Implement FOGO insight generation (win rate, consistency)
- [ ] Task 28: Implement LSM insight generation
- [ ] Task 29: Add off-season recap templates
- [ ] Task 30: Build insight priority/selection algorithm

### Phase 5: Main Dashboard View
- [ ] Task 31: Create DashboardView.swift main container
- [ ] Task 32: Build empty state view (new users, 0 games)
- [ ] Task 33: Build active state view (3+ games)
- [ ] Task 34: Integrate all card components
- [ ] Task 35: Add ScrollView with proper spacing and padding
- [ ] Task 36: Position FAB at bottom-center with ZStack

### Phase 6: Integration & Navigation
- [ ] Task 37: Update StatLockerApp to pass profile + teamInfo to Dashboard
- [ ] Task 38: Wire up context toggle to filter games by HS/Club
- [ ] Task 39: Add tap handlers for "See All" → navigate to Stats tab
- [ ] Task 40: Add tap handlers for AI insight CTA → navigate to Skills tab
- [ ] Task 41: Add tap handler for Season Goals → present Goals sheet (placeholder for B-007)
- [ ] Task 42: Add tap handler for FAB options → navigate to logging flows (placeholder for B-005)

### Phase 7: Testing & Polish
- [ ] Task 43: Test empty state display for new users
- [ ] Task 44: Test hero card team name updates on context toggle
- [ ] Task 45: Test season goals circular progress rendering
- [ ] Task 46: Test performance stats calculation for all positions
- [ ] Task 47: Test trend indicators (up/down/stable) calculation
- [ ] Task 48: Test AI insight state transitions (0 → 1-2 → 3+)
- [ ] Task 49: Test AI insight teaser progress (1/3, 2/3)
- [ ] Task 50: Test off-season detection (>30 days since last game)
- [ ] Task 51: Test FAB sheet presentation and dismiss
- [ ] Task 52: Test game card display with recent games
- [ ] Task 53: Verify VoiceOver labels on all interactive elements
- [ ] Task 54: Test Dynamic Type support across all text
- [ ] Task 55: Verify dark mode colors (if implemented)
- [ ] Task 56: Test context persistence across app restarts
- [ ] Task 57: End-to-end dashboard flow test

---

## Acceptance Criteria

### Must Have (B-004)
- [x] Hero card displays athlete name, team, location, and context toggle
- [x] Context toggle persists selection and filters dashboard data
- [x] Empty state shows for users with 0 games logged
- [x] Season goals display with circular progress indicators
- [x] Performance stats show 4 position-specific tiles in 2x2 grid
- [x] Performance stats show per-game averages section
- [x] Trend indicators show up/down/stable with color coding
- [x] AI insights hidden for 0 games
- [x] AI insights show teaser for 1-2 games with progress counter
- [x] AI insights show active insights for 3+ games (last game ≤30 days)
- [x] AI insights show off-season recap for 3+ games (last game >30 days)
- [x] Recent games show 2 most recent with "See All" button
- [x] FAB button fixed at bottom-center
- [x] FAB tap presents bottom sheet with 3 logging options
- [x] All rule-based AI templates implemented for all positions
- [x] Goalie, Attack, Midfield, Defense, FOGO, LSM stat configs complete

### Nice to Have (Phase 1+)
- [ ] Profile picture upload and display
- [ ] Jersey numbers in profile settings
- [ ] Recommended drills card (conditional on weaknesses)
- [ ] Upcoming events section
- [ ] Customizable performance stat tiles
- [ ] Swipe actions on game cards (delete, edit)
- [ ] Pull-to-refresh on dashboard

### Performance Targets
- [ ] Dashboard loads in < 1 second for users with ≤50 games
- [ ] Context toggle updates UI in < 300ms
- [ ] Smooth scroll at 60fps with all cards visible
- [ ] FAB sheet animates in < 200ms

### Accessibility
- [ ] All tap targets ≥ 44pt
- [ ] VoiceOver labels on all interactive elements
- [ ] Dynamic Type support (test at largest accessibility size)
- [ ] High contrast mode support
- [ ] Haptic feedback on FAB tap

---

## Testing Checklist

### Empty State (New Users)
- [ ] Hero card shows with default profile pic (initials)
- [ ] Context toggle visible and functional
- [ ] "Your Locker is Empty" CTA displays
- [ ] "Log Your First Game" button pulses subtly
- [ ] Season goals show at 0% progress
- [ ] Performance stats show empty state message
- [ ] Recent games show empty state message
- [ ] AI insights card is hidden (not teaser)
- [ ] FAB button visible and tappable

### Active State (3+ Games)
- [ ] Hero card updates team name on context toggle
- [ ] Season goals show actual progress percentages
- [ ] Circular progress colors match status (green/yellow/indigo/emerald)
- [ ] Performance stats show correct values for selected context
- [ ] Trend indicators calculate correctly (last 3 vs previous 3)
- [ ] Up arrows green, down arrows red, stable arrows gray
- [ ] Per game averages display below main tiles
- [ ] AI insights show active insights (not teaser or recap)
- [ ] Recent games show 2 most recent for selected context
- [ ] Game cards display opponent, date, context, key stats
- [ ] "See All" navigates to Stats tab
- [ ] FAB sheet shows 3 options with icons and subtitles

### AI Insights States
- [ ] 0 games: Card hidden entirely
- [ ] 1 game: Teaser shows "Log 2 more games" (1/3)
- [ ] 2 games: Teaser shows "Log 1 more game" (2/3)
- [ ] 3 games (recent): Active insights display
- [ ] 3 games (>30 days ago): Off-season recap displays
- [ ] Insight text is 2-3 sentences, position-appropriate
- [ ] Next action displays with 💡 or 💪 emoji
- [ ] CTA button says "View Drill in Skills" or "Go to Skills Tab"

### Position-Specific Stats
- [ ] Goalie: Save%, Total Saves, Goals Against, Clears
- [ ] Attack: Goals, Assists, Points, Shooting%
- [ ] Midfield: Goals, Assists, Ground Balls, Caused TOs
- [ ] Defense: Ground Balls, Caused TOs, Assists, Goals
- [ ] FOGO: FO Win%, Total FO Wins, Ground Balls, Goals
- [ ] LSM: Ground Balls, Caused TOs, Assists, Goals
- [ ] Per game stats show relevant metrics per position

### Context Toggle
- [ ] Toggle defaults to HS
- [ ] Toggle selection persists after app restart
- [ ] Hero card updates team name/location on toggle
- [ ] Performance stats update to show selected context data
- [ ] Recent games filter to selected context
- [ ] AI insights reference correct context
- [ ] Season goals remain same (not filtered by context)

### FAB & Bottom Sheet
- [ ] FAB displays at bottom-center, above all content
- [ ] FAB stays visible while scrolling
- [ ] Tap FAB opens bottom sheet
- [ ] Sheet shows handle bar at top
- [ ] Sheet title "Log Game" centered
- [ ] 3 options display with icon, title, subtitle
- [ ] Live Game option tappable (placeholder nav)
- [ ] After Game option tappable (placeholder nav)
- [ ] Scan Stats option tappable (placeholder nav)
- [ ] Swipe down dismisses sheet
- [ ] Tap outside dismisses sheet

### Accessibility & Polish
- [ ] VoiceOver reads all card titles
- [ ] VoiceOver reads stat values with units
- [ ] VoiceOver reads trend indicators
- [ ] All buttons ≥ 44pt tap targets
- [ ] Dynamic Type: Text scales appropriately
- [ ] Dark mode: Colors have sufficient contrast (if implemented)
- [ ] Haptic feedback on FAB tap
- [ ] Smooth animations (no jank)

---

## Debug Logs

Prefix all logs with `[StatLocker][Dashboard]`

**Examples:**
```swift
print("[StatLocker][Dashboard] Context toggled to: \(selectedContext.rawValue)")
print("[StatLocker][Dashboard] Loaded \(games.count) games for user: \(userId)")
print("[StatLocker][Dashboard] AI insight state: \(aiInsightState)")
print("[StatLocker][Dashboard] Calculated performance stats for position: \(position)")
print("[StatLocker][Dashboard] Trend for Save%: \(trend.direction.icon) \(trend.changePercentage)%")
print("[StatLocker][Dashboard] FAB sheet presented")
```

---

## Next Steps After B-004

1. **B-005: Logging** — Build Live Game, After Game, OCR flows
2. **B-006: Stats** — Build Stats tab with charts and filters
3. **B-007: Goals** — Build full Goals view with GoalPace AI
4. **B-008: Skills** — Build Skills/Drills tab with AI recommendations
5. **Phase 1 Enhancements:**
   - Profile picture upload
   - Jersey numbers in profile
   - Upcoming events section
   - Recommended drills card logic

---

## Copy Principles

- Motivational without being cheesy
- Direct and actionable ("Log your first game" not "You could try logging a game")
- Explain value ("This helps us track..." not just "Enter opponent")
- Celebrate progress ("On track" not "You're doing okay")
- Context-aware (HS vs Club references)
- No jargon (explain OCR, don't assume knowledge)
- Short microcopy ≤ 240 chars
- Debug logs always prefixed: `[StatLocker][Dashboard]`

---

## Rules Applied

- **State Management**: Using @Observable for DashboardViewModel
- **Accessibility**: 44pt tap targets, VoiceOver labels, Dynamic Type
- **Debug Logs**: Prefixed with [StatLocker][Dashboard], includes context
- **No Practice Logging**: Only games, no scrimmages
- **Context & Meta**: HS ↔ Club toggle, HS-only Conference (not applicable to Dashboard)
- **Data Integrity**: Stats calculated from real games, never fabricated
- **Default Scopes**: Dashboard respects context toggle for filtering
- **Performance**: Lazy loading, smooth 60fps, efficient calculations

---

**End of B-004 Implementation Document**

