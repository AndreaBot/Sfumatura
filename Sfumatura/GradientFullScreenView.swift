//
//  GradientFullScreenView.swift
//  Sfumatura
//
//  Created by Andrea Bottino on 15/03/2024.
//

import Photos
import SwiftUI

struct GradientFullScreenView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let gradient: GradientModel
    
    @Binding var gradientsArray: [GradientModel]
    @State private var showOptions = false
    @State private var showingEditScreen = false
    
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        VStack {
            LinearGradient(gradient: Gradient(colors: gradient.colors),
                           startPoint: GradientModel.setStartPoint(using: gradient.direction),
                           endPoint: GradientModel.setEndPoint(using: gradient.direction))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    showOptions = true
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }
        }
        .confirmationDialog("Test", isPresented: $showOptions) {
            Button("Edit") {
                showingEditScreen = true
            }
            Button("Download") {
                if let image = createUiImage() {
                    download(uiImage: image)
                }
            }
            if let image = createUiImage() {
                let swiftImage = Image(uiImage: image)
                ShareLink(item: swiftImage, preview: SharePreview("Share your gradient", image: swiftImage))
            }
            Button("Delete", role: .destructive) {
                if let currentGradientIndex = gradientsArray.firstIndex(of: gradient) {
                    gradientsArray.remove(at: currentGradientIndex)
                    dismiss()
                }
            }
        }
        .fullScreenCover(isPresented: $showingEditScreen, content: {
            CustomSliderView(showingColorSheet: $showingEditScreen, gradientArray: $gradientsArray, editing: true, gradientToEdit: gradient)
        })
        .alert(alertTitle, isPresented: $showingAlert) {
            Button("OK") {}
        } message: {
            Text(alertMessage)
        }
    }
    
    @MainActor func createUiImage() -> UIImage? {
        let gradientToSave = LinearGradient(gradient: Gradient(colors: gradient.colors),
                                            startPoint: GradientModel.setStartPoint(using: gradient.direction),
                                            endPoint: GradientModel.setEndPoint(using: gradient.direction))
        
        let baseImage =  Rectangle()
            .frame(width: 1290, height: 2796)
            .foregroundStyle(gradientToSave)
            .background(Color.clear)
        
        let renderer =  ImageRenderer(content: baseImage)
        
        if let downloadImage = renderer.cgImage {
            let uiImage = UIImage(cgImage: downloadImage)
            return uiImage
        } else {
            return nil
        }
    }
    
    func download(uiImage: UIImage) {
        if let data = uiImage.jpegData(compressionQuality: 0.8) {
            PHPhotoLibrary.requestAuthorization { status in
                if status == .authorized {
                    PHPhotoLibrary.shared().performChanges {
                        let creationRequest = PHAssetCreationRequest.forAsset()
                        creationRequest.addResource(with: .photo, data: data, options: nil)
                    } completionHandler: { success, error in
                        if success {
                            alertTitle = "Success"
                            alertMessage = "Image saved successfully to Photos"
                            showingAlert = true
                        } else {
                            alertTitle = "Oops..."
                            alertMessage = "There was an error saving the image to Photos"
                            showingAlert = true
                        }
                    }
                } else {
                    print("Authorization denied for accessing Photos.")
                    alertTitle = "Oops"
                    alertMessage = "Authorization denied for accessing Photos. Please allow access in the app settings"
                    showingAlert = true
                }
            }
        }
    }
}


#Preview {
    GradientFullScreenView(gradient: GradientModel(colors: [.red, .blue], direction: .diagRH), gradientsArray: .constant([GradientModel]()))
}

