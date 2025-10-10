//
//  DashboardView.swift
//  StatLocker
//
//  Main Dashboard (Home/Locker) view with hero card, stats, goals, and FAB.
//  Used in B-004 Dashboard to display athlete overview and quick game logging.
//

import SwiftUI
import Foundation

struct DashboardView: View {
    @State private var viewModel: DashboardViewModel
    
    init(profile: AthleteProfile, teamInfo: TeamInfo, gameService: GameService = GameService.shared) {
        _viewModel = State(wrappedValue: DashboardViewModel(
            profile: profile,
            teamInfo: teamInfo,
            gameService: gameService
        ))
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: Theme.Spacing.lg) {
                // Hero Card
                HeroCard(
                    profile: viewModel.profile,
                    teamInfo: viewModel.teamInfo,
                    selectedContext: $viewModel.selectedContext
                )
                
                // Empty State OR Active Content
                if viewModel.totalGamesLogged == 0 {
                    emptyStateView
                } else {
                    activeStateView
                }
            }
            .padding(Theme.Spacing.lg)
            .padding(.bottom, 100) // Space for tab bar + FAB
        }
        .refreshable {
            print("[StatLocker][Dashboard] Manual refresh triggered")
            await viewModel.refresh()
        }
        .background(Theme.Colors.backgroundPrimary)
        .navigationBarTitleDisplayMode(.inline)
        // Allow system preference to control theme
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("GameLogSaved"))) { _ in
            print("[StatLocker][Dashboard] Received game saved notification, refreshing...")
            Task {
                await viewModel.refresh()
            }
        }
        .onAppear {
            // Refresh when view appears (in case we came back from another tab)
            Task {
                await viewModel.refresh()
            }
        }
    }
    
    var emptyStateView: some View {
        VStack(spacing: Theme.Spacing.lg) {
            // Empty Locker CTA
            VStack(spacing: Theme.Spacing.lg) {
                Image(systemName: "lock.shield.fill")
                    .font(.system(size: 56))
                    .foregroundStyle(Theme.Colors.primary.opacity(0.6))
                
                VStack(spacing: Theme.Spacing.sm) {
                    Text("Your Locker is Empty")
                        .font(Theme.Typography.headline(24))
                        .fontWeight(.bold)
                        .foregroundStyle(Theme.Colors.textPrimary)
                    
                    Text("Every great season starts with one game. Let's build your story.")
                        .font(Theme.Typography.body(16))
                        .foregroundStyle(Theme.Colors.textSecondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, Theme.Spacing.lg)
                }
                
                Button(action: {
                    // Open FAB sheet
                    print("[StatLocker][Dashboard] Log Your First Game button tapped")
                }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 18))
                        
                        Text("Log Your First Game")
                            .font(Theme.Typography.body(16))
                            .fontWeight(.semibold)
                    }
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 54)
                    .background(Theme.Gradients.primaryPurple)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .accessibilityLabel("Log your first game")
            }
            .padding(Theme.Spacing.xl)
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(Theme.Colors.backgroundSecondary)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(Theme.Colors.divider, lineWidth: 1)
            )
            
            // Goals at 0%
            SeasonGoalsCard(goals: viewModel.profile.seasonGoals)
            
            // Empty Performance Stats
            PerformanceStatsCard(
                stats: [],
                perGameStats: [:],
                context: viewModel.selectedContext
            )
            
            // Empty Recent Games
            RecentGamesCard(games: []) {
                // Navigate to Stats tab
                print("[StatLocker][Dashboard] See All games tapped")
            }
        }
    }
    
    var activeStateView: some View {
        VStack(spacing: Theme.Spacing.lg) {
            // Season Goals
            SeasonGoalsCard(goals: viewModel.profile.seasonGoals)
            
            // Performance Stats
            PerformanceStatsCard(
                stats: viewModel.calculatePerformanceStats(),
                perGameStats: calculatePerGameStats(),
                context: viewModel.selectedContext
            )
            
            // AI Insights
            AIInsightCard(
                state: viewModel.aiInsightState,
                insight: viewModel.generateAIInsight(),
                nextAction: viewModel.generateNextAction()
            ) {
                // Navigate to Skills tab
                print("[StatLocker][Dashboard] AI insight CTA tapped")
            }
            
            // Recent Games
            RecentGamesCard(games: viewModel.recentGames) {
                // Navigate to Stats tab
                print("[StatLocker][Dashboard] See All games tapped")
            }
        }
    }
    
    // MARK: - Helper Functions
    
    func calculatePerGameStats() -> [String: Double] {
        guard !viewModel.contextGames.isEmpty else { return [:] }
        
        let config = StatConfigForPosition(position: viewModel.profile.position)
        var perGameStats: [String: Double] = [:]
        
        for statKey in config.perGameStats {
            let total = viewModel.contextGames.reduce(0) { sum, game in
                switch statKey {
                case "saves": return sum + game.stats.saves
                case "goalsAllowed": return sum + game.stats.goalsAllowed
                case "clears": return sum + game.stats.clears
                case "shotsFaced": return sum + game.stats.shotsFaced
                case "goals": return sum + game.stats.goals
                case "assists": return sum + game.stats.assists
                case "shots": return sum + game.stats.shots
                case "groundBalls": return sum + game.stats.groundBalls
                case "causedTurnovers": return sum + game.stats.causedTurnovers
                case "faceoffWins": return sum + game.stats.faceoffWins
                default: return sum
                }
            }
            let average = Double(total) / Double(viewModel.contextGames.count)
            perGameStats[config.perGameDisplayName(for: statKey)] = average
        }
        
        return perGameStats
    }
}

#Preview {
    let sampleProfile = AthleteProfile(
        userId: "123",
        firstName: "Jordan",
        lastName: "Smith",
        email: "jordan@example.com",
        sport: "lacrosse",
        teamGender: "boys",
        gradYear: 2026,
        level: "Varsity",
        position: "Goalie",
        aiTone: "Mentor",
        seasonGoals: [
            SeasonGoal(title: "60%+ save percentage", targetValue: 0.6, currentValue: 0.23, unit: "%", metricType: "percent", trackingKey: "save_pct"),
            SeasonGoal(title: "200+ saves", targetValue: 200, currentValue: 45, unit: "saves", metricType: "count", trackingKey: "saves"),
            SeasonGoal(title: "12 saves/game", targetValue: 12, currentValue: 8, unit: "saves/game", metricType: "rate", trackingKey: "saves_per_game")
        ],
        onboardingCompleted: true,
        createdAt: Date()
    )
    
    let sampleTeam = TeamInfo(
        hsTeamName: "Westlake Warriors Lacrosse",
        hsCity: "Austin",
        hsState: "TX",
        hasClubTeam: true,
        clubTeamName: "Austin Elite LC",
        clubCity: "Austin",
        clubState: "TX"
    )
    
    DashboardView(profile: sampleProfile, teamInfo: sampleTeam)
}