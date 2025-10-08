//
//  GoalsLibrary.swift
//  StatLocker
//
//  Goals library with position-specific and level-specific season goals.
//  Port from goalsLibrary.ts for B-003 onboarding.
//

import Foundation

// MARK: - Goal Template Model

struct GoalTemplate: Identifiable, Codable {
    var id: String
    var position: String
    var level: String
    var title: String
    var metricType: String // "count", "percent", "rate", "max"
    var target: Double
    var unit: String
    var trackingKey: String
}

// MARK: - Goals Library

class GoalsLibrary {
    static let shared = GoalsLibrary()
    
    private var allGoals: [GoalTemplate] = []
    
    init() {
        loadGoals()
        print("[StatLocker][GoalsLibrary] Loaded \(allGoals.count) goals")
    }
    
    func getGoals(for position: String, level: String) -> [GoalTemplate] {
        let filtered = allGoals.filter { goal in
            goal.position == position && goal.level == level
        }
        print("[StatLocker][GoalsLibrary] Found \(filtered.count) goals for \(position) \(level)")
        return filtered
    }
    
    private func loadGoals() {
        // MARK: - Attack Goals
        
        // Attack (Freshman)
        allGoals.append(contentsOf: [
            GoalTemplate(id: "atk-fr-goals-10", position: "Attack", level: "Freshman", title: "10 goals (season)", metricType: "count", target: 10, unit: "goals", trackingKey: "goals"),
            GoalTemplate(id: "atk-fr-ast-10", position: "Attack", level: "Freshman", title: "10 assists (season)", metricType: "count", target: 10, unit: "assists", trackingKey: "assists"),
            GoalTemplate(id: "atk-fr-ppg-2", position: "Attack", level: "Freshman", title: "2.0 points per game", metricType: "rate", target: 2, unit: "points", trackingKey: "points"),
            GoalTemplate(id: "atk-fr-shoot-45", position: "Attack", level: "Freshman", title: "45%+ shooting (season)", metricType: "percent", target: 0.45, unit: "%", trackingKey: "shooting_pct"),
            GoalTemplate(id: "atk-fr-tov-max2", position: "Attack", level: "Freshman", title: "≤2 turnovers per game", metricType: "max", target: 2, unit: "turnovers", trackingKey: "turnovers"),
            GoalTemplate(id: "atk-fr-gb-20", position: "Attack", level: "Freshman", title: "20 ground balls (season)", metricType: "count", target: 20, unit: "GBs", trackingKey: "ground_balls"),
            GoalTemplate(id: "atk-fr-shots-50", position: "Attack", level: "Freshman", title: "50+ shots (season)", metricType: "count", target: 50, unit: "shots", trackingKey: "shots"),
            GoalTemplate(id: "atk-fr-sog-30", position: "Attack", level: "Freshman", title: "30+ shots on goal", metricType: "count", target: 30, unit: "SOG", trackingKey: "shots_on_goal"),
            GoalTemplate(id: "atk-fr-points-15", position: "Attack", level: "Freshman", title: "15+ total points", metricType: "count", target: 15, unit: "points", trackingKey: "total_points"),
            GoalTemplate(id: "atk-fr-hat-1", position: "Attack", level: "Freshman", title: "1+ hat trick game", metricType: "count", target: 1, unit: "games", trackingKey: "hat_tricks")
        ])
        
        // Attack (JV)
        allGoals.append(contentsOf: [
            GoalTemplate(id: "atk-jv-goals-30", position: "Attack", level: "JV", title: "30 goals (season)", metricType: "count", target: 30, unit: "goals", trackingKey: "goals"),
            GoalTemplate(id: "atk-jv-ast-20", position: "Attack", level: "JV", title: "20 assists (season)", metricType: "count", target: 20, unit: "assists", trackingKey: "assists"),
            GoalTemplate(id: "atk-jv-ppg-3", position: "Attack", level: "JV", title: "3.0 points per game", metricType: "rate", target: 3, unit: "points", trackingKey: "points"),
            GoalTemplate(id: "atk-jv-shoot-50", position: "Attack", level: "JV", title: "50%+ shooting", metricType: "percent", target: 0.5, unit: "%", trackingKey: "shooting_pct"),
            GoalTemplate(id: "atk-jv-tov-1_5", position: "Attack", level: "JV", title: "≤1.5 turnovers per game", metricType: "max", target: 1.5, unit: "turnovers", trackingKey: "turnovers"),
            GoalTemplate(id: "atk-jv-gb-40", position: "Attack", level: "JV", title: "40 ground balls (season)", metricType: "count", target: 40, unit: "GBs", trackingKey: "ground_balls"),
            GoalTemplate(id: "atk-jv-shots-80", position: "Attack", level: "JV", title: "80+ shots (season)", metricType: "count", target: 80, unit: "shots", trackingKey: "shots"),
            GoalTemplate(id: "atk-jv-sog-50", position: "Attack", level: "JV", title: "50+ shots on goal", metricType: "count", target: 50, unit: "SOG", trackingKey: "shots_on_goal"),
            GoalTemplate(id: "atk-jv-points-40", position: "Attack", level: "JV", title: "40+ total points", metricType: "count", target: 40, unit: "points", trackingKey: "total_points"),
            GoalTemplate(id: "atk-jv-hat-2", position: "Attack", level: "JV", title: "2+ hat trick games", metricType: "count", target: 2, unit: "games", trackingKey: "hat_tricks")
        ])
        
        // Attack (Varsity)
        allGoals.append(contentsOf: [
            GoalTemplate(id: "atk-var-goals-50", position: "Attack", level: "Varsity", title: "50+ goals (season)", metricType: "count", target: 50, unit: "goals", trackingKey: "goals"),
            GoalTemplate(id: "atk-var-ast-40", position: "Attack", level: "Varsity", title: "40+ assists (season)", metricType: "count", target: 40, unit: "assists", trackingKey: "assists"),
            GoalTemplate(id: "atk-var-ppg-4", position: "Attack", level: "Varsity", title: "4.0+ points per game", metricType: "rate", target: 4, unit: "points", trackingKey: "points"),
            GoalTemplate(id: "atk-var-shoot-55", position: "Attack", level: "Varsity", title: "55–60%+ shooting", metricType: "percent", target: 0.55, unit: "%", trackingKey: "shooting_pct"),
            GoalTemplate(id: "atk-var-tov-1", position: "Attack", level: "Varsity", title: "≤1 turnover per game", metricType: "max", target: 1, unit: "turnovers", trackingKey: "turnovers"),
            GoalTemplate(id: "atk-var-gb-60", position: "Attack", level: "Varsity", title: "60+ ground balls (season)", metricType: "count", target: 60, unit: "GBs", trackingKey: "ground_balls"),
            GoalTemplate(id: "atk-var-shots-120", position: "Attack", level: "Varsity", title: "120+ shots (season)", metricType: "count", target: 120, unit: "shots", trackingKey: "shots"),
            GoalTemplate(id: "atk-var-sog-80", position: "Attack", level: "Varsity", title: "80+ shots on goal", metricType: "count", target: 80, unit: "SOG", trackingKey: "shots_on_goal"),
            GoalTemplate(id: "atk-var-points-70", position: "Attack", level: "Varsity", title: "70+ total points", metricType: "count", target: 70, unit: "points", trackingKey: "total_points"),
            GoalTemplate(id: "atk-var-hat-3", position: "Attack", level: "Varsity", title: "3+ hat trick games", metricType: "count", target: 3, unit: "games", trackingKey: "hat_tricks")
        ])
        
        // MARK: - Midfielder Goals
        
        // Midfielder (Freshman)
        allGoals.append(contentsOf: [
            GoalTemplate(id: "mid-fr-goals-10", position: "Midfield", level: "Freshman", title: "10 goals (season)", metricType: "count", target: 10, unit: "goals", trackingKey: "goals"),
            GoalTemplate(id: "mid-fr-ast-10", position: "Midfield", level: "Freshman", title: "10 assists (season)", metricType: "count", target: 10, unit: "assists", trackingKey: "assists"),
            GoalTemplate(id: "mid-fr-gbpg-2", position: "Midfield", level: "Freshman", title: "2+ GBs per game", metricType: "rate", target: 2, unit: "GBs", trackingKey: "ground_balls"),
            GoalTemplate(id: "mid-fr-ppg-1", position: "Midfield", level: "Freshman", title: "1.0+ points per game", metricType: "rate", target: 1, unit: "points", trackingKey: "points"),
            GoalTemplate(id: "mid-fr-tov-2", position: "Midfield", level: "Freshman", title: "≤2 turnovers per game", metricType: "max", target: 2, unit: "turnovers", trackingKey: "turnovers"),
            GoalTemplate(id: "mid-fr-clear-70", position: "Midfield", level: "Freshman", title: "70%+ clear success", metricType: "percent", target: 0.7, unit: "%", trackingKey: "clears_success"),
            GoalTemplate(id: "mid-fr-gb-30", position: "Midfield", level: "Freshman", title: "30+ ground balls (season)", metricType: "count", target: 30, unit: "GBs", trackingKey: "ground_balls"),
            GoalTemplate(id: "mid-fr-ct-8", position: "Midfield", level: "Freshman", title: "8+ caused turnovers", metricType: "count", target: 8, unit: "CTs", trackingKey: "caused_turnovers"),
            GoalTemplate(id: "mid-fr-shots-25", position: "Midfield", level: "Freshman", title: "25+ shots (season)", metricType: "count", target: 25, unit: "shots", trackingKey: "shots"),
            GoalTemplate(id: "mid-fr-fo-3", position: "Midfield", level: "Freshman", title: "3+ faceoff wins", metricType: "count", target: 3, unit: "wins", trackingKey: "faceoff_wins")
        ])
        
        // Midfielder (JV)
        allGoals.append(contentsOf: [
            GoalTemplate(id: "mid-jv-goals-20", position: "Midfield", level: "JV", title: "20 goals (season)", metricType: "count", target: 20, unit: "goals", trackingKey: "goals"),
            GoalTemplate(id: "mid-jv-ast-20", position: "Midfield", level: "JV", title: "20 assists (season)", metricType: "count", target: 20, unit: "assists", trackingKey: "assists"),
            GoalTemplate(id: "mid-jv-gbpg-3", position: "Midfield", level: "JV", title: "3+ GBs per game", metricType: "rate", target: 3, unit: "GBs", trackingKey: "ground_balls"),
            GoalTemplate(id: "mid-jv-ppg-2", position: "Midfield", level: "JV", title: "2.0+ points per game", metricType: "rate", target: 2, unit: "points", trackingKey: "points"),
            GoalTemplate(id: "mid-jv-tov-1_5", position: "Midfield", level: "JV", title: "≤1.5 turnovers per game", metricType: "max", target: 1.5, unit: "turnovers", trackingKey: "turnovers"),
            GoalTemplate(id: "mid-jv-clear-80", position: "Midfield", level: "JV", title: "80%+ clear success", metricType: "percent", target: 0.8, unit: "%", trackingKey: "clears_success"),
            GoalTemplate(id: "mid-jv-gb-50", position: "Midfield", level: "JV", title: "50+ ground balls (season)", metricType: "count", target: 50, unit: "GBs", trackingKey: "ground_balls"),
            GoalTemplate(id: "mid-jv-ct-15", position: "Midfield", level: "JV", title: "15+ caused turnovers", metricType: "count", target: 15, unit: "CTs", trackingKey: "caused_turnovers"),
            GoalTemplate(id: "mid-jv-shots-40", position: "Midfield", level: "JV", title: "40+ shots (season)", metricType: "count", target: 40, unit: "shots", trackingKey: "shots"),
            GoalTemplate(id: "mid-jv-fo-8", position: "Midfield", level: "JV", title: "8+ faceoff wins", metricType: "count", target: 8, unit: "wins", trackingKey: "faceoff_wins")
        ])
        
        // Midfielder (Varsity)
        allGoals.append(contentsOf: [
            GoalTemplate(id: "mid-var-goals-25", position: "Midfield", level: "Varsity", title: "25+ goals (season)", metricType: "count", target: 25, unit: "goals", trackingKey: "goals"),
            GoalTemplate(id: "mid-var-ast-25", position: "Midfield", level: "Varsity", title: "25+ assists (season)", metricType: "count", target: 25, unit: "assists", trackingKey: "assists"),
            GoalTemplate(id: "mid-var-gbpg-4", position: "Midfield", level: "Varsity", title: "4+ GBs per game", metricType: "rate", target: 4, unit: "GBs", trackingKey: "ground_balls"),
            GoalTemplate(id: "mid-var-ppg-3", position: "Midfield", level: "Varsity", title: "3.0+ points per game", metricType: "rate", target: 3, unit: "points", trackingKey: "points"),
            GoalTemplate(id: "mid-var-shoot-50", position: "Midfield", level: "Varsity", title: "50%+ shooting", metricType: "percent", target: 0.5, unit: "%", trackingKey: "shooting_pct"),
            GoalTemplate(id: "mid-var-clear-85", position: "Midfield", level: "Varsity", title: "85%+ clear success", metricType: "percent", target: 0.85, unit: "%", trackingKey: "clears_success"),
            GoalTemplate(id: "mid-var-gb-70", position: "Midfield", level: "Varsity", title: "70+ ground balls (season)", metricType: "count", target: 70, unit: "GBs", trackingKey: "ground_balls"),
            GoalTemplate(id: "mid-var-ct-20", position: "Midfield", level: "Varsity", title: "20+ caused turnovers", metricType: "count", target: 20, unit: "CTs", trackingKey: "caused_turnovers"),
            GoalTemplate(id: "mid-var-shots-60", position: "Midfield", level: "Varsity", title: "60+ shots (season)", metricType: "count", target: 60, unit: "shots", trackingKey: "shots"),
            GoalTemplate(id: "mid-var-fo-15", position: "Midfield", level: "Varsity", title: "15+ faceoff wins", metricType: "count", target: 15, unit: "wins", trackingKey: "faceoff_wins")
        ])
        
        // MARK: - Defense Goals
        
        // Defense (Freshman)
        allGoals.append(contentsOf: [
            GoalTemplate(id: "def-fr-gb-20", position: "Defense", level: "Freshman", title: "20 ground balls (season)", metricType: "count", target: 20, unit: "GBs", trackingKey: "ground_balls"),
            GoalTemplate(id: "def-fr-ct-10", position: "Defense", level: "Freshman", title: "10 caused turnovers (season)", metricType: "count", target: 10, unit: "CTs", trackingKey: "caused_turnovers"),
            GoalTemplate(id: "def-fr-pen-0_7", position: "Defense", level: "Freshman", title: "≤0.7 penalties per game", metricType: "max", target: 0.7, unit: "penalties", trackingKey: "penalties"),
            GoalTemplate(id: "def-fr-clear-80", position: "Defense", level: "Freshman", title: "80%+ clear success", metricType: "percent", target: 0.8, unit: "%", trackingKey: "clears_success"),
            GoalTemplate(id: "def-fr-gbpg-3", position: "Defense", level: "Freshman", title: "3+ GBs per game", metricType: "rate", target: 3, unit: "GBs", trackingKey: "ground_balls"),
            GoalTemplate(id: "def-fr-clears-15", position: "Defense", level: "Freshman", title: "15 successful clears (season)", metricType: "count", target: 15, unit: "clears", trackingKey: "clears_success")
        ])
        
        // Defense (JV)
        allGoals.append(contentsOf: [
            GoalTemplate(id: "def-jv-gb-40", position: "Defense", level: "JV", title: "40 ground balls (season)", metricType: "count", target: 40, unit: "GBs", trackingKey: "ground_balls"),
            GoalTemplate(id: "def-jv-ct-25", position: "Defense", level: "JV", title: "25 caused turnovers (season)", metricType: "count", target: 25, unit: "CTs", trackingKey: "caused_turnovers"),
            GoalTemplate(id: "def-jv-pen-0_5", position: "Defense", level: "JV", title: "≤0.5 penalties per game", metricType: "max", target: 0.5, unit: "penalties", trackingKey: "penalties"),
            GoalTemplate(id: "def-jv-clear-85", position: "Defense", level: "JV", title: "85%+ clear success", metricType: "percent", target: 0.85, unit: "%", trackingKey: "clears_success"),
            GoalTemplate(id: "def-jv-gbpg-4", position: "Defense", level: "JV", title: "4+ GBs per game", metricType: "rate", target: 4, unit: "GBs", trackingKey: "ground_balls"),
            GoalTemplate(id: "def-jv-clears-30", position: "Defense", level: "JV", title: "30 successful clears (season)", metricType: "count", target: 30, unit: "clears", trackingKey: "clears_success")
        ])
        
        // Defense (Varsity)
        allGoals.append(contentsOf: [
            GoalTemplate(id: "def-var-gb-60", position: "Defense", level: "Varsity", title: "60+ ground balls (season)", metricType: "count", target: 60, unit: "GBs", trackingKey: "ground_balls"),
            GoalTemplate(id: "def-var-ct-40", position: "Defense", level: "Varsity", title: "40+ caused turnovers (season)", metricType: "count", target: 40, unit: "CTs", trackingKey: "caused_turnovers"),
            GoalTemplate(id: "def-var-pen-0_3", position: "Defense", level: "Varsity", title: "≤0.3 penalties per game", metricType: "max", target: 0.3, unit: "penalties", trackingKey: "penalties"),
            GoalTemplate(id: "def-var-clear-90", position: "Defense", level: "Varsity", title: "90%+ clear success", metricType: "percent", target: 0.9, unit: "%", trackingKey: "clears_success"),
            GoalTemplate(id: "def-var-gbpg-5", position: "Defense", level: "Varsity", title: "5+ GBs per game", metricType: "rate", target: 5, unit: "GBs", trackingKey: "ground_balls"),
            GoalTemplate(id: "def-var-clears-50", position: "Defense", level: "Varsity", title: "50+ successful clears (season)", metricType: "count", target: 50, unit: "clears", trackingKey: "clears_success")
        ])
        
        // MARK: - Goalie Goals
        
        // Goalie (Freshman)
        allGoals.append(contentsOf: [
            GoalTemplate(id: "gk-fr-savepct-50", position: "Goalie", level: "Freshman", title: "50%+ save percentage", metricType: "percent", target: 0.5, unit: "%", trackingKey: "save_pct"),
            GoalTemplate(id: "gk-fr-savespg-8", position: "Goalie", level: "Freshman", title: "8.0 saves per game", metricType: "rate", target: 8, unit: "saves", trackingKey: "saves"),
            GoalTemplate(id: "gk-fr-gaa-11", position: "Goalie", level: "Freshman", title: "≤11.0 goals against per game", metricType: "max", target: 11, unit: "GA", trackingKey: "goals_against"),
            GoalTemplate(id: "gk-fr-clear-80", position: "Goalie", level: "Freshman", title: "80%+ clear success", metricType: "percent", target: 0.8, unit: "%", trackingKey: "clears_success"),
            GoalTemplate(id: "gk-fr-saves-100", position: "Goalie", level: "Freshman", title: "100+ saves (season)", metricType: "count", target: 100, unit: "saves", trackingKey: "saves"),
            GoalTemplate(id: "gk-fr-close-55", position: "Goalie", level: "Freshman", title: "55%+ close-range save %", metricType: "percent", target: 0.55, unit: "%", trackingKey: "save_pct_close")
        ])
        
        // Goalie (JV)
        allGoals.append(contentsOf: [
            GoalTemplate(id: "gk-jv-savepct-55", position: "Goalie", level: "JV", title: "55–58%+ save percentage", metricType: "percent", target: 0.55, unit: "%", trackingKey: "save_pct"),
            GoalTemplate(id: "gk-jv-savespg-10", position: "Goalie", level: "JV", title: "10.0+ saves per game", metricType: "rate", target: 10, unit: "saves", trackingKey: "saves"),
            GoalTemplate(id: "gk-jv-gaa-9_5", position: "Goalie", level: "JV", title: "≤9.5 goals against per game", metricType: "max", target: 9.5, unit: "GA", trackingKey: "goals_against"),
            GoalTemplate(id: "gk-jv-clear-85", position: "Goalie", level: "JV", title: "85%+ clear success", metricType: "percent", target: 0.85, unit: "%", trackingKey: "clears_success"),
            GoalTemplate(id: "gk-jv-saves-150", position: "Goalie", level: "JV", title: "150+ saves (season)", metricType: "count", target: 150, unit: "saves", trackingKey: "saves"),
            GoalTemplate(id: "gk-jv-highdanger-60", position: "Goalie", level: "JV", title: "60%+ high-danger save %", metricType: "percent", target: 0.6, unit: "%", trackingKey: "save_pct_high_danger")
        ])
        
        // Goalie (Varsity)
        allGoals.append(contentsOf: [
            GoalTemplate(id: "gk-var-savepct-60", position: "Goalie", level: "Varsity", title: "60%+ save percentage", metricType: "percent", target: 0.6, unit: "%", trackingKey: "save_pct"),
            GoalTemplate(id: "gk-var-savespg-12", position: "Goalie", level: "Varsity", title: "12.0+ saves per game", metricType: "rate", target: 12, unit: "saves", trackingKey: "saves"),
            GoalTemplate(id: "gk-var-gaa-8", position: "Goalie", level: "Varsity", title: "≤8.0 goals against per game", metricType: "max", target: 8, unit: "GA", trackingKey: "goals_against"),
            GoalTemplate(id: "gk-var-clear-90", position: "Goalie", level: "Varsity", title: "90%+ clear success", metricType: "percent", target: 0.9, unit: "%", trackingKey: "clears_success"),
            GoalTemplate(id: "gk-var-saves-200", position: "Goalie", level: "Varsity", title: "200+ saves (season)", metricType: "count", target: 200, unit: "saves", trackingKey: "saves"),
            GoalTemplate(id: "gk-var-ast-2", position: "Goalie", level: "Varsity", title: "2+ goalie assists (season)", metricType: "count", target: 2, unit: "assists", trackingKey: "assists")
        ])
        
        // MARK: - LSM Goals (Boys Only)
        
        // LSM (Freshman)
        allGoals.append(contentsOf: [
            GoalTemplate(id: "lsm-fr-gb-25", position: "LSM", level: "Freshman", title: "25 GBs (season)", metricType: "count", target: 25, unit: "GBs", trackingKey: "ground_balls"),
            GoalTemplate(id: "lsm-fr-ct-10", position: "LSM", level: "Freshman", title: "10 CTs (season)", metricType: "count", target: 10, unit: "CTs", trackingKey: "caused_turnovers"),
            GoalTemplate(id: "lsm-fr-gbpg-2", position: "LSM", level: "Freshman", title: "2+ GBs per game", metricType: "rate", target: 2, unit: "GBs", trackingKey: "ground_balls"),
            GoalTemplate(id: "lsm-fr-pen-0_7", position: "LSM", level: "Freshman", title: "≤0.7 penalties per game", metricType: "max", target: 0.7, unit: "penalties", trackingKey: "penalties"),
            GoalTemplate(id: "lsm-fr-clear-80", position: "LSM", level: "Freshman", title: "80%+ clear success", metricType: "percent", target: 0.8, unit: "%", trackingKey: "clears_success"),
            GoalTemplate(id: "lsm-fr-trans-2", position: "LSM", level: "Freshman", title: "2 transition points", metricType: "count", target: 2, unit: "points", trackingKey: "transition_points")
        ])
        
        // LSM (JV)
        allGoals.append(contentsOf: [
            GoalTemplate(id: "lsm-jv-gb-50", position: "LSM", level: "JV", title: "50 GBs (season)", metricType: "count", target: 50, unit: "GBs", trackingKey: "ground_balls"),
            GoalTemplate(id: "lsm-jv-ct-25", position: "LSM", level: "JV", title: "25 CTs (season)", metricType: "count", target: 25, unit: "CTs", trackingKey: "caused_turnovers"),
            GoalTemplate(id: "lsm-jv-gbpg-3", position: "LSM", level: "JV", title: "3+ GBs per game", metricType: "rate", target: 3, unit: "GBs", trackingKey: "ground_balls"),
            GoalTemplate(id: "lsm-jv-pen-0_5", position: "LSM", level: "JV", title: "≤0.5 penalties per game", metricType: "max", target: 0.5, unit: "penalties", trackingKey: "penalties"),
            GoalTemplate(id: "lsm-jv-clear-85", position: "LSM", level: "JV", title: "85%+ clear success", metricType: "percent", target: 0.85, unit: "%", trackingKey: "clears_success"),
            GoalTemplate(id: "lsm-jv-trans-6", position: "LSM", level: "JV", title: "6 transition points", metricType: "count", target: 6, unit: "points", trackingKey: "transition_points")
        ])
        
        // LSM (Varsity)
        allGoals.append(contentsOf: [
            GoalTemplate(id: "lsm-var-gb-80", position: "LSM", level: "Varsity", title: "80+ GBs (season)", metricType: "count", target: 80, unit: "GBs", trackingKey: "ground_balls"),
            GoalTemplate(id: "lsm-var-ct-35", position: "LSM", level: "Varsity", title: "35+ CTs (season)", metricType: "count", target: 35, unit: "CTs", trackingKey: "caused_turnovers"),
            GoalTemplate(id: "lsm-var-gbpg-4", position: "LSM", level: "Varsity", title: "4+ GBs per game", metricType: "rate", target: 4, unit: "GBs", trackingKey: "ground_balls"),
            GoalTemplate(id: "lsm-var-pen-0_3", position: "LSM", level: "Varsity", title: "≤0.3 penalties per game", metricType: "max", target: 0.3, unit: "penalties", trackingKey: "penalties"),
            GoalTemplate(id: "lsm-var-clear-90", position: "LSM", level: "Varsity", title: "90%+ clear success", metricType: "percent", target: 0.9, unit: "%", trackingKey: "clears_success"),
            GoalTemplate(id: "lsm-var-trans-10", position: "LSM", level: "Varsity", title: "10+ transition points", metricType: "count", target: 10, unit: "points", trackingKey: "transition_points")
        ])
        
        // MARK: - FOGO Goals (Boys Only)
        
        // FOGO (Freshman)
        allGoals.append(contentsOf: [
            GoalTemplate(id: "fo-fr-fo-45", position: "FOGO", level: "Freshman", title: "45%+ FO win rate", metricType: "percent", target: 0.45, unit: "%", trackingKey: "faceoff_win_pct"),
            GoalTemplate(id: "fo-fr-gb-30", position: "FOGO", level: "Freshman", title: "30 GBs (season)", metricType: "count", target: 30, unit: "GBs", trackingKey: "ground_balls"),
            GoalTemplate(id: "fo-fr-viol-1", position: "FOGO", level: "Freshman", title: "≤1.0 FO violations per game", metricType: "max", target: 1, unit: "violations", trackingKey: "faceoff_violations"),
            GoalTemplate(id: "fo-fr-gbpg-2", position: "FOGO", level: "Freshman", title: "2+ GBs per game", metricType: "rate", target: 2, unit: "GBs", trackingKey: "ground_balls"),
            GoalTemplate(id: "fo-fr-trans-5", position: "FOGO", level: "Freshman", title: "5 transition points", metricType: "count", target: 5, unit: "points", trackingKey: "transition_points"),
            GoalTemplate(id: "fo-fr-wins-50", position: "FOGO", level: "Freshman", title: "50+ FO wins (season)", metricType: "count", target: 50, unit: "wins", trackingKey: "faceoff_wins"),
            GoalTemplate(id: "fo-fr-clean-15", position: "FOGO", level: "Freshman", title: "15+ clean faceoff wins", metricType: "count", target: 15, unit: "clean wins", trackingKey: "faceoff_clean_wins"),
            GoalTemplate(id: "fo-fr-wing-10", position: "FOGO", level: "Freshman", title: "10+ wing assists", metricType: "count", target: 10, unit: "assists", trackingKey: "wing_assists"),
            GoalTemplate(id: "fo-fr-fast-20", position: "FOGO", level: "Freshman", title: "20+ fast breaks created", metricType: "count", target: 20, unit: "fast breaks", trackingKey: "fast_breaks"),
            GoalTemplate(id: "fo-fr-poss-80", position: "FOGO", level: "Freshman", title: "80+ possessions won", metricType: "count", target: 80, unit: "possessions", trackingKey: "possessions_won")
        ])
        
        // FOGO (JV)
        allGoals.append(contentsOf: [
            GoalTemplate(id: "fo-jv-fo-55", position: "FOGO", level: "JV", title: "55%+ FO win rate", metricType: "percent", target: 0.55, unit: "%", trackingKey: "faceoff_win_pct"),
            GoalTemplate(id: "fo-jv-gb-60", position: "FOGO", level: "JV", title: "60 GBs (season)", metricType: "count", target: 60, unit: "GBs", trackingKey: "ground_balls"),
            GoalTemplate(id: "fo-jv-viol-0_5", position: "FOGO", level: "JV", title: "≤0.5 FO violations per game", metricType: "max", target: 0.5, unit: "violations", trackingKey: "faceoff_violations"),
            GoalTemplate(id: "fo-jv-gbpg-3", position: "FOGO", level: "JV", title: "3+ GBs per game", metricType: "rate", target: 3, unit: "GBs", trackingKey: "ground_balls"),
            GoalTemplate(id: "fo-jv-trans-10", position: "FOGO", level: "JV", title: "10 transition points", metricType: "count", target: 10, unit: "points", trackingKey: "transition_points"),
            GoalTemplate(id: "fo-jv-wins-150", position: "FOGO", level: "JV", title: "150+ FO wins (season)", metricType: "count", target: 150, unit: "wins", trackingKey: "faceoff_wins"),
            GoalTemplate(id: "fo-jv-clean-25", position: "FOGO", level: "JV", title: "25+ clean faceoff wins", metricType: "count", target: 25, unit: "clean wins", trackingKey: "faceoff_clean_wins"),
            GoalTemplate(id: "fo-jv-wing-15", position: "FOGO", level: "JV", title: "15+ wing assists", metricType: "count", target: 15, unit: "assists", trackingKey: "wing_assists"),
            GoalTemplate(id: "fo-jv-fast-30", position: "FOGO", level: "JV", title: "30+ fast breaks created", metricType: "count", target: 30, unit: "fast breaks", trackingKey: "fast_breaks"),
            GoalTemplate(id: "fo-jv-poss-120", position: "FOGO", level: "JV", title: "120+ possessions won", metricType: "count", target: 120, unit: "possessions", trackingKey: "possessions_won")
        ])
        
        // FOGO (Varsity)
        allGoals.append(contentsOf: [
            GoalTemplate(id: "fo-var-fo-65", position: "FOGO", level: "Varsity", title: "65–70%+ FO win rate", metricType: "percent", target: 0.65, unit: "%", trackingKey: "faceoff_win_pct"),
            GoalTemplate(id: "fo-var-gb-100", position: "FOGO", level: "Varsity", title: "100+ GBs (season)", metricType: "count", target: 100, unit: "GBs", trackingKey: "ground_balls"),
            GoalTemplate(id: "fo-var-viol-0", position: "FOGO", level: "Varsity", title: "0 FO violations in 3 straight games", metricType: "max", target: 0, unit: "violations", trackingKey: "faceoff_violations"),
            GoalTemplate(id: "fo-var-gbpg-4", position: "FOGO", level: "Varsity", title: "4+ GBs per game", metricType: "rate", target: 4, unit: "GBs", trackingKey: "ground_balls"),
            GoalTemplate(id: "fo-var-trans-20", position: "FOGO", level: "Varsity", title: "20 transition points", metricType: "count", target: 20, unit: "points", trackingKey: "transition_points"),
            GoalTemplate(id: "fo-var-wins-250", position: "FOGO", level: "Varsity", title: "250+ FO wins (season)", metricType: "count", target: 250, unit: "wins", trackingKey: "faceoff_wins"),
            GoalTemplate(id: "fo-var-clean-40", position: "FOGO", level: "Varsity", title: "40+ clean faceoff wins", metricType: "count", target: 40, unit: "clean wins", trackingKey: "faceoff_clean_wins"),
            GoalTemplate(id: "fo-var-wing-25", position: "FOGO", level: "Varsity", title: "25+ wing assists", metricType: "count", target: 25, unit: "assists", trackingKey: "wing_assists"),
            GoalTemplate(id: "fo-var-fast-50", position: "FOGO", level: "Varsity", title: "50+ fast breaks created", metricType: "count", target: 50, unit: "fast breaks", trackingKey: "fast_breaks"),
            GoalTemplate(id: "fo-var-poss-200", position: "FOGO", level: "Varsity", title: "200+ possessions won", metricType: "count", target: 200, unit: "possessions", trackingKey: "possessions_won")
        ])
    }
}

