//
//  accountScreenView.swift
//  shopping List
//
//  Created by Andrew Miller on 03/01/2021.
//

import SwiftUI

struct accountScreenView: View {
    @AppStorage("theme", store: UserDefaults(suiteName: "group.Andrew-Miller.shoppingList")) var currentTheme: colorTheme = .green
    @State var themeShow = false
    @State var dataShow = false
    @State var aboutShow = false
    @State var feedbackShow = false
    
    var body: some View {
        
        ScrollView (showsIndicators: false){
            HStack{
                Spacer()
                VStack (spacing: 5){
                    HStack (alignment: .center){
                        Text("Settings")
                            .interTextStyle(text: "Inter-ExtraBold", size: 28, color: Color.white)
                        Spacer()
                        Image(systemName: "ellipsis.circle").foregroundColor(.white)
                            .padding(.vertical, 20)
                            .padding(.leading, 20)
                            .opacity(0)
                    }
                    
                }
                
                .frame(maxWidth: 600)
                
                Spacer()
            }
            .padding(.top, UIDevice.current.hasNotch ? 40 : 20)
            .padding( 10)
            .modifier(pageHeader())
            
            
            
            VStack{
                DisclosureGroup(
                    isExpanded: $themeShow,
                    content: {  themeSelectorView().padding(.vertical) },
                    label: {
                        
                        Button(action: {withAnimation{
                            self.themeShow.toggle()
                        }}, label: {
                            HStack (spacing: 15){
                                Image(systemName: "paintpalette.fill").foregroundColor(currentTheme.colors.accentColor)
                                    .frame(width: 30)
                                Text("Theme").interTextStyle(text: "Inter-ExtraBold", size: 15, color: .white)
                                Spacer()
                            }
                            .background(Color.black.opacity(0.01))
                            .padding(.vertical)
                        })
                    }
                ).accentColor(Color.white.opacity(0.6))
                Divider().background(Color.white.opacity(0.2))
                
                
                //data view
                DisclosureGroup(
                    isExpanded: $dataShow,
                    content: {  privacyPolicyView(color: currentTheme.colors.accentColor, gradient: currentTheme.colors.gradient).padding(.vertical) },
                    label: {
                        
                        Button(action: {withAnimation{
                            self.dataShow.toggle()
                        }}, label: {
                            HStack (spacing: 15){
                                Image(systemName: "person.crop.circle.fill").foregroundColor(currentTheme.colors.accentColor)
                                    .frame(width: 30)
                                Text("My Data").interTextStyle(text: "Inter-ExtraBold", size: 15, color: .white)
                                Spacer()
                            }
                            .background(Color.black.opacity(0.01))
                            .padding(.vertical)
                        })
                    }
                ).accentColor(Color.white.opacity(0.6))
                Divider().background(Color.white.opacity(0.2))
                
                
                //about
                DisclosureGroup(
                    isExpanded: $aboutShow,
                    content: {  themeSelectorView().padding(.vertical) },
                    label: {
                        
                        Button(action: {withAnimation{
                            self.aboutShow.toggle()
                        }}, label: {
                            HStack (spacing: 15){
                                Image(systemName: "info.circle.fill").foregroundColor(currentTheme.colors.accentColor)
                                    .frame(width: 30)
                                Text("About Appname").interTextStyle(text: "Inter-ExtraBold", size: 15, color: .white)
                                Spacer()
                            }
                            .background(Color.black.opacity(0.01))
                            .padding(.vertical)
                        })
                    }
                ).accentColor(Color.white.opacity(0.6))
                Divider().background(Color.white.opacity(0.2))
                
                //feedback
                DisclosureGroup(
                    isExpanded: $feedbackShow,
                    content: {  themeSelectorView().padding(.vertical) },
                    label: {
                        
                        Button(action: {withAnimation{
                            self.feedbackShow.toggle()
                        }}, label: {
                            HStack (spacing: 15){
                                Image(systemName: "quote.bubble.fill").foregroundColor(currentTheme.colors.accentColor)
                                    .frame(width: 30)
                                Text("Send Feedback").interTextStyle(text: "Inter-ExtraBold", size: 15, color: .white)
                                Spacer()
                            }
                            .background(Color.black.opacity(0.01))
                            .padding(.vertical)
                        })
                    }
                ).accentColor(Color.white.opacity(0.6))
                Divider().background(Color.white.opacity(0.2))
                
                
            }
            .padding()
            .frame(maxWidth: 600)
        }
        .background(radialBackgroundView())
        .edgesIgnoringSafeArea(.bottom)
        
    }
    
}







struct accountScreenView_Previews: PreviewProvider {
    static var previews: some View {
        accountScreenView()
    }
}

struct themeSelectorView: View {
    @AppStorage("theme", store: UserDefaults(suiteName: "group.Andrew-Miller.shoppingList")) var currentTheme: colorTheme = .green
    
    var body: some View {
        
        HStack (spacing: 20){
            ThemePickerButton(color: .green)
            ThemePickerButton(color: .orange)
            ThemePickerButton(color: .blue)
            ThemePickerButton(color: .purple)
            ThemePickerButton(color: .red)
            Spacer()
        }
        
    }
    
    
    
}



struct ThemePickerButton: View {
    @AppStorage("theme", store: UserDefaults(suiteName: "group.Andrew-Miller.shoppingList")) var currentTheme: colorTheme = .green
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
