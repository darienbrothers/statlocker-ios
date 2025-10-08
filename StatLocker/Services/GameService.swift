//
//  GameService.swift
//  StatLocker
//
//  Firebase CRUD operations for GameLog entries.
//  Used in B-004 Dashboard and throughout the app.
//

import Foundation
import FirebaseFirestore

class GameService {
    static let shared = GameService()
    
    private let db = Firestore.firestore()
    
    private init() {}
    
    // MARK: - Fetch Games
    
    /// Fetch all games for a user, ordered by date (newest first)
    func fetchGames(for userId: String) async throws -> [GameLog] {
        let snapshot = try await db
            .collection("users")
            .document(userId)
            .collection("games")
            .order(by: "date", descending: true)
            .getDocuments()
        
        let games = snapshot.documents.compactMap { doc in
            try? doc.data(as: GameLog.self)
        }
        
        print("[StatLocker][GameService] Loaded \(games.count) games for user: \(userId)")
        return games
    }
    
    /// Fetch games for a specific context (HS or Club)
    func fetchGames(for userId: String, context: GameContext) async throws -> [GameLog] {
        let allGames = try await fetchGames(for: userId)
        let contextGames = allGames.filter { $0.context == context }
        
        print("[StatLocker][GameService] Loaded \(contextGames.count) \(context.rawValue) games for user: \(userId)")
        return contextGames
    }
    
    // MARK: - Save Game
    
    /// Save a new game log entry
    func saveGame(_ game: GameLog) async throws {
        let gameData = try Firestore.Encoder().encode(game)
        try await db
            .collection("users")
            .document(game.userId)
            .collection("games")
            .document(game.id)
            .setData(gameData)
        
        print("[StatLocker][GameService] Game saved: \(game.id) for user: \(game.userId)")
    }
    
    // MARK: - Update Game
    
    /// Update an existing game log entry
    func updateGame(_ game: GameLog) async throws {
        let gameData = try Firestore.Encoder().encode(game)
        try await db
            .collection("users")
            .document(game.userId)
            .collection("games")
            .document(game.id)
            .setData(gameData)
        
        print("[StatLocker][GameService] Game updated: \(game.id)")
    }
    
    // MARK: - Delete Game
    
    /// Delete a game log entry
    func deleteGame(_ gameId: String, for userId: String) async throws {
        try await db
            .collection("users")
            .document(userId)
            .collection("games")
            .document(gameId)
            .delete()
        
        print("[StatLocker][GameService] Game deleted: \(gameId)")
    }
    
    // MARK: - Analytics Helpers
    
    /// Get total games logged for a user
    func getTotalGames(for userId: String) async throws -> Int {
        let games = try await fetchGames(for: userId)
        return games.count
    }
    
    /// Get total games for a specific context
    func getTotalGames(for userId: String, context: GameContext) async throws -> Int {
        let games = try await fetchGames(for: userId, context: context)
        return games.count
    }
    
    /// Get games logged in the last N days
    func getRecentGames(for userId: String, days: Int) async throws -> [GameLog] {
        let cutoffDate = Calendar.current.date(byAdding: .day, value: -days, to: Date()) ?? Date()
        let allGames = try await fetchGames(for: userId)
        return allGames.filter { $0.date >= cutoffDate }
    }
    
    // MARK: - Development Helpers
    
    /// Create sample games for testing (development only)
    func createSampleGames(for userId: String, context: GameContext) async throws {
        let sampleGames = [
            GameLog(
                userId: userId,
                date: Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date(),
                context: context,
                opponent: "Warriors",
                stats: GameStats(shotsFaced: 16, saves: 12, goalsAllowed: 4, clears: 8),
                source: .after
            ),
            GameLog(
                userId: userId,
                date: Calendar.current.date(byAdding: .day, value: -14, to: Date()) ?? Date(),
                context: context,
                opponent: "Eagles",
                stats: GameStats(shotsFaced: 20, saves: 14, goalsAllowed: 6, clears: 10),
                source: .after
            ),
            GameLog(
                userId: userId,
                date: Calendar.current.date(byAdding: .day, value: -21, to: Date()) ?? Date(),
                context: context,
                opponent: "Lions",
                stats: GameStats(shotsFaced: 18, saves: 13, goalsAllowed: 5, clears: 9),
                source: .live
            )
        ]
        
        for game in sampleGames {
            try await saveGame(game)
        }
        
        print("[StatLocker][GameService] Created \(sampleGames.count) sample games for \(context.rawValue)")
    }
}
