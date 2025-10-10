//
//  OnboardingViewModel.swift
//  StatLocker
//
//  View model for onboarding flow with state management, validation, and persistence.
//  Handles all 7 onboarding steps per B-003 requirements.
//

import Foundation
import SwiftUI
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
    
    // MARK: - Step 0: Profile Picture
    
    var profileImage: UIImage? = nil
    
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
    var clubOrganization: String = "" // e.g., "Boston Lacrosse Club"
    var clubTeamName: String = "" // e.g., "U17 Elite"
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
        
        // Load any saved progress, but ensure we start at step 0 for new users
        loadProgress()
        
        // If no saved progress was found, ensure we're at step 0
        if currentStep == 0 && sport.isEmpty {
            print("[StatLocker][Onboarding] New user - starting at step 0 (profile picture)")
        }
        
        print("[StatLocker][Onboarding] Initialized for user: \(userId) at step \(currentStep)")
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
        case 0:
            // Step 0: Profile Picture (optional - no validation needed)
            break
            
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
                if clubOrganization.isEmpty {
                    errorMessage = "Please enter your club organization"
                    print("[StatLocker][Onboarding] Validation failed: No club organization")
                    return false
                }
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
        // Convert profile image to base64 for UserDefaults persistence (use small size)
        var profileImageData: String? = nil
        if let image = profileImage {
            let resizedImage = resizeImage(image: image, maxDimension: 200)
            if let data = resizedImage.jpegData(compressionQuality: 0.3) {
                profileImageData = data.base64EncodedString()
                print("[StatLocker][Onboarding] Saved profile image to UserDefaults - size: \(data.count) bytes")
            }
        }
        
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
            clubOrganization: hasClubTeam ? clubOrganization : nil,
            clubTeamName: hasClubTeam ? clubTeamName : nil,
            clubCity: hasClubTeam ? clubCity : nil,
            clubState: hasClubTeam ? clubState : nil,
            selectedGoals: selectedGoals,
            aiTone: aiTone,
            profileImageData: profileImageData,
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
            print("[StatLocker][Onboarding] No saved progress found - will start at step 0")
            self.currentStep = 0
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
            self.clubOrganization = progress.clubOrganization ?? ""
            self.clubTeamName = progress.clubTeamName ?? ""
            self.clubCity = progress.clubCity ?? ""
            self.clubState = progress.clubState ?? ""
            self.selectedGoals = progress.selectedGoals
            self.aiTone = progress.aiTone
            
            // Restore profile image from base64 if present
            if let imageData = progress.profileImageData,
               let data = Data(base64Encoded: imageData),
               let image = UIImage(data: data) {
                self.profileImage = image
            }
            
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
            // Convert profile picture to base64 for Firestore storage (avoids needing Firebase Storage)
            var profilePictureData: String? = nil
            if let image = profileImage {
                print("[StatLocker][Onboarding] Processing profile picture for Firestore")
                
                // Resize image to reasonable dimensions (400x400 max) to reduce file size
                let resizedImage = resizeImage(image: image, maxDimension: 400)
                
                // Compress with low quality since it's just a profile picture
                if let imageData = resizedImage.jpegData(compressionQuality: 0.3) {
                    let base64String = imageData.base64EncodedString()
                    let base64Size = base64String.count
                    
                    // Firestore limit is 1,048,487 bytes per field
                    if base64Size < 900_000 {
                        profilePictureData = base64String
                        print("[StatLocker][Onboarding] ✅ Profile picture ready - size: \(imageData.count) bytes (base64: \(base64Size) bytes)")
                    } else {
                        // Try even more aggressive compression
                        print("[StatLocker][Onboarding] Image still too large, compressing more")
                        if let smallerData = resizedImage.jpegData(compressionQuality: 0.2) {
                            let smallerBase64 = smallerData.base64EncodedString()
                            if smallerBase64.count < 900_000 {
                                profilePictureData = smallerBase64
                                print("[StatLocker][Onboarding] ✅ Profile picture ready (compressed) - size: \(smallerData.count) bytes")
                            } else {
                                print("[StatLocker][Onboarding] ⚠️ Image too large even after compression, skipping")
                            }
                        }
                    }
                } else {
                    print("[StatLocker][Onboarding] Error: Could not compress image")
                }
            }
            
            // Create profile
            var profile = AthleteProfile(
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
            profile.profilePictureData = profilePictureData
            
            // Create team info
            let teamInfo = TeamInfo(
                hsTeamName: hsTeamName,
                hsCity: hsCity,
                hsState: hsState,
                hasClubTeam: hasClubTeam,
                clubOrganization: hasClubTeam ? clubOrganization : nil,
                clubTeamName: hasClubTeam ? clubTeamName : nil,
                clubCity: hasClubTeam ? clubCity : nil,
                clubState: hasClubTeam ? clubState : nil
            )
            
            // Save to Firebase
            let db = Firestore.firestore()
            
            // Save profile
            print("[StatLocker][Onboarding] Encoding profile data...")
            let profileData = try Firestore.Encoder().encode(profile)
            print("[StatLocker][Onboarding] Saving profile to Firebase for user: \(userId)")
            try await db.collection("users").document(userId).collection("profile").document("data").setData(profileData)
            print("[StatLocker][Onboarding] ✅ Profile saved to Firebase successfully")
            
            // Save team info
            print("[StatLocker][Onboarding] Encoding team data...")
            let teamData = try Firestore.Encoder().encode(teamInfo)
            print("[StatLocker][Onboarding] Saving team info to Firebase for user: \(userId)")
            try await db.collection("users").document(userId).collection("team").document("data").setData(teamData)
            print("[StatLocker][Onboarding] ✅ Team info saved to Firebase successfully")
            
            // Clear UserDefaults progress
            clearProgress()
            
            print("[StatLocker][Onboarding] Onboarding completed successfully for \(profile.fullName)")
            
            isLoading = false
            
        } catch {
            isLoading = false
            let errorDetails = "\(error.localizedDescription) - Domain: \((error as NSError).domain) - Code: \((error as NSError).code)"
            errorMessage = "Failed to save profile. Please check your internet connection and try again."
            print("[StatLocker][Onboarding] ❌ Error saving to Firebase: \(errorDetails)")
            print("[StatLocker][Onboarding] ❌ Full error: \(error)")
            throw error
        }
    }
    
    // MARK: - Image Processing Helper
    
    /// Resize image to fit within max dimension while maintaining aspect ratio
    private func resizeImage(image: UIImage, maxDimension: CGFloat) -> UIImage {
        let size = image.size
        let aspectRatio = size.width / size.height
        
        var newSize: CGSize
        if size.width > size.height {
            newSize = CGSize(width: maxDimension, height: maxDimension / aspectRatio)
        } else {
            newSize = CGSize(width: maxDimension * aspectRatio, height: maxDimension)
        }
        
        // Don't upscale if image is already smaller
        if size.width <= maxDimension && size.height <= maxDimension {
            return image
        }
        
        let renderer = UIGraphicsImageRenderer(size: newSize)
        return renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
    
    // MARK: - Step Navigation Helpers
    
    /// Log step completion with context
    func logStepCompletion() {
        switch currentStep {
        case 0:
            print("[StatLocker][Onboarding] Step 0 completed: profileImage=\(profileImage != nil ? "set" : "skipped")")
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
         clubOrganization: String?,
         clubTeamName: String?,
         clubCity: String?,
         clubState: String?,
         selectedGoals: [SeasonGoal],
         aiTone: String,
         profileImageData: String?,
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
        self.clubOrganization = clubOrganization
        self.clubTeamName = clubTeamName
        self.clubCity = clubCity
        self.clubState = clubState
        self.selectedGoals = selectedGoals
        self.aiTone = aiTone
        self.profileImageData = profileImageData
        self.lastUpdated = lastUpdated
    }
}

