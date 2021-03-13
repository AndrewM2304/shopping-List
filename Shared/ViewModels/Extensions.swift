//
//  Extensions.swift
//  shopping List (iOS)
//
//  Created by Andrew Miller on 29/01/2021.
//

import Foundation
import SwiftUI



extension Text {
    func whiteTitleStyle() -> some View{
        self
            .font(Font.body.weight(.bold))
            .foregroundColor(Color.white).padding(.top, 30)
    }
}

extension Text {
    func primaryTextStyle() -> some View{
        self
            .font(.subheadline)
            .bold()
            .foregroundColor(.primary)
    }
}


extension Text {
    func secondaryTextStyle() -> some View{
        self
            .font(.caption)
            .foregroundColor(.secondary)
    }
}


struct primaryButtonStyle: ButtonStyle {
        @AppStorage("theme") var currentTheme: colorTheme = .green
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(Font.headline.weight(.bold))
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(currentTheme.colors.mainColor)
            .cornerRadius(8)
            .scaleEffect(configuration.isPressed ? 0.95 : 1).animation(.interactiveSpring())
            .shadow(color: Color("shadow").opacity(0.05), radius: 8, x: 0.0, y: 2)
    }
}

struct descructiveButtonStyle: ButtonStyle {
       
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(Font.headline.weight(.semibold))
            .foregroundColor(.red)
            .padding(10)
            .frame(maxWidth: .infinity)
            .cornerRadius(8)
            .scaleEffect(configuration.isPressed ? 0.95 : 1).animation(.interactiveSpring())
    }
}



struct dateButtonStyle: ButtonStyle {
    @Binding var tapped: Bool
    @AppStorage("theme") var currentTheme: colorTheme = .green
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(Font.footnote.weight(.semibold))
            .foregroundColor(tapped ? .white : currentTheme.colors.mainColor)
            .padding(.vertical, 10)
            .frame(minWidth: 80)
            .foregroundColor( tapped ? Color.white : currentTheme.colors.mainColor)
            .background( tapped ? currentTheme.colors.mainColor : Color("CardBackground"))
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(currentTheme.colors.mainColor, lineWidth: 2))
            .cornerRadius(8)
            .scaleEffect(configuration.isPressed ? 0.95 : 1).animation(.interactiveSpring())
    }
}

struct popButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1).animation(.interactiveSpring())
    }
}

func vibratePress() {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.success)
    print("this vibrates")
}



extension View{
    func cardStyle() -> some View{
        self
            .frame(maxWidth: 600)
            .padding(20)
            .background(Color("CardBackground"))
            .cornerRadius(8)
            .shadow(color: Color("shadow").opacity(0.05), radius: 8, x: 0.0, y: 2)
    }
}




