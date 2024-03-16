//
//  Color Extension.swift
//  Sfumatura
//
//  Created by Andrea Bottino on 16/03/2024.
//

import SwiftUI

extension Color {
    var redComponent: Double? {
        guard let components = cgColor?.components, components.count >= 3 else { return nil }
        return Double(components[0])
    }
    
    var greenComponent: Double? {
        guard let components = cgColor?.components, components.count >= 3 else { return nil }
        return Double(components[1])
    }
    
    var blueComponent: Double? {
        guard let components = cgColor?.components, components.count >= 3 else { return nil }
        return Double(components[2])
    }
}

