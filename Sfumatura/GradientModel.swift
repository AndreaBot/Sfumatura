//
//  GradientModel.swift
//  Sfumatura
//
//  Created by Andrea Bottino on 16/03/2024.
//

import SwiftUI

struct GradientModel: Hashable {
    
    let colors: [Color]
    let direction: GradientDirection
    
    static func setStartPoint(using direction: GradientDirection) -> UnitPoint {
        switch direction {
        case .horizontal: return .leading
        case .vertical: return .top
        case .diagLH: return .topLeading
        case .diagRH: return .topTrailing
        }
    }
    
    static func setEndPoint(using direction: GradientDirection) -> UnitPoint {
        switch direction {
        case .horizontal: return .trailing
        case .vertical: return .bottom
        case .diagLH: return .bottomTrailing
        case .diagRH: return .bottomLeading
        }
    }
}
