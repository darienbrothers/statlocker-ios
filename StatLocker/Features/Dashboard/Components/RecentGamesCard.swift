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
        VStack(alignment: .leading, spacing: Theme.Spacing.md) {
            HStack {
                Label("Recent Games", systemImage: "gamecontroller.fill")
                    .font(Theme.Typography.title(18))
                    .foregroundStyle(Theme.Colors.textPrimary)
                
                Spacer()
                
                Button("See All", action: onSeeAll)
                    .font(Theme.Typography.title(14))
                    .foregroundStyle(Theme.Colors.primary)
                    .accessibilityLabel("View all games in Stats tab")
            }
            
            if games.isEmpty {
                EmptyStateCard(
                    icon: "gamecontroller",
                    message: "Your game history will appear here"
                )
            } else {
                VStack(spacing: Theme.Spacing.sm) {
                    ForEach(games.prefix(2)) { game in
                        GameCard(game: game)
                    }
                }
            }
        }
        .padding(Theme.Spacing.md)
        .background(Theme.Colors.cardSurface)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .themedShadow(Theme.Shadows.card)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Recent games section")
    }
}

struct GameCard: View {
    let game: GameLog
    @State private var showDetail = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text("vs \(game.opponent ?? "Unknown")")
                    .font(Theme.Typography.title(16))
                Text("•")
                    .foregroundStyle(Theme.Colors.textSecondary)
                Text(game.result)
                    .foregroundStyle(game.isWin ? Theme.Colors.success : Theme.Colors.error)
            }
            .font(Theme.Typography.title(16))
            
            Text(game.formattedDate + " • " + game.contextLabel)
                .font(Theme.Typography.body(14))
                .foregroundStyle(Theme.Colors.textSecondary)
            
            Text(game.keyStats)
                .font(Theme.Typography.body(14))
                .foregroundStyle(Theme.Colors.textPrimary)
            
            Button(action: { showDetail = true }) {
                Text("→ Tap to see AI summary")
                    .font(Theme.Typography.caption(13))
                    .foregroundStyle(Theme.Colors.primary)
            }
        }
        .padding(Theme.Spacing.sm)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Theme.Colors.background)
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
    .background(Theme.Colors.background)
}
