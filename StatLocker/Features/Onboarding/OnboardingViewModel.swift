//
//  OnboardingViewModel.swift
//  StatLocker
//
//  View model for onboarding flow with state management, validation, and persistence.
//  Handles all 7 onboarding steps per B-003 requirements.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

// MARK: - Onboarding View Model

@Observable
class OnboardingViewModel {
    
    // MARK: - User Info (from Auth)
    
    var userId: String
    var firstName: String
    var lastName: String
    var email: String
    
    // MARK: - Step 1: Sport Selection
    
    var sport: String = "" // "lacrosse" | "basketball" | "field_hockey" | "football" | "baseball"
    
    // MARK: - Step 2: Team Gender
    
    var teamGender: String = "" // "boys" | "girls"
    
    // MARK: - Step 3: Profile Details
    
    var gradYear: Int = 2025
    var level: String = "" // "Freshman" | "JV" | "Varsity"
    
    // MARK: - Step 4: Position
    
    var position: String = ""
    
    // MARK: - Step 5: Team Info
    
    var hsTeamName: String = ""
    var hsCity: String = ""
    var hsState: String = ""
    var hasClubTeam: Bool = false
    var clubTeamName: String = ""
    var clubCity: String = ""
    var clubState: String = ""
    
    // MARK: - Step 6: Season Goals
    
    var selectedGoals: [SeasonGoal] = []
    
    // MARK: - Step 7: Tone Quiz
    
    var aiTone: String = "" // "Hype" | "Mentor" | "Analyst" | "Captain"
    
    // MARK: - State
    
    var currentStep: Int = 1
    var isLoading: Bool = false
    var errorMessage: String?
    
    // MARK: - Name Extraction
    
    /// Extracts display name for personalization
    var displayName: String {
        if !firstName.isEmpty {
            return firstName
        } else if let emailPrefix = email.split(separator: "@").first {
            return String(emailPrefix)
        } else {
            return "Athlete"
        }
    }
    
    // MARK: - Initialization
    
    init(userId: String, displayName: String?, email: String?) {
        self.userId = userId
        self.firstName = displayName?.components(separatedBy: " ").first ?? ""
        self.lastName = displayName?.components(separatedBy: " ").last ?? ""
        self.email = email ?? ""
        
        loadProgress()
        print("[StatLocker][Onboarding] Initialized for user: \(userId)")
    }
    
    /// Convenience initializer for FirebaseAuth.User
    convenience init(user: User) {
        self.init(userId: user.uid, displayName: user.displayName, email: user.email)
    }
    
    // MARK: - Validation
    
    /// Validates current step before allowing progression
    func validateCurrentStep() -> Bool {
        errorMessage = nil
        
        switch currentStep {
        case 1:
            // Step 1: Sport Selection
            if sport.isEmpty {
                errorMessage = "Please select a sport"
                print("[StatLocker][Onboarding] Validation failed: No sport selected")
                return false
            }
            
        case 2:
            // Step 2: Team Gender
            if teamGender.isEmpty {
                errorMessage = "Please select Boys or Girls"
                print("[StatLocker][Onboarding] Validation failed: No gender selected")
                return false
            }
            
        case 3:
            // Step 3: Grad Year & Level
            if level.isEmpty {
                errorMessage = "Please select your level"
                print("[StatLocker][Onboarding] Validation failed: No level selected")
                return false
            }
            
        case 4:
            // Step 4: Position
            if position.isEmpty {
                errorMessage = "Please select your position"
                print("[StatLocker][Onboarding] Validation failed: No position selected")
                return false
            }
            
        case 5:
            // Step 5: Team Info
            if hsTeamName.isEmpty {
                errorMessage = "Please enter your high school team name"
                print("[StatLocker][Onboarding] Validation failed: No HS team name")
                return false
            }
            if hsCity.isEmpty {
                errorMessage = "Please enter your city"
                print("[StatLocker][Onboarding] Validation failed: No city")
                return false
            }
            if hsState.isEmpty {
                errorMessage = "Please select your state"
                print("[StatLocker][Onboarding] Validation failed: No state")
                return false
            }
            
            // Validate club fields if club toggle is ON
            if hasClubTeam {
                if clubTeamName.isEmpty {
                    errorMessage = "Please enter your club team name"
                    print("[StatLocker][Onboarding] Validation failed: No club team name")
                    return false
                }
                if clubCity.isEmpty {
                    errorMessage = "Please enter your club city"
                    print("[StatLocker][Onboarding] Validation failed: No club city")
                    return false
                }
                if clubState.isEmpty {
                    errorMessage = "Please select your club state"
                    print("[StatLocker][Onboarding] Validation failed: No club state")
                    return false
                }
            }
            
        case 6:
            // Step 6: Season Goals
            if selectedGoals.count != 3 {
                errorMessage = "Please select exactly 3 season goals"
                print("[StatLocker][Onboarding] Validation failed: \(selectedGoals.count) goals selected, need 3")
                return false
            }
            
        case 7:
            // Step 7: AI Tone
            if aiTone.isEmpty {
                errorMessage = "Please select your AI Coach tone"
                print("[StatLocker][Onboarding] Validation failed: No tone selected")
                return false
            }
            
        case 8:
            // Step 8: Review - no validation needed
            break
            
        default:
            break
        }
        
        print("[StatLocker][Onboarding] Step \(currentStep) validated successfully")
        return true
    }
    
