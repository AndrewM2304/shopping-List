//
//  Extensions.swift
//  shopping List (iOS)
//
//  Created by Andrew Miller on 29/01/2021.
//

import Foundation
import SwiftUI








struct primaryButtonStyle: ButtonStyle {
    @State var gradient: LinearGradient
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .background(RoundedRectangle(cornerRadius: 8, style: .continuous).fill(gradient))
            .cornerRadius(8)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .shadow(color: Color("shadow").opacity(0.40), radius: 8, x: 0.0, y: 2)
    }
}




struct popButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
//            .scaleEffect(configuration.isPressed ? 0.98 : 1).animation(.interactiveSpring())
    }
}

func vibratePress() {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.success)
    print("this vibrates")
}



struct pageHeader: ViewModifier {
    func body(content: Content) -> some View {
        content
            
            .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1215686275, green: 0.1490196078, blue: 0.168627451, alpha: 1)), Color(#colorLiteral(red: 0.07058823529, green: 0.1137254902, blue: 0.137254902, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).stroke(Color.white.opacity(0.03)))
    }
}


extension View{
    func backgroundGradient(isTapped: Bool, gradient: LinearGradient, color: Color) -> some View{
        self
            .background(color.opacity(isTapped ? 1 : 0))
            .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1450980392, green: 0.1882352941, blue: 0.2196078431, alpha: 1)), Color(#colorLiteral(red: 0.07450980392, green: 0.1137254902, blue: 0.137254902, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(8)
            .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).stroke(Color.white.opacity(0.05), lineWidth: 1))
            .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).stroke(gradient, lineWidth: 3).opacity(isTapped ? 1 : 0))
        
    }
}



extension Text{
    
    func interTextStyle(text:String, size : CGFloat, color: Color) -> some View{
        self
            .font(.custom(text, size : size))
            .foregroundColor(color)
    }
   
}




struct SearchTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .padding(10)
            .font(.custom("Inter-Medium", size: 15))
            .background(Color.clear)
            .foregroundColor(.black)
            .cornerRadius(4)
    }
}


