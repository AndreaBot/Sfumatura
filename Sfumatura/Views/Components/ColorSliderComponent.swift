//
//  rgbSlider.swift
//  Sfumatura
//
//  Created by Andrea Bottino on 15/03/2024.
//

import SwiftUI

struct ColorSliderComponent: View {
    
    @Binding var value: Double
    var color: Color
    
    var body: some View {
        HStack(spacing: 25) {
            Image(systemName: "circle.fill")
                .resizable()
                .scaledToFit()
                .containerRelativeFrame(.horizontal) {size, axis in
                    size * 0.09
                }
                .foregroundStyle(color)
                .padding(5)
            
            Slider(value: $value, in: 0...1)
                .tint(color)
        }
    }
}

#Preview {
    ColorSliderComponent(value: .constant(0.5), color: .red)
}
