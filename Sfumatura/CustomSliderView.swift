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
                if !editing {
                    LinearGradient(colors: [
                        Color(red: colorsArray[0].red,
                              green: colorsArray[0].green,
                              blue: colorsArray[0].blue),
                        
                        Color(red: colorsArray[1].red,
                              green: colorsArray[1].green,
                              blue: colorsArray[1].blue)
                    ],
                                   startPoint: GradientModel.setStartPoint(using: direction),
                                   endPoint: GradientModel.setEndPoint(using: direction))
                    
                } else {
                    LinearGradient(gradient: Gradient(colors: gradientToEdit!.colors),
                                   startPoint: GradientModel.setStartPoint(using: gradientToEdit!.direction),
                                   endPoint: GradientModel.setEndPoint(using: gradientToEdit!.direction))
                }
                
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
                    Button("Set first color") {
                        activeColorIndex = 0
                    }
                    
                    Spacer()
                    
                    Button("Set second color") {
                        activeColorIndex = 1
                    }
                }
                .buttonStyle(.bordered)
                .padding([.horizontal, .bottom])
                
                ColorSliderComponent(value: $colorsArray[activeColorIndex].red, color: .red)
                ColorSliderComponent(value: $colorsArray[activeColorIndex].green, color: .green)
                ColorSliderComponent(value: $colorsArray[activeColorIndex].blue, color: .blue)
                
                Button("Confirm") {
                    gradientArray.append(GradientModel(colors: [
                        Color(cgColor: CGColor(red: colorsArray[0].red,
                                               green: colorsArray[0].green,
                                               blue: colorsArray[0].blue,
                                               alpha: 1)),
                        Color(cgColor: CGColor(red: colorsArray[1].red,
                                               green: colorsArray[1].green,
                                               blue: colorsArray[1].blue,
                                               alpha: 1))],
                                                       direction: direction))
                    
                    showingColorSheet = false
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
    }
}


#Preview {
    CustomSliderView(showingColorSheet: .constant(true), gradientArray: .constant([GradientModel]()), editing: false, gradientToEdit: GradientModel(colors: [.red, .blue], direction: .vertical))
}
