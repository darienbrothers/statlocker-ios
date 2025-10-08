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
    var teamGender: String // "boys" | "girls"
    var gradYear: Int // 2025-2028
    var level: String // "Freshman" | "JV" | "Varsity"
    var position: String // Boys: Goalie, Attack, Midfield, Defense, FOGO, LSM | Girls: Goalie, Attack, Midfield, Defense
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

