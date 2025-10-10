//
//  GameMetaChips.swift
//  StatLocker
//
//  Context and conference selection chips for game logging.
//  Used in B-005 Logging to capture game metadata (HS/Club, Conference).
//

import SwiftUI
import Foundation

struct GameMetaChips: View {
    @Binding var selectedContext: GameContext
    @Binding var isConference: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.md) {
            // Context Label
            Text("Game Context")
                .font(Theme.Typography.caption(12))
                .fontWeight(.medium)
                .foregroundStyle(Theme.Colors.textTertiary)
                .textCase(.uppercase)
            
            // Context Selector (HS / Club) with gradient styling
            VStack(spacing: Theme.Spacing.sm) {
                HStack(spacing: 0) {
                    // HS Button
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            selectedContext = .hs
                        }
                    }) {
                        Text("High School")
                            .font(Theme.Typography.body(14))
                            .fontWeight(.semibold)
                            .foregroundStyle(selectedContext == .hs ? .white : Theme.Colors.textSecondary)
                            .frame(maxWidth: .infinity)
                            .frame(height: 44)
                            .background(
                                selectedContext == .hs ? 
                                    Theme.Gradients.primaryPurple :
                                    LinearGradient(
                                        colors: [Theme.Colors.backgroundTertiary, Theme.Colors.backgroundTertiary],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    
                    // Club Button
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            selectedContext = .club
                        }
                    }) {
                        Text("Club")
                            .font(Theme.Typography.body(14))
                            .fontWeight(.semibold)
                            .foregroundStyle(selectedContext == .club ? .white : Theme.Colors.textSecondary)
                            .frame(maxWidth: .infinity)
                            .frame(height: 44)
                            .background(
                                selectedContext == .club ? 
                                    Theme.Gradients.primaryPurple :
                                    LinearGradient(
                                        colors: [Theme.Colors.backgroundTertiary, Theme.Colors.backgroundTertiary],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Theme.Colors.divider.opacity(0.3), lineWidth: 1)
                )
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            
            // Conference Toggle (HS only)
            if selectedContext == .hs {
                VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                    Text("Conference Status")
                        .font(Theme.Typography.caption(12))
                        .fontWeight(.medium)
                        .foregroundStyle(Theme.Colors.textTertiary)
                        .textCase(.uppercase)
                    
                    HStack(spacing: 0) {
                        // Conference Button
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                isConference = true
                            }
                        }) {
                            Text("Conference")
                                .font(Theme.Typography.body(14))
                                .fontWeight(.semibold)
                                .foregroundStyle(isConference ? .white : Theme.Colors.textSecondary)
                                .frame(maxWidth: .infinity)
                                .frame(height: 44)
                                .background(
                                    isConference ? 
                                        Theme.Gradients.primaryPurple :
                                        LinearGradient(
                                            colors: [Theme.Colors.backgroundTertiary, Theme.Colors.backgroundTertiary],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        
                        // Non-Conference Button
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                isConference = false
                            }
                        }) {
                            Text("Non-Conference")
                                .font(Theme.Typography.body(14))
                                .fontWeight(.semibold)
                                .foregroundStyle(!isConference ? .white : Theme.Colors.textSecondary)
                                .frame(maxWidth: .infinity)
                                .frame(height: 44)
                                .background(
                                    !isConference ? 
                                        Theme.Gradients.primaryPurple :
                                        LinearGradient(
                                            colors: [Theme.Colors.backgroundTertiary, Theme.Colors.backgroundTertiary],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Theme.Colors.divider.opacity(0.3), lineWidth: 1)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
        .animation(.easeInOut(duration: 0.3), value: selectedContext)
    }
}

#Preview {
    @Previewable @State var context: GameContext = .hs
    @Previewable @State var isConf: Bool = true
    
    VStack(spacing: Theme.Spacing.lg) {
        GameMetaChips(selectedContext: $context, isConference: $isConf)
        
        Text("Selected: \(context == .hs ? "HS" : "Club")\(context == .hs ? (isConf ? " Conference" : " Non-Conference") : "")")
            .font(Theme.Typography.body())
    }
    .padding()
    .background(Theme.Colors.backgroundPrimary)
}

