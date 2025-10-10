//
//  DashboardViewModel.swift
//  StatLocker
//
//  View model for Dashboard state management and data calculations.
//  Used in B-004 Dashboard to handle context switching, stats, and AI insights.
//

import Foundation
import Observation
import SwiftUI

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
            print("[StatLocker][Dashboard] Context toggled to: \(selectedContext.rawValue)")
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
                name: config.displayName(for: statKey),
                value: currentValue,
                trend: trend
            )
        }
    }
    
    func calculateCurrentValue(for statKey: String) -> Double {
        guard !contextGames.isEmpty else { return 0 }
        
        switch statKey {
        case "savePercentage":
            let totalSaves = contextGames.reduce(0) { $0 + $1.stats.saves }
            let totalShots = contextGames.reduce(0) { $0 + $1.stats.shotsFaced }
            return totalShots > 0 ? Double(totalSaves) / Double(totalShots) : 0
            
        case "totalSaves":
            return Double(contextGames.reduce(0) { $0 + $1.stats.saves })
            
        case "goalsAllowed":
            return Double(contextGames.reduce(0) { $0 + $1.stats.goalsAllowed })
            
        case "clears":
            return Double(contextGames.reduce(0) { $0 + $1.stats.clears })
            
        case "goals":
            return Double(contextGames.reduce(0) { $0 + $1.stats.goals })
            
        case "assists":
            return Double(contextGames.reduce(0) { $0 + $1.stats.assists })
            
        case "points":
            return Double(contextGames.reduce(0) { $0 + $1.stats.points })
            
        case "shootingPercentage":
            let totalGoals = contextGames.reduce(0) { $0 + $1.stats.goals }
            let totalShots = contextGames.reduce(0) { $0 + $1.stats.shots }
            return totalShots > 0 ? Double(totalGoals) / Double(totalShots) : 0
            
        case "groundBalls":
            return Double(contextGames.reduce(0) { $0 + $1.stats.groundBalls })
            
        case "causedTurnovers":
            return Double(contextGames.reduce(0) { $0 + $1.stats.causedTurnovers })
            
        case "faceoffPercentage":
            let totalWins = contextGames.reduce(0) { $0 + $1.stats.faceoffWins }
            let totalLosses = contextGames.reduce(0) { $0 + $1.stats.faceoffLosses }
            let total = totalWins + totalLosses
            return total > 0 ? Double(totalWins) / Double(total) : 0
            
        case "faceoffWins":
            return Double(contextGames.reduce(0) { $0 + $1.stats.faceoffWins })
            
        case "shots":
            return Double(contextGames.reduce(0) { $0 + $1.stats.shots })
            
        case "saves":
            return Double(contextGames.reduce(0) { $0 + $1.stats.saves })
            
        case "shotsFaced":
            return Double(contextGames.reduce(0) { $0 + $1.stats.shotsFaced })
            
        default:
            return 0
        }
    }
    
    func calculateTrend(for statKey: String) -> PerformanceTrend? {
        guard contextGames.count >= 6 else {
            return nil // Need at least 6 games to calculate trends
        }
        
        let recentGames = Array(contextGames.prefix(3))
        let previousGames = Array(contextGames.dropFirst(3).prefix(3))
        
        let currentAvg = calculateAverage(for: statKey, in: recentGames)
        let previousAvg = calculateAverage(for: statKey, in: previousGames)
        
        guard previousAvg > 0 else { return nil }
        
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
        guard !games.isEmpty else { return 0 }
        
        switch statKey {
        case "savePercentage":
            let totalSaves = games.reduce(0) { $0 + $1.stats.saves }
            let totalShots = games.reduce(0) { $0 + $1.stats.shotsFaced }
            return totalShots > 0 ? Double(totalSaves) / Double(totalShots) : 0
            
        case "shootingPercentage":
            let totalGoals = games.reduce(0) { $0 + $1.stats.goals }
            let totalShots = games.reduce(0) { $0 + $1.stats.shots }
            return totalShots > 0 ? Double(totalGoals) / Double(totalShots) : 0
            
        case "faceoffPercentage":
            let totalWins = games.reduce(0) { $0 + $1.stats.faceoffWins }
            let totalLosses = games.reduce(0) { $0 + $1.stats.faceoffLosses }
            let total = totalWins + totalLosses
            return total > 0 ? Double(totalWins) / Double(total) : 0
            
        default:
            // For count stats, return total divided by number of games
            let total = games.reduce(0) { sum, game in
                switch statKey {
                case "totalSaves", "saves": return sum + game.stats.saves
                case "goalsAllowed": return sum + game.stats.goalsAllowed
                case "clears": return sum + game.stats.clears
                case "goals": return sum + game.stats.goals
                case "assists": return sum + game.stats.assists
                case "points": return sum + game.stats.points
                case "groundBalls": return sum + game.stats.groundBalls
                case "causedTurnovers": return sum + game.stats.causedTurnovers
                case "faceoffWins": return sum + game.stats.faceoffWins
                case "shots": return sum + game.stats.shots
                case "shotsFaced": return sum + game.stats.shotsFaced
                default: return sum
                }
            }
            return Double(total) / Double(games.count)
        }
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
            return AIInsightTemplates.fallbackMessage(position: profile.position)
        }
    }
    
    func generateGoalieInsight() -> String {
        let savePercentage = calculateCurrentValue(for: "savePercentage")
        let games = totalGamesLogged
        
        // Check for quarter strength (simplified - would need quarter data)
        if savePercentage > 0.7 {
            return AIInsightTemplates.goalieConsistency(savePercentage: savePercentage, games: games)
        } else {
            return AIInsightTemplates.goalieLowShotWeakness(lowShotSP: savePercentage * 0.8, overallSP: savePercentage)
        }
    }
    
    func generateAttackInsight() -> String {
        let goals = Int(calculateCurrentValue(for: "goals"))
        let assists = Int(calculateCurrentValue(for: "assists"))
        let shootingPct = calculateCurrentValue(for: "shootingPercentage")
        
        if shootingPct > 0.5 {
            return AIInsightTemplates.attackShotSelection(shootingPct: shootingPct)
        } else {
            return AIInsightTemplates.attackPlaymaking(assists: assists, goals: goals)
        }
    }
    
    func generateMidfieldInsight() -> String {
        let goals = Int(calculateCurrentValue(for: "goals"))
        let gbs = Int(calculateCurrentValue(for: "groundBalls"))
        
        return AIInsightTemplates.midfieldTwoWay(goals: goals, gbs: gbs)
    }
    
    func generateDefenseInsight() -> String {
        let causedTOs = Int(calculateCurrentValue(for: "causedTurnovers"))
        let gbs = Int(calculateCurrentValue(for: "groundBalls"))
        
        return AIInsightTemplates.defensePressure(causedTOs: causedTOs, gbs: gbs)
    }
    
    func generateFOGOInsight() -> String {
        let winPct = calculateCurrentValue(for: "faceoffPercentage")
        let wins = Int(calculateCurrentValue(for: "faceoffWins"))
        
        return AIInsightTemplates.fogoWinRate(winPct: winPct, wins: wins)
    }
    
    func generateLSMInsight() -> String {
        let gbs = Int(calculateCurrentValue(for: "groundBalls"))
        let causedTOs = Int(calculateCurrentValue(for: "causedTurnovers"))
        
        return AIInsightTemplates.lsmTransition(gbs: gbs, causedTOs: causedTOs)
    }
    
    func generateNextAction() -> String {
        guard totalGamesLogged >= 3 else { return "" }
        
        switch profile.position {
        case "Goalie":
            return AIInsightTemplates.nextActionDrill(weakness: "low shots", drillName: "Bounce Shot Drill")
        case "Attack":
            return AIInsightTemplates.nextActionDrill(weakness: "shot selection", drillName: "High-Percentage Shot Drill")
        case "Midfield":
            return AIInsightTemplates.nextActionMaintain(strength: "two-way play")
        case "Defense":
            return AIInsightTemplates.nextActionMaintain(strength: "pressure defense")
        case "FOGO":
            return AIInsightTemplates.nextActionMaintain(strength: "faceoff consistency")
        case "LSM":
            return AIInsightTemplates.nextActionMaintain(strength: "transition game")
        default:
            return AIInsightTemplates.nextActionMaintain(strength: "your game")
        }
    }
    
    // MARK: - Goal Progress
    
    func updateGoalProgress() {
        print("[StatLocker][Dashboard] Updating goal progress for \(profile.seasonGoals.count) goals")
        
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
            print("[StatLocker][Dashboard] Loaded \(games.count) games for user: \(profile.userId)")
            isLoading = false
        } catch {
            errorMessage = "Failed to load games"
            print("[StatLocker][Dashboard] Error loading games: \(error)")
            isLoading = false
        }
    }
    
    /// Refresh games and update all dashboard data
    func refresh() async {
        print("[StatLocker][Dashboard] Refreshing dashboard data...")
        await loadGames()
    }
    
    // MARK: - Initialization
    
    init(profile: AthleteProfile, teamInfo: TeamInfo, gameService: GameService = GameService.shared) {
        self.profile = profile
        self.teamInfo = teamInfo
        self.gameService = gameService
        
        // Load saved context
        if let savedContext = UserDefaults.standard.string(forKey: "selectedContext"),
           let context = GameContext(rawValue: savedContext) {
            self.selectedContext = context
        }
        
        print("[StatLocker][Dashboard] DashboardViewModel initialized for \(profile.fullName)")
        
        Task {
            await loadGames()
        }
    }
}
