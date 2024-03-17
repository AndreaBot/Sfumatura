//
//  CustomGradientView.swift
//  Sfumatura
//
//  Created by Andrea Bottino on 15/03/2024.
//

import SwiftUI

struct CustomGradientView: View {
    
    let gradient: GradientModel
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: gradient.colors),
                       startPoint: GradientModel.setStartPoint(using: gradient.direction),
                       endPoint: GradientModel.setEndPoint(using: gradient.direction))
        .frame(width: UIScreen.main.bounds.width/2.35, height: UIScreen.main.bounds.height/2.35)
        .clipShape(RoundedRectangle(cornerRadius: UIScreen.main.bounds.width/11.75))
    }
}

#Preview {
    CustomGradientView(gradient: GradientModel(colors: [.red, .blue], direction: .vertical))
}
