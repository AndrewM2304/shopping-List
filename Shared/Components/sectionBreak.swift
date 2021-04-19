//
//  sectionBreak.swift
//  shopping List (iOS)
//
//  Created by Andrew Miller on 06/04/2021.
//

import SwiftUI

struct sectionBreak: View {
    
    @State var viewing: Int
    @State var mainText : String
    @State var secondaryText : String
    @State var multiText = false

           
            var body: some View{
                VStack (alignment:.leading, spacing: 0){
                    Rectangle().foregroundColor(Color.white.opacity(0.2))
                        .frame(height:1)
                    VStack (alignment:.leading, spacing: 2){
                    HStack {
                        Text(mainText.uppercased())
                            .interTextStyle(text: "Inter-ExtraBold", size: 13, color: Color.white)
                        Text("\(viewing)").foregroundColor(Color("section")).opacity(0.01)
                        Spacer()
                    }
                    if(multiText == true){
                    Text(secondaryText)
                    
                        .interTextStyle(text: "Inter-SemiBold", size: 12, color: Color.white.opacity(0.6))
                    }
                    
                }
                .padding(10)
                
                
                    
                .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1215686275, green: 0.1490196078, blue: 0.168627451, alpha: 1)), Color(#colorLiteral(red: 0.07058823529, green: 0.1137254902, blue: 0.137254902, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    Rectangle().foregroundColor(Color.white.opacity(0.2))
                        .frame(height:1)
                }
            }
        }


struct sectionBreak_Previews: PreviewProvider {
    static var previews: some View {
        sectionBreak(viewing: 1, mainText: "hello", secondaryText: "description in here", multiText: true)
    }
}
