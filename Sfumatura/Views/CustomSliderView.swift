//
//  CustomSliderView.swift
//  Sfumatura
//
//  Created by Andrea Bottino on 15/03/2024.
//

import SwiftUI

struct CustomSliderView: View {
    
    @Binding var showingColorSheet: Bool
    @Binding var gradientArray: [GradientModel]
    
    @State private var colorsCount = 2
    
    @State private var colorsArray = [
        ColorModel(red: 0, green: 0, blue: 0),
        ColorModel(red: 0, green: 0, blue: 0)
    ]
    
    @State private var activeColorIndex = 0
    
    @State private var direction: GradientDirection = .horizontal
    
    let editing: Bool
    let gradientToEdit: GradientModel?
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button("Cancel") { showingColorSheet = false }
                    .padding(.horizontal)
            }
            
            ZStack(alignment: .bottom) {
                LinearGradient(colors: setCurrentColors(),
                               startPoint: GradientModel.setStartPoint(using: direction),
                               endPoint: GradientModel.setEndPoint(using: direction))
                
                Picker("Select gradient direction", selection: $direction) {
                    Image(systemName: "arrow.left.and.right.circle")
                        .tag(GradientDirection.horizontal)
                    Image(systemName: "arrow.up.and.down.circle")
                        .tag(GradientDirection.vertical)
                    Image(systemName: "arrow.up.backward.and.arrow.down.forward.circle")
                        .tag(GradientDirection.diagLH)
                    Image(systemName: "arrow.down.left.and.arrow.up.right.circle")
                        .tag(GradientDirection.diagRH)
                }
                .pickerStyle(.segmented)
                .background(.white)
            }
            
            VStack {
                HStack {
                    Picker("Select color", selection: $activeColorIndex) {
                        ForEach(0..<colorsCount, id: \.self) { int in
                            Text("Color \(int+1)")
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Button {
                        colorsCount += 1
                        colorsArray.append(ColorModel(red: 0, green: 0, blue: 0))
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                
                ColorSliderComponent(value: $colorsArray[activeColorIndex].red, color: .red)
                ColorSliderComponent(value: $colorsArray[activeColorIndex].green, color: .green)
                ColorSliderComponent(value: $colorsArray[activeColorIndex].blue, color: .blue)
                
                Button {
                    editing ? confirmEditing() : createGradient()
                    showingColorSheet = false
                } label: {
                    Text(editing ? "Confirm changes" : "Create gradient")
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
        .onAppear {
            if editing {
                colorsCount = gradientToEdit!.colors.count
                modifyColorsArray()
            }
        }
    }
    
    func modifyColorsArray() {
        for _ in 0..<gradientToEdit!.colors.count - 2 {
            colorsArray.append(ColorModel(red: 0, green: 0, blue: 0))
        }
        for i in 0..<colorsCount{
            colorsArray[i].red = gradientToEdit!.colors[i].redComponent!
            colorsArray[i].green = gradientToEdit!.colors[i].greenComponent!
            colorsArray[i].blue = gradientToEdit!.colors[i].blueComponent!
        }
    }
    
    func createGradient() {
        gradientArray.append(GradientModel(
            colors: setCurrentColors(),
            direction: direction)
        )
    }
    
    func confirmEditing() {
        let editedGradient = GradientModel(colors: setCurrentColors(),
                                           direction: direction)
        
        if let gradientIndex = gradientArray.firstIndex(of: gradientToEdit!) {
            gradientArray[gradientIndex] = editedGradient
        }
    }
    
    func setCurrentColors() -> [Color] {
        var colorArray = [Color]()
        for i in 0..<colorsCount {
            colorArray.append(Color(red: colorsArray[i].red,
                                    green: colorsArray[i].green,
                                    blue: colorsArray[i].blue))
        }
        return colorArray
    }
}


#Preview {
    CustomSliderView(showingColorSheet: .constant(true), gradientArray: .constant([GradientModel]()), editing: false, gradientToEdit: GradientModel(colors: [.red, .blue], direction: .vertical))
}
