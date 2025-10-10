//
//  Step0ProfilePictureView.swift
//  StatLocker
//
//  Step 0: Profile Picture Selection
//  Allows users to upload a profile picture or skip to continue.
//

import SwiftUI

struct Step0ProfilePictureView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var showingImagePicker = false
    @State private var showingCamera = false
    
    var body: some View {
        VStack(spacing: Theme.Spacing.xl) {
            Spacer()
            
            // Header
            VStack(spacing: Theme.Spacing.md) {
                Text("Add a Profile Picture")
                    .font(Theme.Typography.headline(28))
                    .foregroundStyle(Theme.Colors.textPrimary)
                    .multilineTextAlignment(.center)
                
                Text("Upload a photo to personalize your profile")
                    .font(Theme.Typography.body(16))
                    .foregroundStyle(Theme.Colors.textSecondary)
                    .multilineTextAlignment(.center)
            }
            
            // Profile Picture Section
            VStack(spacing: Theme.Spacing.lg) {
                // Profile Picture Circle
                Button(action: {
                    showingImagePicker = true
                    print("[StatLocker][Onboarding] Profile picture selection tapped")
                }) {
                    ZStack {
                        Circle()
                            .fill(Theme.Colors.backgroundSecondary)
                            .frame(width: 120, height: 120)
                            .overlay(
                                Circle()
                                    .stroke(Theme.Colors.divider, lineWidth: 2)
                            )
                        
                        if let profileImage = viewModel.profilePicture {
                            Image(uiImage: profileImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 120, height: 120)
                                .clipShape(Circle())
                        } else {
                            VStack(spacing: Theme.Spacing.sm) {
                                Image(systemName: "camera.fill")
                                    .font(.system(size: 32))
                                    .foregroundStyle(Theme.Colors.textSecondary)
                                
                                Text("Tap to add photo")
                                    .font(Theme.Typography.caption(12))
                                    .foregroundStyle(Theme.Colors.textTertiary)
                            }
                        }
                    }
                }
                .accessibilityLabel("Add profile picture")
                .accessibilityHint("Tap to select a photo from your library")
                
                // Upload Options
                VStack(spacing: Theme.Spacing.md) {
                    Button(action: {
                        showingImagePicker = true
                    }) {
                        HStack(spacing: Theme.Spacing.sm) {
                            Image(systemName: "photo.on.rectangle")
                                .font(.system(size: 16))
                            
                            Text("Choose from Library")
                                .font(Theme.Typography.body(16))
                        }
                        .foregroundStyle(Theme.Colors.textPrimary)
                        .frame(maxWidth: .infinity)
                        .padding(Theme.Spacing.md)
                        .background(Theme.Colors.backgroundSecondary)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Theme.Colors.divider, lineWidth: 1)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .accessibilityLabel("Choose photo from library")
                    
                    Button(action: {
                        showingCamera = true
                    }) {
                        HStack(spacing: Theme.Spacing.sm) {
                            Image(systemName: "camera")
                                .font(.system(size: 16))
                            
                            Text("Take Photo")
                                .font(Theme.Typography.body(16))
                        }
                        .foregroundStyle(Theme.Colors.textPrimary)
                        .frame(maxWidth: .infinity)
                        .padding(Theme.Spacing.md)
                        .background(Theme.Colors.backgroundSecondary)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Theme.Colors.divider, lineWidth: 1)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .accessibilityLabel("Take a photo")
                }
            }
            
            Spacer()
            
            // Skip Button
            Button(action: {
                print("[StatLocker][Onboarding] Profile picture step skipped")
                viewModel.goToNextStep()
            }) {
                Text("Skip for now")
                    .font(Theme.Typography.body(16))
                    .foregroundStyle(Theme.Colors.textSecondary)
                    .underline()
            }
            .accessibilityLabel("Skip adding profile picture")
        }
        .padding(Theme.Spacing.xl)
        .background(Theme.Colors.backgroundPrimary)
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(selectedImage: $viewModel.profilePicture)
        }
        .sheet(isPresented: $showingCamera) {
            CameraPicker(selectedImage: $viewModel.profilePicture)
        }
    }
}

// MARK: - Image Picker Components

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Environment(\.dismiss) private var dismiss
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let editedImage = info[.editedImage] as? UIImage {
                parent.selectedImage = editedImage
            } else if let originalImage = info[.originalImage] as? UIImage {
                parent.selectedImage = originalImage
            }
            parent.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.dismiss()
        }
    }
}

struct CameraPicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Environment(\.dismiss) private var dismiss
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera
        picker.allowsEditing = true
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: CameraPicker
        
        init(_ parent: CameraPicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let editedImage = info[.editedImage] as? UIImage {
                parent.selectedImage = editedImage
            } else if let originalImage = info[.originalImage] as? UIImage {
                parent.selectedImage = originalImage
            }
            parent.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.dismiss()
        }
    }
}

#Preview("Step0ProfilePictureView") {
    Step0ProfilePictureView(viewModel: OnboardingViewModel(userId: "preview", displayName: "Preview User", email: "preview@example.com"))
}