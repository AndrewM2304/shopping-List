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
    @State var offset = (0 - UIScreen.main.bounds.width / 3)
    @AppStorage("theme") var currentTheme: colorTheme = .green
    var body: some View {

        VStack {
            HStack {
                VStack {
                    CustomShape()
                        .frame(width: 50, height: 5)
                        .foregroundColor(currentTheme.colors.mainColor)
                }
                .padding(.bottom, 5)
                .frame(width: UIScreen.main.bounds.width / 3)
            }
            .offset(x:offset).animation(.default)
            
            
            
            HStack (spacing: 0){
                Button(action: {togglePlanner()}, label: {
                    
                    Image(systemName: "calendar")
                        
                        .font(.title2)
                        .foregroundColor(plannerActive ? currentTheme.colors.mainColor : Color.primary.opacity(0.5))
                        .frame(width: UIScreen.main.bounds.width / 3, height:25)
                })
                Button(action: {toggleList()}, label: {
                    Image(systemName: "list.bullet")
                        .font(.title2)
                        .foregroundColor(listActive ? currentTheme.colors.mainColor : Color.primary.opacity(0.5))
                        .frame(width: UIScreen.main.bounds.width / 3, height:25)
                    
                })
                Button(action: {toggleAccount()}, label: {
                    Image(systemName: "person.circle")
                        .frame(width: 50)
                        .font(.title2)
                        .foregroundColor(accountActive ? currentTheme.colors.mainColor : Color.primary.opacity(0.5))
                        .frame(width: UIScreen.main.bounds.width / 3, height:25)
                    
                }
                )
            }
            .frame(width: UIScreen.main.bounds.width)
        }
        .padding(.bottom, 40)
        .background(Color("CardBackground"))
        .clipped()
        .shadow(color: Color("shadow").opacity(0.1), radius: 16, x: 0.0, y: -4)
        .shadow(color: Color(.black).opacity(0.10), radius:0, y: -1)
        
        
        
    }
    func togglePlanner() {
        plannerActive = true
        listActive = false
        accountActive = false
        offset = (0 - UIScreen.main.bounds.width / 3)
    }
    
    func toggleList() {
        plannerActive = false
        listActive = true
        accountActive = false
        offset = 0
    }
    
    func toggleAccount() {
        plannerActive = false
        listActive = false
        accountActive = true
        
        offset = (0 + UIScreen.main.bounds.width / 3)
    }
    
    
}


struct tabBarView_Previews: PreviewProvider {
    @State static var planShow = true
    @State static var listShow = false
    @State static var accountShow = false
    static var previews: some View {
        tabBarView(plannerActive: $planShow, listActive: $listShow, accountActive: $accountShow)
    }
}


// Custom Shape..

struct CustomShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomLeft,.bottomRight], cornerRadii: CGSize(width: 10, height: 10))
        
        return Path(path.cgPath)
    }
}
