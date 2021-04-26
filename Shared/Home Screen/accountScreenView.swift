//
//  accountScreenView.swift
//  shopping List
//
//  Created by Andrew Miller on 03/01/2021.
//

import SwiftUI
import StoreKit

struct accountScreenView: View {
    @AppStorage("theme", store: UserDefaults(suiteName: "group.Andrew-Miller.shoppingList")) var currentTheme: colorTheme = .green
    @Binding var onboarding: Bool
    @State var themeShow = false
    @State var dataShow = false
    @State var aboutShow = false
    @State var feedbackShow = false
    @State var int = 0
    
    
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
                    content: {  themeSelectorView( int: $int).padding(.vertical) },
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
                

                
                
                //rate
                Button(action: {withAnimation{
                    requestReview()
                }}, label: {
                    HStack (spacing: 15){
                        Image(systemName: "heart.fill").foregroundColor(currentTheme.colors.accentColor)
                            .frame(width: 30)
                        Text("Rate on the App Store").interTextStyle(text: "Inter-ExtraBold", size: 15, color: .white)
                        Spacer()
                    }
                    .background(Color.black.opacity(0.01))
                    .padding(.vertical)
                })
                
            }
            .padding()
            .frame(maxWidth: 600)
        }
        .background(radialBackgroundView())
        .edgesIgnoringSafeArea(.bottom)
        
    }
    func requestReview() {
        if let scene = UIApplication.shared.currentScene {
            SKStoreReviewController.requestReview(in: scene)
        }
       }
    

    
}







struct accountScreenView_Previews: PreviewProvider {
    @State static var onboarding =  false
    static var previews: some View {
        accountScreenView(onboarding: $onboarding)
    }
}

struct themeSelectorView: View {
    @AppStorage("theme", store: UserDefaults(suiteName: "group.Andrew-Miller.shoppingList")) var currentTheme: colorTheme = .green
    @Binding var int: Int
    var body: some View {
        
        HStack{
            
           
            ThemePickerButton(color: .green, int: $int)
            Spacer()
            ThemePickerButton(color: .orange, int: $int)
            Spacer()
            ThemePickerButton(color: .blue, int: $int)
            Spacer()
            ThemePickerButton(color: .purple, int: $int)
            Spacer()
            ThemePickerButton(color: .red, int: $int)
        }
        .padding(.horizontal)
        
    }
    
    
    
}



struct ThemePickerButton: View {
    @AppStorage("theme", store: UserDefaults(suiteName: "group.Andrew-Miller.shoppingList")) var currentTheme: colorTheme = .green
    var color: colorTheme
    @Binding var int: Int
    var body: some View {
        Button(action: {changeTheme(to: color, int: int)}, label: {
            
            
            Circle()
                .fill(color.colors.accentColor)
                .frame(width:40, height:40)
                
                .overlay(Circle()
                            .stroke(Color.white.opacity((currentTheme == color) ? 0.9 : 0), lineWidth: 2)
                            .frame(width: 40, height: 40)
                         
                )
            
        })
    }
    func changeTheme(to theme: colorTheme, int: Int){
        currentTheme = theme
        self.int += 1
    }
}
