//
//  AfterGameViewModel.swift
//  StatLocker
//
//  View model for After Game logging with validation.
//  Used in B-005 Logging to handle stat entry and validation for all positions.
//

import Foundation
import SwiftUI
import FirebaseFirestore

@Observable
class AfterGameViewModel {
    
    // MARK: - Dependencies
    var profile: AthleteProfile
    var gameService: GameService
    
    // MARK: - Game Meta State
    var selectedContext: GameContext = .hs
    var isConference: Bool = true // HS only
    var opponent: String = ""
    var gameDate: Date = Date()
    
    // MARK: - Goalie Stats State
    var shotsFaced: Int = 0
    var saves: Int = 0
    var goalsAllowed: Int = 0
    var clears: Int = 0
    
    // MARK: - Attack Stats State
    var goals: Int = 0
    var assists: Int = 0
    var shots: Int = 0
    var groundBalls: Int = 0
    
    // MARK: - Midfield Stats State
    var causedTurnovers: Int = 0
    
    // MARK: - FOGO Stats State
    var faceoffWins: Int = 0
    var faceoffLosses: Int = 0
    
    // MARK: - UI State
    var isSaving: Bool = false
    var showValidationWarning: Bool = false
    var validationMessage: String = ""
    var showSuccessAlert: Bool = false
    var errorMessage: String?
    
    // MARK: - Computed Properties
    
    var savePercentage: Double? {
        guard shotsFaced > 0 else { return nil }
        return Double(saves) / Double(shotsFaced)
    }
    
    var savePercentageFormatted: String {
        guard let sp = savePercentage else { return "—" }
        return String(format: "%.1f%%", sp * 100)
    }
    
    var calculatedGoalsAllowed: Int {
        return shotsFaced - saves
    }
    
    var isGoalie: Bool {
        profile.position == "Goalie"
    }
    
    var isAttack: Bool {
        profile.position == "Attack"
    }
    
    var isMidfield: Bool {
        profile.position == "Midfield"
    }
    
    var isDefense: Bool {
        profile.position == "Defense"
    }
    
    var isFOGO: Bool {
        profile.position == "FOGO"
    }
    
    var isLSM: Bool {
        profile.position == "LSM"
    }
    
    var canSave: Bool {
        if isGoalie {
            return shotsFaced > 0 || saves > 0 || clears > 0
        } else if isAttack {
            return goals > 0 || assists > 0 || shots > 0
        } else if isMidfield {
            return goals > 0 || assists > 0 || groundBalls > 0
        } else if isDefense || isLSM {
            return groundBalls > 0 || causedTurnovers > 0
        } else if isFOGO {
            return faceoffWins > 0 || faceoffLosses > 0
        }
        return false
    }
    
    // MARK: - Validation
    
    func validateStats() -> (isValid: Bool, warnings: [String]) {
        var warnings: [String] = []
        
        // Goalie-specific validation
        if isGoalie {
            // Critical: Saves cannot exceed shots
            if saves > shotsFaced && shotsFaced > 0 {
                warnings.append("Saves (\(saves)) cannot exceed shots faced (\(shotsFaced))")
            }
            
            // Warning: Goals allowed should equal shots - saves
            if goalsAllowed != calculatedGoalsAllowed && shotsFaced > 0 {
                warnings.append("Goals allowed (\(goalsAllowed)) doesn't match shots - saves (\(calculatedGoalsAllowed))")
            }
            
            // Warning: Negative values
            if shotsFaced < 0 || saves < 0 || goalsAllowed < 0 || clears < 0 {
                warnings.append("Stats cannot be negative")
            }
        }
        
        // Attack-specific validation
        if isAttack {
            // Goals cannot exceed shots
            if goals > shots && shots > 0 {
                warnings.append("Goals (\(goals)) cannot exceed shots (\(shots))")
            }
            
            // Negative values
            if goals < 0 || assists < 0 || shots < 0 || groundBalls < 0 {
                warnings.append("Stats cannot be negative")
            }
        }
        
        // Midfield validation
        if isMidfield {
            if goals > shots && shots > 0 {
                warnings.append("Goals (\(goals)) cannot exceed shots (\(shots))")
            }
            
            if goals < 0 || assists < 0 || groundBalls < 0 || causedTurnovers < 0 {
                warnings.append("Stats cannot be negative")
            }
        }
        
        // Defense/LSM validation
        if isDefense || isLSM {
            if groundBalls < 0 || causedTurnovers < 0 || assists < 0 || goals < 0 {
                warnings.append("Stats cannot be negative")
            }
        }
        
        // FOGO validation
        if isFOGO {
            if faceoffWins < 0 || faceoffLosses < 0 || groundBalls < 0 || goals < 0 {
                warnings.append("Stats cannot be negative")
            }
        }
        
        let isValid = warnings.isEmpty
        
        if !isValid {
            print("[StatLocker][Logging] Validation warnings: \(warnings.joined(separator: ", "))")
        }
        
        return (isValid, warnings)
    }
    
    // MARK: - Save Game
    
