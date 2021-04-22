//
//  onboardingView.swift
//  shopping List (iOS)
//
//  Created by Andrew Miller on 20/04/2021.
//

import SwiftUI

struct onboardingView: View {
    @State var image: String
    @State var pageTitle: String
    @State var subheading: String
    @State var themeprovider: Bool = false
    @State var final: Bool = false
    @State var colorChange: String = "Green Home"
    @State var int: Int = 0
    @AppStorage("theme", store: UserDefaults(suiteName: "group.Andrew-Miller.shoppingList")) var currentTheme: colorTheme = .green
    @AppStorage("onboarding", store: UserDefaults(suiteName: "group.Andrew-Miller.shoppingList")) var onboarding = true
    var body: some View {
        
        GeometryReader{ geo in

                Spacer()
            VStack (alignment: .center){
                Spacer()
                if(themeprovider == false){
                    Image(image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: geo.size.height / 2.2)
                } else{
                    imageShow(theme: themeprovider, height: geo, colorTheme: .green, colorChange: colorChange)
                }
                
                
                VStack (spacing: 20){
                Text(pageTitle).interTextStyle(text: "Inter-ExtraBold", size: 30, color: .white)
                    .multilineTextAlignment(.center)
                    Text(subheading).interTextStyle(text: "Inter-SemiBold", size: 20, color: Color.white.opacity(0.8))
                    .multilineTextAlignment(.center)
                }.padding()
                if(themeprovider){
                   
                    themeSelectorView( int: $int).padding(.leading, 50)
                    Text("\(int)").opacity(0.01)
                    Button(action: {onboarding.toggle() }, label: {
                        Text("Get Started")
                            .interTextStyle(text: "Inter-ExtraBold", size: 17, color: Color.white)
                            .frame(maxWidth: .infinity)
                            .padding(15)
                    })
                    
                    .buttonStyle(primaryButtonStyle(gradient: currentTheme.colors.gradient))
                    .padding()
                    
                   
                   
                }
                Spacer()
                Spacer()
            }.frame(maxWidth: .infinity, maxHeight:.infinity)
               

        }
        
        .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1450980392, green: 0.1882352941, blue: 0.2196078431, alpha: 1)), Color(#colorLiteral(red: 0.07450980392, green: 0.1137254902, blue: 0.137254902, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .edgesIgnoringSafeArea(.all)
        
    }
    
//    func imageShow(theme: Bool, height: GeometryProxy, colorTheme: colorTheme) -> some View {
//        if(theme == false){
//            return AnyView(
//                Image(image)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(height: height.size.height / 2.2)
//            )
//        } else{
//
//               switch currentTheme{
//               case .green :
//                return AnyView(
//                    Image(colorChange)
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(height: height.size.height / 2.2))
//               case .blue:
//               return  AnyView(
//                Image("Blue Home")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(height: height.size.height / 2.2))
//               case .red:
//               return  AnyView(
//                Image("Red Home")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(height: height.size.height / 2.2))
//               case .orange:
//               return  AnyView(
//                Image("Orange Home")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(height: height.size.height / 2.2))
//               case .purple:
//                return  AnyView(
//                    Image("Purple Home")
//                         .resizable()
//                         .aspectRatio(contentMode: .fit)
//                         .frame(height: height.size.height / 2.2))
//               }
//           }
//
//
//        }
    
    func imageShow(theme: Bool, height: GeometryProxy, colorTheme: colorTheme, colorChange: String) -> some View {

               switch currentTheme{
               case .green : self.colorChange = "Green Home";
                
                
               case .blue: self.colorChange = "Blue Home";
               
               
               case .red: self.colorChange = "Red Home";
               
              
               case .orange: self.colorChange = "Orange Home";
               
               
               case .purple: self.colorChange = "Purple Home";
               
                
               }
           
        return  AnyView(
         Image(colorChange)
                 .resizable()
                 .aspectRatio(contentMode: .fit)
                 .frame(height: height.size.height / 2.2))
           
        }
        
    
}

struct onboardingView_Previews: PreviewProvider {
    static var previews: some View {
        onboardingView(image: "Green Home", pageTitle: "Welcome to Get Prepped", subheading: "Meal planning made simple", themeprovider: true)
    }
}
