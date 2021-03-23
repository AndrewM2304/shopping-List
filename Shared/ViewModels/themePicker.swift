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
    var accentColor: Color
    
}


let orangeTheme = themePicker(mainColor: Color("accentOrange"), gradient: LinearGradient(gradient: Gradient(colors: [Color("OrangeYellowGrad1"), Color("OrangeYellowGrad2")]), startPoint: .topLeading, endPoint: .bottomTrailing), accentColor: Color("accentPink"))

let greenTheme = themePicker(mainColor: Color(#colorLiteral(red: 0.2784313725, green: 0.862745098, blue: 0.5254901961, alpha: 1)), gradient: LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2784313725, green: 0.862745098, blue: 0.5254901961, alpha: 1)), Color(#colorLiteral(red: 0.07843137255, green: 0.7215686275, blue: 0.6509803922, alpha: 1)), Color(#colorLiteral(red: 0.02745098039, green: 0.7137254902, blue: 0.8235294118, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing), accentColor: Color(#colorLiteral(red: 0.07843137255, green: 0.7215686275, blue: 0.6509803922, alpha: 1)))

let pinkTheme = themePicker(mainColor: Color("accentPink"), gradient: LinearGradient(gradient: Gradient(colors: [Color("PinkMagentaGrad1"),Color("PinkMagentaGrad2")]), startPoint: .topLeading, endPoint: .bottomTrailing), accentColor: Color("accentPink"))

let purpleTheme = themePicker(mainColor: Color("accentPurple"), gradient: LinearGradient(gradient: Gradient(colors: [Color("PurpleBlueGrad1"),Color("PurpleBlueGrad2")]), startPoint: .topLeading, endPoint: .bottomTrailing), accentColor: Color("accentPink"))


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



