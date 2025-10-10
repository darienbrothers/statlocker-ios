//
//  ProfileImageView.swift
//  StatLocker
//
//  Reusable profile image component that loads from base64 data stored in Firestore.
//  Falls back to initials if no image is available.
//

import SwiftUI

struct ProfileImageView: View {
    let imageData: String? // base64 encoded image data
    let initials: String
    let size: CGFloat
    @State private var image: UIImage?
    
    var body: some View {
        Group {
            if let image = image {
                // Display loaded image
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: size, height: size)
                    .clipShape(Circle())
            } else {
                // Initials fallback
                Circle()
                    .fill(Theme.Colors.cardSurface)
                    .frame(width: size, height: size)
                    .overlay(
                        Text(initials)
                            .font(.system(size: size * 0.4, weight: .semibold))
                            .foregroundStyle(Theme.Colors.primary)
                    )
            }
        }
        .overlay(
            Circle()
                .stroke(Theme.Colors.divider, lineWidth: 1)
        )
        .onAppear {
            loadImage()
        }
    }
    
    // MARK: - Image Loading
    
    private func loadImage() {
        guard let imageData = imageData else {
            print("[StatLocker][ProfileImage] No image data provided, using initials")
            return
        }
        
        print("[StatLocker][ProfileImage] Loading profile picture from base64 data")
        
        if let data = Data(base64Encoded: imageData),
           let loadedImage = UIImage(data: data) {
            self.image = loadedImage
            print("[StatLocker][ProfileImage] Profile picture loaded successfully")
        } else {
            print("[StatLocker][ProfileImage] Failed to decode image from base64")
        }
    }
}

#Preview("With Initials") {
    ProfileImageView(
        imageData: nil,
        initials: "JS",
        size: 80
    )
    .padding()
}

