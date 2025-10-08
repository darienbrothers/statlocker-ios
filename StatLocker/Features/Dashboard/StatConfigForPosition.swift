//
//  StatConfigForPosition.swift
//  StatLocker
//
//  Position-specific stat configurations for Dashboard performance display.
//  Used in B-004 Dashboard to show relevant stats per lacrosse position.
//

import Foundation

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
    
    /// Get display name for a stat key
    func displayName(for statKey: String) -> String {
        switch statKey {
        case "savePercentage":
            return "Save %"
        case "totalSaves":
            return "Total Saves"
        case "goalsAllowed":
            return "Goals Against"
        case "clears":
            return "Clears"
        case "goals":
            return "Goals"
        case "assists":
            return "Assists"
        case "points":
            return "Points"
        case "shootingPercentage":
            return "Shooting %"
        case "groundBalls":
            return "Ground Balls"
        case "causedTurnovers":
            return "Caused TOs"
        case "faceoffPercentage":
            return "FO Win %"
        case "faceoffWins":
            return "Total FO Wins"
        case "shots":
            return "Shots"
        case "saves":
            return "Saves"
        case "shotsFaced":
            return "Shots Faced"
        default:
            return statKey.capitalized
        }
    }
    
    /// Get per-game display name for a stat key
    func perGameDisplayName(for statKey: String) -> String {
        switch statKey {
        case "saves":
            return "Saves"
        case "goalsAllowed":
            return "GA"
        case "clears":
            return "Clears"
        case "shotsFaced":
            return "Shots Faced"
        case "goals":
            return "Goals"
        case "assists":
            return "Assists"
        case "shots":
            return "Shots"
        case "groundBalls":
            return "GBs"
        case "causedTurnovers":
            return "Caused TOs"
        case "faceoffWins":
            return "FO Wins"
        default:
            return statKey.capitalized
        }
    }
}
