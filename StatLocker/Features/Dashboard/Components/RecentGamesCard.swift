//
//  RecentGamesCard.swift
//  StatLocker
//
//  Recent games card component showing 2 most recent games with tap-to-view summaries.
//  Used in B-004 Dashboard to display game history preview with "See All" navigation.
//

import SwiftUI

struct RecentGamesCard: View {
    let games: [GameLog]
    var onSeeAll: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.lg) {
            // Header
            HStack(spacing: Theme.Spacing.sm) {
                Image(systemName: "gamecontroller.fill")
                    .font(.system(size: 16))
                    .foregroundStyle(Theme.Colors.primary)
                
                Text("Recent Games")
                    .font(Theme.Typography.title(18))
                    .fontWeight(.semibold)
                    .foregroundStyle(Theme.Colors.textPrimary)
                
                Spacer()
                
                Button {
                    onSeeAll()
                    print("[StatLocker][Dashboard] See All games tapped")
                } label: {
                    Text("See All")
                        .font(Theme.Typography.body(14))
                        .fontWeight(.medium)
                        .foregroundStyle(Theme.Colors.primary)
                }
                .accessibilityLabel("View all games in Stats tab")
            }
            
            // Games list or empty state
            if games.isEmpty {
                VStack(spacing: Theme.Spacing.md) {
                    Image(systemName: "gamecontroller")
                        .font(.system(size: 40))
                        .foregroundStyle(Theme.Colors.textTertiary)
                    
                    Text("Your game history will appear here")
                        .font(Theme.Typography.body(15))
                        .foregroundStyle(Theme.Colors.textSecondary)
                    
                    Text("Log your first game to get started")
                        .font(Theme.Typography.caption(13))
                        .foregroundStyle(Theme.Colors.textTertiary)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, Theme.Spacing.xl)
            } else {
                VStack(spacing: Theme.Spacing.md) {
                    ForEach(games.prefix(2)) { game in
                        GameCard(game: game)
                    }
                }
            }
        }
        .padding(Theme.Spacing.lg)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Theme.Colors.backgroundSecondary)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Theme.Colors.divider, lineWidth: 1)
        )
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Recent games section")
    }
}

struct GameCard: View {
    let game: GameLog
    @State private var showDetail = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
            // Game header with opponent and result
            HStack(spacing: Theme.Spacing.sm) {
                Text("vs \(game.opponent ?? "Unknown")")
                    .font(Theme.Typography.body(16))
                    .fontWeight(.semibold)
                    .foregroundStyle(Theme.Colors.textPrimary)
                
                Spacer()
                
                // Win/Loss indicator
                Text(game.result)
                    .font(Theme.Typography.body(14))
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding(.horizontal, Theme.Spacing.sm)
                    .padding(.vertical, 4)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(game.isWin ? Theme.Colors.accentEmerald : Theme.Colors.error)
                    )
            }
            
            // Game details
            Text(game.formattedDate + " • " + game.contextLabel)
                .font(Theme.Typography.caption(13))
                .foregroundStyle(Theme.Colors.textTertiary)
            
            // Key stats
            Text(game.keyStats)
                .font(Theme.Typography.body(14))
                .foregroundStyle(Theme.Colors.textSecondary)
            
            // AI summary CTA
            HStack(spacing: Theme.Spacing.xs) {
                Image(systemName: "sparkles")
                    .font(.system(size: 12))
                    .foregroundStyle(Theme.Colors.primary)
                
                Text("Tap to see AI summary")
                    .font(Theme.Typography.caption(12))
                    .foregroundStyle(Theme.Colors.primary)
            }
        }
        .padding(Theme.Spacing.md)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Theme.Colors.backgroundTertiary)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Theme.Colors.divider.opacity(0.5), lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .onTapGesture {
            showDetail = true
            print("[StatLocker][Dashboard] Game card tapped: \(game.id)")
        }
        .sheet(isPresented: $showDetail) {
            GameDetailView(game: game)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Game vs \(game.opponent ?? "Unknown") on \(game.formattedDate)")
    }
}

struct GameDetailView: View {
    let game: GameLog
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: Theme.Spacing.md) {
                // Game Header
                VStack(spacing: Theme.Spacing.sm) {
                    Text("vs \(game.opponent ?? "Unknown")")
                        .font(Theme.Typography.headline(24))
                        .foregroundStyle(Theme.Colors.textPrimary)
                    
                    Text(game.formattedDate + " • " + game.contextLabel)
                        .font(Theme.Typography.body(16))
                        .foregroundStyle(Theme.Colors.textSecondary)
                    
                    Text(game.result)
                        .font(Theme.Typography.title(18))
                        .foregroundStyle(game.isWin ? Theme.Colors.success : Theme.Colors.error)
                }
                .padding(Theme.Spacing.lg)
                .background(Theme.Colors.cardSurface)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                
                // Stats
                VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                    Text("Game Stats")
                        .font(Theme.Typography.title(18))
                        .foregroundStyle(Theme.Colors.textPrimary)
                    
                    // TODO: Display position-specific stats
                    Text(game.keyStats)
                        .font(Theme.Typography.body(16))
                        .foregroundStyle(Theme.Colors.textSecondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(Theme.Spacing.md)
                .background(Theme.Colors.cardSurface)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                
                // AI Summary
                if let summary = game.aiSummary {
                    VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                        Text("AI Summary")
                            .font(Theme.Typography.title(18))
                            .foregroundStyle(Theme.Colors.textPrimary)
                        
                        Text(summary)
                            .font(Theme.Typography.body(16))
                            .foregroundStyle(Theme.Colors.textSecondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(Theme.Spacing.md)
                    .background(Theme.Colors.cardSurface)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                
                Spacer()
            }
            .padding(Theme.Spacing.md)
            .background(Theme.Colors.background)
            .navigationTitle("Game Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    let sampleGames = [
        GameLog(
            userId: "123",
            date: Date(),
            context: .hs,
            opponent: "Warriors",
            stats: GameStats(shotsFaced: 16, saves: 12, goalsAllowed: 4, clears: 8),
            source: .after
        ),
        GameLog(
            userId: "123",
            date: Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date(),
            context: .hs,
            opponent: "Eagles",
            stats: GameStats(shotsFaced: 20, saves: 14, goalsAllowed: 6, clears: 10),
            source: .live
        )
    ]
    
    RecentGamesCard(games: sampleGames) {
        print("See All tapped")
    }
    .padding()
    .background(Theme.Colors.backgroundPrimary)
}
