//
//  ProfileService.swift
//  StatLocker
//
//  Firebase service for athlete profile and team info operations.
//  Used throughout the app to fetch and update user profile data.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class ProfileService {
    static let shared = ProfileService()
    
    private let db = Firestore.firestore()
    
    private init() {}
    
    // MARK: - Fetch Profile
    
    /// Fetch athlete profile for authenticated user
    func fetchProfile(for userId: String) async throws -> AthleteProfile {
        let profileDoc = try await db.collection("users")
            .document(userId)
            .collection("profile")
            .document("data")
            .getDocument()
        
        guard profileDoc.exists else {
            throw ProfileError.profileNotFound
        }
        
        let profile = try profileDoc.data(as: AthleteProfile.self)
        print("[StatLocker][ProfileService] Loaded profile for: \(profile.fullName)")
        return profile
    }
    
    // MARK: - Fetch Team Info
    
    /// Fetch team info for authenticated user
    func fetchTeamInfo(for userId: String) async throws -> TeamInfo {
        let teamDoc = try await db.collection("users")
            .document(userId)
            .collection("team")
            .document("data")
            .getDocument()
        
        guard teamDoc.exists else {
            throw ProfileError.teamInfoNotFound
        }
        
        let teamInfo = try teamDoc.data(as: TeamInfo.self)
        print("[StatLocker][ProfileService] Loaded team info for: \(teamInfo.hsTeamName)")
        return teamInfo
    }
    
    // MARK: - Save Profile
    
    /// Save athlete profile
    func saveProfile(_ profile: AthleteProfile) async throws {
        let profileData = try Firestore.Encoder().encode(profile)
        try await db.collection("users")
            .document(profile.userId)
            .collection("profile")
            .document("data")
            .setData(profileData)
        
        print("[StatLocker][ProfileService] Profile saved for: \(profile.fullName)")
    }
    
    // MARK: - Save Team Info
    
    /// Save team info
    func saveTeamInfo(_ teamInfo: TeamInfo, for userId: String) async throws {
        let teamData = try Firestore.Encoder().encode(teamInfo)
        try await db.collection("users")
            .document(userId)
            .collection("team")
            .document("data")
            .setData(teamData)
        
        print("[StatLocker][ProfileService] Team info saved for user: \(userId)")
    }
    
    // MARK: - Combined Fetch
    
    /// Fetch both profile and team info
    func fetchProfileAndTeamInfo(for userId: String) async throws -> (AthleteProfile, TeamInfo) {
        async let profile = fetchProfile(for: userId)
        async let teamInfo = fetchTeamInfo(for: userId)
        
        return try await (profile, teamInfo)
    }
}

// MARK: - Profile Errors

enum ProfileError: Error, LocalizedError {
    case profileNotFound
    case teamInfoNotFound
    case saveFailed
    
    var errorDescription: String? {
        switch self {
        case .profileNotFound:
            return "Athlete profile not found"
        case .teamInfoNotFound:
            return "Team information not found"
        case .saveFailed:
            return "Failed to save profile data"
        }
    }
}
