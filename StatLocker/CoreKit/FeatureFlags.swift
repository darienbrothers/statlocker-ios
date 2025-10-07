//
//  FeatureFlags.swift
//  StatLocker
//
//  Loads FeatureFlags.plist at runtime. Fail gracefully if missing.
//  [StatLocker][Boot] logs included per project rules.
//

import Foundation

struct FeatureFlags {
    let aiEnabled: Bool
    let ocrEnabled: Bool
    let paywallEnabled: Bool
    let fabVariant: String

    static func load() -> FeatureFlags {
        guard let url = Bundle.main.url(forResource: "FeatureFlags", withExtension: "plist"),
              let data = try? Data(contentsOf: url),
              let dict = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: Any]
        else {
            print("[StatLocker][Boot] FeatureFlags.plist not found — using safe defaults")
            return FeatureFlags(aiEnabled: true, ocrEnabled: false, paywallEnabled: true, fabVariant: "centerTab")
        }

        let flags = FeatureFlags(
            aiEnabled: dict["AI_ENABLED"] as? Bool ?? true,
            ocrEnabled: dict["OCR_ENABLED"] as? Bool ?? false,
            paywallEnabled: dict["PAYWALL_ENABLED"] as? Bool ?? true,
            fabVariant: dict["FAB_VARIANT"] as? String ?? "centerTab"
        )
        print("[StatLocker][Boot] Feature flags loaded: AI=\(flags.aiEnabled) OCR=\(flags.ocrEnabled) PAYWALL=\(flags.paywallEnabled) FAB=\(flags.fabVariant)")
        return flags
    }
}


