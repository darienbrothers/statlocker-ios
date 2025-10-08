//
//  Models.swift
//  StatLocker
//
//  Core data models for athlete profiles, team info, and season goals.
//  Used in B-003 Onboarding and throughout the app.
//

import Foundation

// MARK: - Athlete Profile (D-001)

/// Complete athlete profile captured during onboarding
/// Stored at Firebase path: /users/{uid}/profile
struct AthleteProfile: Codable, Identifiable, Equatable {
    var id: String = UUID().uuidString
    var userId: String
    var firstName: String
    var lastName: String
    var email: String
    var sport: String // "lacrosse" | "basketball" | "field_hockey" | "football" | "baseball" (only lacrosse unlocked at launch)
    var teamGender: String // "boys" | "girls"
    var gradYear: Int // 2025-2028
    var level: String // "Freshman" | "JV" | "Varsity"
    var position: String // Sport-specific positions (Lacrosse: Goalie, Attack, Midfield, Defense, FOGO, LSM)
    var aiTone: String // "Hype" | "Mentor" | "Analyst" | "Captain"
    var seasonGoals: [SeasonGoal] // Array of 3 goals
    var onboardingCompleted: Bool
    var createdAt: Date
    var updatedAt: Date?
    
    /// Computed full name for display
    var fullName: String {
        "\(firstName) \(lastName)"
    }
    
    /// Computed class year display
    var classYear: String {
        "Class of \(gradYear)"
    }
    
    // MARK: - B-004 Dashboard Extensions
    
    /// Jersey numbers (Phase 1)
    var hsJerseyNumber: Int?
    var clubJerseyNumber: Int?
    
    /// Profile picture (Phase 1)
    var profilePictureURL: String?
}

// MARK: - Season Goal

/// Individual season goal with progress tracking
/// Supports both library goals and custom user-created goals
struct SeasonGoal: Codable, Identifiable, Equatable {
    var id: String = UUID().uuidString
    var title: String
    var targetValue: Double
    var currentValue: Double = 0
    var unit: String // "saves", "goals", "%", "GBs", etc.
    var metricType: String // "count", "percent", "rate", "max"
    var trackingKey: String // Maps to stat field for auto-tracking
    var isCustom: Bool = false
    var createdAt: Date = Date()
    
    /// Computed progress percentage (0.0 to 1.0)
    var progress: Double {
        guard targetValue > 0 else { return 0 }
        let progressValue = currentValue / targetValue
        return min(max(progressValue, 0), 1.0) // Clamp between 0 and 1
    }
    
    /// Progress as percentage (0-100)
    var progressPercent: Int {
        Int(progress * 100)
    }
    
    /// Status for UI display
    var status: GoalStatus {
        if progress >= 1.0 {
            return .completed
        } else if progress >= 0.7 {
            return .onTrack
        } else if progress >= 0.4 {
            return .catchUp
        } else {
            return .stretch
        }
    }
}

// MARK: - Goal Status

enum GoalStatus: String, Codable {
    case onTrack = "On Track"
    case catchUp = "Catch Up"
    case stretch = "Stretch"
    case completed = "Completed"
    
    /// Color for UI display
    var color: String {
        switch self {
        case .onTrack: return "success" // Green
        case .catchUp: return "warning" // Yellow
        case .stretch: return "primary" // Indigo
        case .completed: return "accentEmerald" // Emerald
        }
    }
}

// MARK: - Team Info (D-002)

/// Team information for both HS and Club
/// Stored at Firebase path: /users/{uid}/team
struct TeamInfo: Codable, Equatable {
    var hsTeamName: String
    var hsCity: String
    var hsState: String
    var hasClubTeam: Bool
    var clubTeamName: String?
    var clubCity: String?
    var clubState: String?
    
    /// Formatted HS team location
    var hsLocation: String {
        "\(hsCity), \(hsState)"
    }
    
    /// Formatted club team location (if exists)
    var clubLocation: String? {
        guard let city = clubCity, let state = clubState else { return nil }
        return "\(city), \(state)"
    }
}

// MARK: - Onboarding Progress (UserDefaults Persistence)

/// Temporary storage for partial onboarding progress
/// Stored in UserDefaults with key: onboarding_progress_{userId}
/// Cleared after successful onboarding completion
struct OnboardingProgress: Codable {
    var currentStep: Int
    var sport: String
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
    var lastUpdated: Date
    
    init() {
        self.currentStep = 1
        self.sport = ""
        self.teamGender = ""
        self.gradYear = 2025
        self.level = ""
        self.position = ""
        self.hsTeamName = ""
        self.hsCity = ""
        self.hsState = ""
        self.hasClubTeam = false
        self.selectedGoals = []
        self.aiTone = ""
        self.lastUpdated = Date()
    }
}

// MARK: - B-004 Dashboard Models

// MARK: - GameLog (D-003)

/// Game log entry with stats and metadata
/// Stored at Firebase path: /users/{uid}/games
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
    
    init(userId: String, date: Date, context: GameContext, opponent: String?, stats: GameStats, source: LogSource) {
        self.userId = userId
        self.date = date
        self.context = context
        self.opponent = opponent
        self.stats = stats
        self.source = source
        self.createdAt = Date()
    }
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
    
    var points: Int {
        return goals + assists
    }
}

struct QuarterStats: Codable, Equatable {
    var quarter: Int // 1-4
    var stats: GameStats
}

// MARK: - Dashboard State Models

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
        
        var color: String {
            switch self {
            case .up: return "success"
            case .down: return "error"
            case .stable: return "muted"
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
    
    var formattedChange: String {
        if direction == .stable {
            return "Same"
        } else if statName.contains("%") {
            return String(format: "%+.1f%%", changePercentage)
        } else {
            return String(format: "%+.0f from avg", changePercentage)
        }
    }
}

// MARK: - AI Insight State

enum AIInsightState: Equatable {
    case hidden
    case teaser(gamesLogged: Int)
    case active
    case offSeason
}

// MARK: - Performance Stat

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

// MARK: - GameLog Extensions

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