    func saveGame() async {
        print("[StatLocker][Logging] Attempting to save game for \(profile.position)")
        
        // Validate first
        let validation = validateStats()
        
        if !validation.isValid {
            // Show warning but allow save
            validationMessage = validation.warnings.joined(separator: "\n")
            showValidationWarning = true
            print("[StatLocker][Logging] Validation warning shown: \(validationMessage)")
            // Don't return - allow user to proceed after seeing warning
            return
        }
        
        await performSave()
    }
    
    func saveGameWithOverride() async {
        print("[StatLocker][Logging] User overriding validation warning")
        await performSave()
    }
    
    private func performSave() async {
        isSaving = true
        
        // Build GameStats based on position
        var gameStats = GameStats()
        
        if isGoalie {
            gameStats.shotsFaced = shotsFaced
            gameStats.saves = saves
            gameStats.goalsAllowed = goalsAllowed
            gameStats.clears = clears
        } else if isAttack {
            gameStats.goals = goals
            gameStats.assists = assists
            gameStats.shots = shots
            gameStats.groundBalls = groundBalls
        } else if isMidfield {
            gameStats.goals = goals
            gameStats.assists = assists
            gameStats.groundBalls = groundBalls
            gameStats.causedTurnovers = causedTurnovers
            gameStats.shots = shots
        } else if isDefense || isLSM {
            gameStats.groundBalls = groundBalls
            gameStats.causedTurnovers = causedTurnovers
            gameStats.assists = assists
            gameStats.goals = goals
        } else if isFOGO {
            gameStats.faceoffWins = faceoffWins
            gameStats.faceoffLosses = faceoffLosses
            gameStats.groundBalls = groundBalls
            gameStats.goals = goals
        }
        
        // Create GameLog
        var gameLog = GameLog(
            userId: profile.userId,
            date: gameDate,
            context: selectedContext,
            opponent: opponent.isEmpty ? nil : opponent,
            stats: gameStats,
            source: .after
        )
        
        // Set conference flag for HS games only
        if selectedContext == .hs {
            gameLog.isConference = isConference
        }
        
        do {
            try await gameService.saveGame(gameLog)
            print("[StatLocker][Logging] Game saved successfully: \(gameLog.id)")
            
            // Notify dashboard to refresh
            NotificationCenter.default.post(name: NSNotification.Name("GameLogSaved"), object: nil)
            print("[StatLocker][Logging] Posted GameLogSaved notification for dashboard refresh")
            
            isSaving = false
            showSuccessAlert = true
            
            // Note: Form will reset when user dismisses the success alert
            
        } catch {
            print("[StatLocker][Logging] Error saving game: \(error)")
            errorMessage = "Failed to save game. Please try again."
            isSaving = false
        }
    }
    
    // MARK: - Form Actions
    
    func resetForm() {
        print("[StatLocker][Logging] Resetting form")
        
        // Reset stats
        shotsFaced = 0
        saves = 0
        goalsAllowed = 0
        clears = 0
        goals = 0
        assists = 0
        shots = 0
        groundBalls = 0
        causedTurnovers = 0
        faceoffWins = 0
        faceoffLosses = 0
        
        // Reset meta
        opponent = ""
        gameDate = Date()
        
        // Reset UI state
        showValidationWarning = false
        validationMessage = ""
        showSuccessAlert = false
        errorMessage = nil
    }
    
    func incrementStat(_ stat: String) {
        print("[StatLocker][Logging] Incrementing \(stat)")
        
        switch stat {
        case "shotsFaced": shotsFaced += 1
        case "saves": saves += 1
        case "goalsAllowed": goalsAllowed += 1
        case "clears": clears += 1
        case "goals": goals += 1
        case "assists": assists += 1
        case "shots": shots += 1
        case "groundBalls": groundBalls += 1
        case "causedTurnovers": causedTurnovers += 1
        case "faceoffWins": faceoffWins += 1
        case "faceoffLosses": faceoffLosses += 1
        default: break
        }
    }
    
    func decrementStat(_ stat: String) {
        print("[StatLocker][Logging] Decrementing \(stat)")
        
        switch stat {
        case "shotsFaced": shotsFaced = max(0, shotsFaced - 1)
        case "saves": saves = max(0, saves - 1)
        case "goalsAllowed": goalsAllowed = max(0, goalsAllowed - 1)
        case "clears": clears = max(0, clears - 1)
        case "goals": goals = max(0, goals - 1)
        case "assists": assists = max(0, assists - 1)
        case "shots": shots = max(0, shots - 1)
        case "groundBalls": groundBalls = max(0, groundBalls - 1)
        case "causedTurnovers": causedTurnovers = max(0, causedTurnovers - 1)
        case "faceoffWins": faceoffWins = max(0, faceoffWins - 1)
        case "faceoffLosses": faceoffLosses = max(0, faceoffLosses - 1)
        default: break
        }
    }
    
    // MARK: - Initialization
    
    init(profile: AthleteProfile, gameService: GameService = GameService.shared) {
        self.profile = profile
        self.gameService = gameService
        
        // Load saved context preference
        if let savedContext = UserDefaults.standard.string(forKey: "selectedContext"),
           let context = GameContext(rawValue: savedContext) {
            self.selectedContext = context
        }
        
        print("[StatLocker][Logging] AfterGameViewModel initialized for \(profile.position)")
    }
}

