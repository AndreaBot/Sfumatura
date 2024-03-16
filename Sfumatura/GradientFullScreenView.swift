//
//  GradientFullScreenView.swift
//  Sfumatura
//
//  Created by Andrea Bottino on 15/03/2024.
//

import SwiftUI

struct GradientFullScreenView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let gradient: GradientModel
    
    @Binding var gradientsArray: [GradientModel]
    @State private var showOptions = false
    @State private var showingEditScreen = false
    
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
            Button("Delete", role: .destructive) {
                if let currentGradientIndex = gradientsArray.firstIndex(of: gradient) {
                    gradientsArray.remove(at: currentGradientIndex)
                    dismiss()
                }
            }
            Button("Download") {
                
            }
        }
        .fullScreenCover(isPresented: $showingEditScreen, content: {
            CustomSliderView(showingColorSheet: $showingEditScreen, gradientArray: $gradientsArray, editing: true, gradientToEdit: gradient)
        })
    }
}

#Preview {
    GradientFullScreenView(gradient: GradientModel(colors: [.red, .blue], direction: .diagRH), gradientsArray: .constant([GradientModel]()))
}
