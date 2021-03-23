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
                Button(action: {changeTheme(to: .green)}, label: {
                    
                    if(currentTheme.colors.mainColor == Color("accentGreen")){
                        Circle()
                            .fill(Color("accentGreen"))
                            .frame(width:40, height:40)
                            .overlay(Circle()
                                        .stroke(Color.white, lineWidth: 3)
                                        .frame(width: 38, height: 38))
                            .overlay(Circle()
                                        .stroke(Color.primary, lineWidth: 2)
                                        .frame(width: 40, height: 40))
                    } else {
                        Circle()
                            .frame(width:40, height:40)
                    }
                })
                
                //orange
                Button(action: {changeTheme(to: .orange)}, label: {
                    
                    if(currentTheme.colors.mainColor == Color("accentOrange")){
                        Circle()
                            .fill(Color("accentOrange"))
                            .frame(width:40, height:40)
                            .overlay(Circle()
                                        .stroke(Color.white, lineWidth: 3)
                                        .frame(width: 38, height: 38))
                            .overlay(Circle()
                                        .stroke(Color.primary, lineWidth: 2)
                                        .frame(width: 40, height: 40))
                    } else {
                        Circle()
                            .fill(Color("accentOrange"))
                            .frame(width:40, height:40)
                    }
                })
                
                //pink
                Button(action: {changeTheme(to: .pink)}, label: {
                    
                    if(currentTheme.colors.mainColor == Color("accentPink")){
                        Circle()
                            .fill(Color("accentPink"))
                            .frame(width:40, height:40)
                            .overlay(Circle()
                                        .stroke(Color.white, lineWidth: 3)
                                        .frame(width: 38, height: 38))
                            .overlay(Circle()
                                        .stroke(Color.primary, lineWidth: 2)
                                        .frame(width: 40, height: 40))
                    } else {
                        Circle()
                            .fill(Color("accentPink"))
                            .frame(width:40, height:40)
                    }
                })
                
                
                //pink
                Button(action: {changeTheme(to: .purple)}, label: {
                    
                    if(currentTheme.colors.mainColor == Color("accentPurple")){
                        Circle()
                            .fill(Color("accentPurple"))
                            .frame(width:40, height:40)
                            .overlay(Circle()
                                        .stroke(Color.white, lineWidth: 3)
                                        .frame(width: 38, height: 38))
                            .overlay(Circle()
                                        .stroke(Color.primary, lineWidth: 2)
                                        .frame(width: 40, height: 40))
                    } else {
                        Circle()
                            .fill(Color("accentPurple"))
                            .frame(width:40, height:40)
                    }
                })
                
            }
        }
        
    }
    func changeTheme(to theme: colorTheme){
        currentTheme = theme
        
    }
}
