//
//  tabBarView.swift
//  shopping List
//
//  Created by Andrew Miller on 30/12/2020.
//

import SwiftUI

struct tabBarView: View {
    
    @Binding var plannerActive: Bool
    @Binding var listActive: Bool
    @Binding var accountActive: Bool
    @AppStorage("theme") var currentTheme: colorTheme = .green
    var geo : CGFloat
    var body: some View {

        VStack {
            HStack {
                VStack {
                    CustomShape()
                        .fill(currentTheme.colors.gradient)
                        .frame(width: 50, height: 5)
                        
                        
                }
                .padding(.bottom, 5)
                .frame(width: geo / 3)
            }
            .offset(x:offsetter(geo: geo)).animation(.default)
            
            
            
            HStack (spacing: 0){
                Button(action: {togglePlanner()}, label: {
                    
                    Image(systemName: "calendar")
                        
                        .font(.title2)
                        .foregroundColor(plannerActive ? currentTheme.colors.accentColor : Color.white.opacity(0.5))
                        
                        .frame(width: geo / 3, height:25)
                        
                })
                Button(action: {toggleList()}, label: {
                    Image(systemName: "list.bullet")
                        .font(.title2)
                        .foregroundColor(listActive ? currentTheme.colors.accentColor : Color.white.opacity(0.5))
                        .frame(width: geo / 3, height:25)
                    
                })
                Button(action: {toggleAccount()}, label: {
                    Image(systemName: "person.circle")
                        .frame(width: 50)
                        .font(.title2)
                        .foregroundColor(accountActive ? currentTheme.colors.accentColor : Color.white.opacity(0.5))
                        .frame(width: geo / 3, height:25)
                    
                }
                )
            }
            .frame(width: geo)
        }
        .padding(.bottom, UIDevice.current.hasNotch ? 40 : 20)
        .background(Color(#colorLiteral(red: 0.1019607843, green: 0.1176470588, blue: 0.1411764706, alpha: 1)))
        .clipped()
        .shadow(color: Color("shadow").opacity(0.1), radius: 16, x: 0.0, y: -4)
        .shadow(color: Color(.black).opacity(0.10), radius:0, y: -1)

        
        
    }
    func togglePlanner() {
        plannerActive = true
        listActive = false
        accountActive = false
       
    }
    
    func toggleList() {
        plannerActive = false
        listActive = true
        accountActive = false
       
    }
    
    func toggleAccount() {
        plannerActive = false
        listActive = false
        accountActive = true
        
       
    }
    
    func offsetter (geo: CGFloat) -> CGFloat{
        var offset : CGFloat = 0
        
        if plannerActive{
            offset =  (offset  - geo / 3)
        } else if listActive{
            offset = 0
        } else if accountActive{
            offset = (offset  + geo / 3)
        }
        return offset
    }
   
    
}


struct tabBarView_Previews: PreviewProvider {
    @State static var planShow = true
    @State static var listShow = false
    @State static var geo = 330
    @State static var accountShow = false
    static var previews: some View {
        tabBarView(plannerActive: $planShow, listActive: $listShow, accountActive: $accountShow, geo: CGFloat(geo))
    }
}


// Custom Shape..

struct CustomShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomLeft,.bottomRight], cornerRadii: CGSize(width: 10, height: 10))
        
        return Path(path.cgPath)
    }
}
