//
//  Theme.swift
//  StatLocker
//
//  Design tokens and lightweight UI primitives for StatLocker.
//  Uses system fonts; colors from Design Theme. Keep edit-friendly and under 200-300 lines.
//

import SwiftUI
import Combine

// MARK: - Theme

enum Theme {
    enum Colors {
        // Brand
        static let primary = Color(hex: "#4F46E5")
        static let primaryPressed = Color(hex: "#4338CA")
        static let accentEmerald = Color(hex: "#1AEC88")
        static let accentTeal = Color(hex: "#0BF8CB")

        // Text
        static let textPrimary = Color(hex: "#0F172A")
        static let textSecondary = Color(hex: "#334155")

        // Surfaces
        static let background = Color.white
        static let cardSurface = Color(hex: "#F8FAFC")
        static let divider = Color(hex: "#E2E8F0")

        // Status
        static let success = Color(hex: "#22C55E")
        static let warning = Color(hex: "#F59E0B")
        static let error = Color(hex: "#EF4444")
        static let muted = Color(hex: "#A3A3A3")
    }

    enum Spacing {
        static let xxs: CGFloat = 4
        static let xs: CGFloat = 8
        static let sm: CGFloat = 12
        static let md: CGFloat = 16
        static let lg: CGFloat = 20
        static let xl: CGFloat = 24
        static let xxl: CGFloat = 32
    }

    enum Typography {
        // System fonts for now; SF Rounded for numbers where appropriate
        static func headline(_ size: CGFloat = 28) -> Font { .system(size: size, weight: .bold, design: .default) }
        static func title(_ size: CGFloat = 22) -> Font { .system(size: size, weight: .semibold, design: .default) }
        static func body(_ size: CGFloat = 17) -> Font { .system(size: size, weight: .regular, design: .default) }
        static func number(_ size: CGFloat = 28, weight: Font.Weight = .semibold) -> Font { .system(size: size, weight: weight, design: .rounded) }
        static func caption(_ size: CGFloat = 13) -> Font { .system(size: size, weight: .regular, design: .default) }
    }

    enum Shadows {
        // Subtle, high-contrast friendly shadows
        static let card = ShadowStyle(color: Color.black.opacity(0.06), radius: 8, x: 0, y: 2)
        static let elevated = ShadowStyle(color: Color.black.opacity(0.12), radius: 16, x: 0, y: 8)
    }
}

struct ShadowStyle {
    let color: Color
    let radius: CGFloat
    let x: CGFloat
    let y: CGFloat
}

extension View {
    func themedShadow(_ style: ShadowStyle) -> some View {
        shadow(color: style.color, radius: style.radius, x: style.x, y: style.y)
    }
}

// MARK: - Components

struct StatTile: View {
    let title: String
    let value: String
    let trendText: String?
    let accent: Color

    init(title: String, value: String, trendText: String? = nil, accent: Color = Theme.Colors.primary) {
        self.title = title
        self.value = value
        self.trendText = trendText
        self.accent = accent
    }

    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
            Text(title)
                .font(Theme.Typography.caption())
                .foregroundStyle(Theme.Colors.textSecondary)

            Text(value)
                .font(Theme.Typography.number(28))
                .foregroundStyle(Theme.Colors.textPrimary)

            if let trend = trendText, !trend.isEmpty {
                Text(trend)
                    .font(Theme.Typography.caption())
                    .foregroundStyle(accent)
            }
        }
        .padding(Theme.Spacing.lg)
        .background(Theme.Colors.cardSurface)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .themedShadow(Theme.Shadows.card)
        .accessibilityElement(children: .combine)
    }
}

// MARK: - Utilities

extension Color {
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let r = Double((rgb & 0xFF0000) >> 16) / 255
        let g = Double((rgb & 0x00FF00) >> 8) / 255
        let b = Double(rgb & 0x0000FF) / 255

        self.init(red: r, green: g, blue: b)
    }
}

#Preview("StatTile Preview") {
    VStack(alignment: .leading, spacing: Theme.Spacing.md) {
        StatTile(title: "Save%", value: "71%", trendText: "+5% vs avg", accent: Theme.Colors.accentEmerald)
        StatTile(title: "Saves", value: "12")
    }
    .padding()
    .background(Theme.Colors.background)
}


