//
//  PositionCard.swift
//  StatLocker
//
//  Reusable position card with tooltip overlay for onboarding.
//  Shows tracked stats when tapped per B-003 requirements.
//

import SwiftUI

// MARK: - Position Card

struct PositionCard: View {
    let position: PositionOption
    let isSelected: Bool
    let action: () -> Void
    
    @State private var showTooltip = false
    
    var body: some View {
        Button(action: {
            action()
            print("[StatLocker][Onboarding] Position tapped: \(position.name)")
        }) {
            VStack(spacing: Theme.Spacing.sm) {
                
                // Position Icon
                Image(systemName: position.icon)
                    .font(.system(size: 32))
                    .foregroundStyle(isSelected ? Theme.Colors.accentEmerald : Theme.Colors.primary)
                    .frame(height: 40)
                
                // Position Name
                Text(position.name)
                    .font(Theme.Typography.body(16))
                    .fontWeight(isSelected ? .semibold : .medium)
                    .foregroundStyle(Theme.Colors.textPrimary)
                
                // Info Icon
                HStack(spacing: Theme.Spacing.xxs) {
                    Image(systemName: "info.circle")
                        .font(.system(size: 12))
                        .foregroundStyle(Theme.Colors.muted)
                    
                    Text("Stats")
                        .font(Theme.Typography.caption(11))
                        .foregroundStyle(Theme.Colors.muted)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 130)
            .padding(.vertical, Theme.Spacing.md)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(Theme.Colors.cardSurface)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(
                        isSelected ? Theme.Colors.accentEmerald : Theme.Colors.divider,
                        lineWidth: isSelected ? 2 : 1
                    )
            )
        }
        .buttonStyle(.plain)
        .accessibilityLabel("\(position.name) position")
        .accessibilityHint("Tap to select \(position.name). Double tap info icon for tracked stats.")
        .accessibilityAddTraits(isSelected ? [.isSelected, .isButton] : .isButton)
        .overlay(alignment: .topTrailing) {
            // Info button for tooltip
            Button {
                showTooltip = true
                print("[StatLocker][Onboarding] Showing tooltip for \(position.name)")
            } label: {
                Image(systemName: "info.circle.fill")
                    .font(.system(size: 20))
                    .foregroundStyle(Theme.Colors.primary)
                    .padding(Theme.Spacing.xs)
            }
            .buttonStyle(.plain)
            .accessibilityLabel("View tracked stats for \(position.name)")
        }
        .sheet(isPresented: $showTooltip) {
            PositionTooltipSheet(position: position)
                .presentationDetents([.height(280)])
                .presentationDragIndicator(.visible)
        }
    }
}

// MARK: - Position Tooltip Sheet

struct PositionTooltipSheet: View {
    let position: PositionOption
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.md) {
            
            // Header
            HStack {
                Image(systemName: position.icon)
                    .font(.system(size: 28))
                    .foregroundStyle(Theme.Colors.primary)
                
                Text(position.name)
                    .font(Theme.Typography.title(22))
                    .foregroundStyle(Theme.Colors.textPrimary)
                
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 24))
                        .foregroundStyle(Theme.Colors.muted)
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Close")
            }
            
            Divider()
                .padding(.vertical, Theme.Spacing.xs)
            
            // Tracked Stats
            VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                Text("We track:")
                    .font(Theme.Typography.body(14))
                    .fontWeight(.medium)
                    .foregroundStyle(Theme.Colors.textSecondary)
                
                Text(position.trackedStats)
                    .font(Theme.Typography.body(15))
                    .foregroundStyle(Theme.Colors.textPrimary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            Spacer()
        }
        .padding(Theme.Spacing.xl)
        .background(Theme.Colors.background)
    }
}

// MARK: - Position Option Model

struct PositionOption: Identifiable {
    let id = UUID()
    let name: String
    let icon: String // SF Symbol name
    let trackedStats: String
}

