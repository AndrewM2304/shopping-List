//
//  themePicker.swift
//  shopping List (iOS)
//
//  Created by Andrew Miller on 03/01/2021.
//

import SwiftUI
import Foundation

struct themePicker{
    var mainColor: Color
    var gradient:LinearGradient
    
}


let orangeTheme = themePicker(mainColor: Color("accentOrange"), gradient: LinearGradient(gradient: Gradient(colors: [Color("OrangeYellowGrad1"), Color("OrangeYellowGrad2")]), startPoint: .topLeading, endPoint: .bottomTrailing))

let greenTheme = themePicker(mainColor: Color("accentGreen"), gradient: LinearGradient(gradient: Gradient(colors: [Color("BlueGreenGrad1"), Color("BlueGreenGrad2")]), startPoint: .topLeading, endPoint: .bottomTrailing))

let pinkTheme = themePicker(mainColor: Color("accentPink"), gradient: LinearGradient(gradient: Gradient(colors: [Color("PinkMagentaGrad1"),Color("PinkMagentaGrad2")]), startPoint: .topLeading, endPoint: .bottomTrailing))

let purpleTheme = themePicker(mainColor: Color("accentPurple"), gradient: LinearGradient(gradient: Gradient(colors: [Color("PurpleBlueGrad1"),Color("PurpleBlueGrad2")]), startPoint: .topLeading, endPoint: .bottomTrailing))


internal enum colorTheme: Int, Identifiable, CaseIterable{
    case green, orange, pink, purple
    
    var id: Int { rawValue }
    
    var colors: themePicker{
        switch self {
        case .green: return greenTheme
        case .orange: return orangeTheme
        case .pink: return pinkTheme
        case .purple: return purpleTheme
        }
    }
}