    // MARK: - Progress Persistence
    
    /// Save current progress to UserDefaults
    func saveProgress() {
        let progress = OnboardingProgress(
            currentStep: currentStep,
            sport: sport,
            teamGender: teamGender,
            gradYear: gradYear,
            level: level,
            position: position,
            hsTeamName: hsTeamName,
            hsCity: hsCity,
            hsState: hsState,
            hasClubTeam: hasClubTeam,
            clubTeamName: hasClubTeam ? clubTeamName : nil,
            clubCity: hasClubTeam ? clubCity : nil,
            clubState: hasClubTeam ? clubState : nil,
            selectedGoals: selectedGoals,
            aiTone: aiTone,
            lastUpdated: Date()
        )
        
        do {
            let encoded = try JSONEncoder().encode(progress)
            UserDefaults.standard.set(encoded, forKey: "onboarding_progress_\(userId)")
            print("[StatLocker][Onboarding] Progress saved: step \(currentStep)")
        } catch {
            print("[StatLocker][Onboarding] Error saving progress: \(error.localizedDescription)")
        }
    }
    
    /// Load saved progress from UserDefaults
    func loadProgress() {
        guard let data = UserDefaults.standard.data(forKey: "onboarding_progress_\(userId)") else {
            print("[StatLocker][Onboarding] No saved progress found")
            return
        }
        
        do {
            let progress = try JSONDecoder().decode(OnboardingProgress.self, from: data)
            
            // Restore state
            self.currentStep = progress.currentStep
            self.sport = progress.sport
            self.teamGender = progress.teamGender
            self.gradYear = progress.gradYear
            self.level = progress.level
            self.position = progress.position
            self.hsTeamName = progress.hsTeamName
            self.hsCity = progress.hsCity
            self.hsState = progress.hsState
            self.hasClubTeam = progress.hasClubTeam
            self.clubTeamName = progress.clubTeamName ?? ""
            self.clubCity = progress.clubCity ?? ""
            self.clubState = progress.clubState ?? ""
            self.selectedGoals = progress.selectedGoals
            self.aiTone = progress.aiTone
            
            print("[StatLocker][Onboarding] Progress loaded: resuming at step \(currentStep)")
        } catch {
            print("[StatLocker][Onboarding] Error loading progress: \(error.localizedDescription)")
        }
    }
    
    /// Clear saved progress from UserDefaults
    private func clearProgress() {
        UserDefaults.standard.removeObject(forKey: "onboarding_progress_\(userId)")
        print("[StatLocker][Onboarding] Progress cleared from UserDefaults")
    }
    
    // MARK: - Goal Management
    
    /// Toggle goal selection (max 3)
    func toggleGoal(_ goalTemplate: GoalTemplate) {
        // Check if already selected
        if let index = selectedGoals.firstIndex(where: { $0.id == goalTemplate.id }) {
            selectedGoals.remove(at: index)
            print("[StatLocker][Onboarding] Goal deselected: \(goalTemplate.title)")
        } else {
            // Only add if under 3 goals
            if selectedGoals.count < 3 {
                let goal = SeasonGoal(
                    id: goalTemplate.id,
                    title: goalTemplate.title,
                    targetValue: goalTemplate.target,
                    unit: goalTemplate.unit,
                    metricType: goalTemplate.metricType,
                    trackingKey: goalTemplate.trackingKey,
                    isCustom: false
                )
                selectedGoals.append(goal)
                print("[StatLocker][Onboarding] Goal selected: \(goalTemplate.title) (\(selectedGoals.count)/3)")
            } else {
                print("[StatLocker][Onboarding] Max 3 goals already selected")
            }
        }
    }
    
    /// Add custom goal
    func addCustomGoal(title: String, target: Double?, unit: String) {
        guard selectedGoals.count < 3 else {
            print("[StatLocker][Onboarding] Cannot add custom goal: max 3 already selected")
            return
        }
        
        let goal = SeasonGoal(
            title: title,
            targetValue: target ?? 1, // Default to 1 for qualitative goals
            unit: unit,
            metricType: target != nil ? "count" : "custom",
            trackingKey: "custom",
            isCustom: true
        )
        
        selectedGoals.append(goal)
        print("[StatLocker][Onboarding] Custom goal added: \(title) (\(selectedGoals.count)/3)")
    }
    
