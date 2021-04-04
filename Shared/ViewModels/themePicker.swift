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


let orangeTheme = themePicker(mainColor: Color(#colorLiteral(red: 0.9450980392, green: 0.7411764706, blue: 0.3098039216, alpha: 1)), gradient: LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9450980392, green: 0.7411764706, blue: 0.3098039216, alpha: 1)), Color(#colorLiteral(red: 0.8862745098, green: 0.6039215686, blue: 0.2666666667, alpha: 1)), Color(#colorLiteral(red: 0.7764705882, green: 0.4274509804, blue: 0.1725490196, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing), accentColor: Color(#colorLiteral(red: 0.8862745098, green: 0.6039215686, blue: 0.2666666667, alpha: 1)))

let greenTheme = themePicker(mainColor: Color(#colorLiteral(red: 0.2784313725, green: 0.862745098, blue: 0.5254901961, alpha: 1)), gradient: LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2784313725, green: 0.862745098, blue: 0.5254901961, alpha: 1)), Color(#colorLiteral(red: 0.07843137255, green: 0.7215686275, blue: 0.6509803922, alpha: 1)), Color(#colorLiteral(red: 0.02745098039, green: 0.7137254902, blue: 0.8235294118, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing), accentColor: Color(#colorLiteral(red: 0.07843137255, green: 0.7215686275, blue: 0.6509803922, alpha: 1)))

let blueTheme = themePicker(mainColor: Color(#colorLiteral(red: 0.2352941176, green: 0.7333333333, blue: 0.9803921569, alpha: 1)), gradient: LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2352941176, green: 0.7333333333, blue: 0.9803921569, alpha: 1)), Color(#colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.9137254902, alpha: 1)), Color(#colorLiteral(red: 0.1568627451, green: 0.4039215686, blue: 0.8117647059, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing), accentColor: Color(#colorLiteral(red: 0.2, green: 0.5647058824, blue: 0.9137254902, alpha: 1)))

let purpleTheme = themePicker(mainColor: Color(#colorLiteral(red: 0.368627451, green: 0.3058823529, blue: 0.9411764706, alpha: 1)), gradient: LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.368627451, green: 0.3058823529, blue: 0.9411764706, alpha: 1)), Color(#colorLiteral(red: 0.3294117647, green: 0.2392156863, blue: 0.8352941176, alpha: 1)), Color(#colorLiteral(red: 0.3058823529, green: 0.1529411765, blue: 0.7960784314, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing), accentColor: Color(#colorLiteral(red: 0.3294117647, green: 0.2392156863, blue: 0.8352941176, alpha: 1)))


internal enum colorTheme: Int, Identifiable, CaseIterable{
    case green, orange, blue, purple
    
    var id: Int { rawValue }
    
    var colors: themePicker{
        switch self {
        case .green: return greenTheme
        case .orange: return orangeTheme
        case .blue: return blueTheme
        case .purple: return purpleTheme
        }
    }
}



