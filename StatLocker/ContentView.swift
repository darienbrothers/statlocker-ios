//
//  ContentView.swift
//  StatLocker
//
//  Created by Darien Brothers on 10/6/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 24) {
            ZStack {
                Color(red: 0.31, green: 0.27, blue: 0.90)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .frame(height: 120)
                Image("BrandLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 48)
                    .accessibilityLabel("StatLocker logo")
            }
            .padding(.horizontal, 32)

            Text("Welcome to StatLocker")
                .font(.system(size: 22, weight: .semibold))
                .foregroundStyle(Color(red: 0.06, green: 0.09, blue: 0.16))

            Text("Design tokens and assets are installed (B-001)")
                .font(.system(size: 15))
                .foregroundStyle(Color(red: 0.20, green: 0.32, blue: 0.53))

            Spacer(minLength: 24)
        }
        .padding(.top, 40)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
}

#Preview {
    ContentView()
}
