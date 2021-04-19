//
//  formElements.swift
//  shopping List (iOS)
//
//  Created by Andrew Miller on 07/02/2021.
//

import SwiftUI




struct mealCardListItem : View {
    @State var image: String
    @State var title : String
    var body: some View{
        VStack (alignment: .leading){
            HStack (spacing: 5){
               Image(systemName: image)
                .font(Font.system(size: 13, weight: .bold))
                .foregroundColor(.white)
                Text(title.uppercased())
                    .interTextStyle(text: "Inter-ExtraBold", size: 12, color: .white)
            }
            Rectangle()
                            .frame(maxWidth: .infinity, maxHeight: 1)
                        .foregroundColor(Color.white.opacity(0.6))
        }
        .padding(.bottom, 5)
    }
}