    /// Check if goal is currently selected
    func isGoalSelected(_ goalId: String) -> Bool {
        return selectedGoals.contains(where: { $0.id == goalId })
    }
    
    // MARK: - Positions Helper
    
    /// Get available positions based on selected gender
    func getAvailablePositions() -> [String] {
        if teamGender == "boys" {
            return ["Goalie", "Attack", "Midfield", "Defense", "FOGO", "LSM"]
        } else {
            return ["Goalie", "Attack", "Midfield", "Defense"]
        }
    }
    
    // MARK: - Firebase Integration
    
    /// Complete onboarding and save to Firebase
    func completeOnboarding() async throws {
        isLoading = true
        errorMessage = nil
        
        do {
            // Create profile
            let profile = AthleteProfile(
                userId: userId,
                firstName: firstName,
                lastName: lastName,
                email: email,
                sport: sport,
                teamGender: teamGender,
                gradYear: gradYear,
                level: level,
                position: position,
                aiTone: aiTone,
                seasonGoals: selectedGoals,
                onboardingCompleted: true,
                createdAt: Date()
            )
            
            // Create team info
            let teamInfo = TeamInfo(
                hsTeamName: hsTeamName,
                hsCity: hsCity,
                hsState: hsState,
                hasClubTeam: hasClubTeam,
                clubTeamName: hasClubTeam ? clubTeamName : nil,
                clubCity: hasClubTeam ? clubCity : nil,
                clubState: hasClubTeam ? clubState : nil
            )
            
            // Save to Firebase
            let db = Firestore.firestore()
            
            // Save profile
            let profileData = try Firestore.Encoder().encode(profile)
            try await db.collection("users").document(userId).collection("profile").document("data").setData(profileData)
            print("[StatLocker][Onboarding] Profile saved to Firebase for user: \(userId)")
            
            // Save team info
            let teamData = try Firestore.Encoder().encode(teamInfo)
            try await db.collection("users").document(userId).collection("team").document("data").setData(teamData)
            print("[StatLocker][Onboarding] Team info saved to Firebase for user: \(userId)")
            
            // Clear UserDefaults progress
            clearProgress()
            
            print("[StatLocker][Onboarding] Onboarding completed successfully for \(profile.fullName)")
            
            isLoading = false
            
        } catch {
            isLoading = false
            errorMessage = "Failed to save profile. Please try again."
            print("[StatLocker][Onboarding] Error saving to Firebase: \(error.localizedDescription)")
            throw error
        }
    }
    
    // MARK: - Step Navigation Helpers
    
    /// Log step completion with context
    func logStepCompletion() {
        switch currentStep {
        case 1:
            print("[StatLocker][Onboarding] Step 1 completed: sport=\(sport)")
        case 2:
            print("[StatLocker][Onboarding] Step 2 completed: gender=\(teamGender)")
        case 3:
            print("[StatLocker][Onboarding] Step 3 completed: gradYear=\(gradYear), level=\(level)")
        case 4:
            print("[StatLocker][Onboarding] Step 4 completed: position=\(position)")
        case 5:
            print("[StatLocker][Onboarding] Step 5 completed: hs=\(hsTeamName), hasClub=\(hasClubTeam)")
        case 6:
            let customCount = selectedGoals.filter { $0.isCustom }.count
            let goalTitles = selectedGoals.map { $0.title }.joined(separator: ", ")
            print("[StatLocker][Onboarding] Step 6 completed: goals=[\(goalTitles)], customCount=\(customCount)")
        case 7:
            print("[StatLocker][Onboarding] Step 7 completed: tone=\(aiTone)")
        case 8:
            print("[StatLocker][Onboarding] Step 8: Review complete, ready to save")
        default:
            break
        }
    }
}

// MARK: - OnboardingProgress Extension

extension OnboardingProgress {
    init(currentStep: Int,
         sport: String,
         teamGender: String,
         gradYear: Int,
         level: String,
         position: String,
         hsTeamName: String,
         hsCity: String,
         hsState: String,
         hasClubTeam: Bool,
         clubTeamName: String?,
         clubCity: String?,
         clubState: String?,
         selectedGoals: [SeasonGoal],
         aiTone: String,
         lastUpdated: Date) {
        
        self.currentStep = currentStep
        self.sport = sport
        self.teamGender = teamGender
        self.gradYear = gradYear
        self.level = level
        self.position = position
        self.hsTeamName = hsTeamName
        self.hsCity = hsCity
        self.hsState = hsState
        self.hasClubTeam = hasClubTeam
        self.clubTeamName = clubTeamName
        self.clubCity = clubCity
        self.clubState = clubState
        self.selectedGoals = selectedGoals
        self.aiTone = aiTone
        self.lastUpdated = lastUpdated
    }
}

