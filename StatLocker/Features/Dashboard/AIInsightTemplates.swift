//
//  AIInsightTemplates.swift
//  StatLocker
//
//  Rule-based AI insight templates for Dashboard feedback.
//  Used in B-004 Dashboard to provide actionable feedback without OpenAI.
//

import Foundation

struct AIInsightTemplates {
    
    // MARK: - GOALIE TEMPLATES
    
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
    
    // MARK: - ATTACK TEMPLATES
    
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
    
    // MARK: - MIDFIELD TEMPLATES
    
    static func midfieldTwoWay(goals: Int, gbs: Int) -> String {
        "Balanced game: \(goals) goals + \(gbs) GBs. Two-way middies win championships."
    }
    
    static func midfieldTransition(gbs: Int, causedTOs: Int) -> String {
        "\(gbs) ground balls + \(causedTOs) caused turnovers. You create transition chances."
    }
    
    // MARK: - DEFENSE TEMPLATES
    
    static func defensePressure(causedTOs: Int, gbs: Int) -> String {
        "\(causedTOs) caused TOs shows active hands. Your pressure forces mistakes."
    }
    
    static func defenseGroundControl(gbs: Int, perGame: Double) -> String {
        "\(gbs) ground balls (\(String(format: "%.1f", perGame))/game). You control possessions."
    }
    
    // MARK: - FOGO TEMPLATES
    
    static func fogoWinRate(winPct: Double, wins: Int) -> String {
        "\(Int(winPct * 100))% faceoff rate with \(wins) wins. You set the tempo—stay sharp on the clamp."
    }
    
    static func fogoConsistency(winPct: Double, games: Int) -> String {
        "Held \(Int(winPct * 100))% across \(games) games. Elite FOGOs stay consistent."
    }
    
    // MARK: - LSM TEMPLATES
    
    static func lsmTransition(gbs: Int, causedTOs: Int) -> String {
        "\(gbs) ground balls + \(causedTOs) caused turnovers. You control the transition game."
    }
    
    static func lsmVersatility(goals: Int, assists: Int) -> String {
        "\(goals) goals + \(assists) assists. Your two-way game opens up the offense."
    }
    
    // MARK: - NEXT ACTION TEMPLATES
    
    static func nextActionDrill(weakness: String, drillName: String) -> String {
        "Next: Work on \(weakness) — try \(drillName)"
    }
    
    static func nextActionMaintain(strength: String) -> String {
        "Next: Keep building on \(strength) — stay locked in"
    }
    
    // MARK: - OFF-SEASON RECAP
    
    static func seasonRecap(context: GameContext, savePercentage: Double?, games: Int) -> String {
        let contextName = context == .hs ? "HS" : "Club"
        if let sp = savePercentage {
            return "Your \(contextName) season: \(Int(sp * 100))% save rate across \(games) games."
        } else {
            return "Your \(contextName) season: \(games) games logged. Solid work—review your trends in Stats."
        }
    }
    
    static func seasonRecapGeneral(context: GameContext, games: Int, position: String) -> String {
        let contextName = context == .hs ? "HS" : "Club"
        return "Your \(contextName) season: \(games) games logged as \(position). Review your progress in Stats."
    }
    
    // MARK: - FALLBACK TEMPLATES
    
    static func fallbackMessage(position: String) -> String {
        switch position {
        case "Goalie":
            return "Keep grinding between the pipes. Every save builds your confidence."
        case "Attack":
            return "Stay aggressive in the offensive zone. Your shot creates opportunities."
        case "Midfield":
            return "Two-way players win games. Keep working both ends of the field."
        case "Defense":
            return "Defense wins championships. Your stops create offensive chances."
        case "FOGO":
            return "Faceoffs set the tempo. Stay sharp on the clamp and get to your spots."
        case "LSM":
            return "Long sticks control the game. Keep disrupting and creating transition."
        default:
            return "Keep grinding—every game makes you better."
        }
    }
}
