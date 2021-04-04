//
//  accountScreenView.swift
//  shopping List
//
//  Created by Andrew Miller on 03/01/2021.
//

import SwiftUI

struct accountScreenView: View {

    var body: some View {
        ScrollView (showsIndicators: false){
        VStack {
            HStack{
                Text("Settings")
                    .interTextStyle(text: "Inter-ExtraBold", size: 28, color: Color.white)
            Spacer()
               
            }.padding(.vertical)
            .padding(.top, UIDevice.current.hasNotch ? 20 : 0)
            

            themeSelectorView()
            Spacer()
        }.padding()
        .padding(.vertical)
        }
        .background(radialBackgroundView())
        .edgesIgnoringSafeArea(.vertical)
    }
    

    

    
    
}

struct accountScreenView_Previews: PreviewProvider {
    static var previews: some View {
        accountScreenView()
    }
}

struct themeSelectorView: View {
    @AppStorage("theme") var currentTheme: colorTheme = .green

    var body: some View {
        VStack(alignment: .leading){
            HStack {
                Text("Theme:").interTextStyle(text: "Inter-SemiBold", size: 15, color: .white)
                Spacer()
            }
            HStack (spacing: 15){

                ThemePickerButton(color: .green)
            ThemePickerButton(color: .orange)
            ThemePickerButton(color: .blue)
                ThemePickerButton(color: .purple)
        }
    }
            
        
        
    }

}

struct ThemePickerButton: View {
    @AppStorage("theme") var currentTheme: colorTheme = .green
    var color: colorTheme
    var body: some View {
        Button(action: {changeTheme(to: color)}, label: {
            

                Circle()
                    .fill(color.colors.accentColor)
                    .frame(width:40, height:40)

                    .overlay(Circle()
                                .stroke(Color.white.opacity((currentTheme == color) ? 0.9 : 0), lineWidth: 2)
                                .frame(width: 40, height: 40)
                                
                    )
                    
        })
    }
    func changeTheme(to theme: colorTheme){
        currentTheme = theme
        
    }
}
