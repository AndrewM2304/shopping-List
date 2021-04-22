//
//  notesSection.swift
//  shopping List (iOS)
//
//  Created by Andrew Miller on 21/04/2021.
//

import SwiftUI

struct notesSection: View {
    init(sectionHeader: String, textField: Binding<String>, color: Color) {
            UITextView.appearance().backgroundColor = .clear
        self.sectionHeader = sectionHeader
        _textField = textField
        self.color = color
        }
    
    var sectionHeader :String
    @Binding var textField:String
      var color: Color
    
    
    var body: some View {
        VStack (alignment: .leading, spacing: 4){
            Text(sectionHeader).interTextStyle(text: "Inter-Medium", size: 17, color: .white)
            ZStack (alignment: .topLeading){
                if (textField == "" ){
                    Text("Enter \(sectionHeader)")
                        .interTextStyle(text: "Inter-SemiBold", size: 15, color: Color.black.opacity(0.6))
                        .padding(.vertical, 18)
                        .padding(.horizontal, 15)
                }
                HStack (spacing: 0){
                    
                    TextEditor(text: $textField)
                        .frame(height: 150)
                        .padding(10)
                        .font(.custom("Inter-Medium", size: 15))
                        .background(Color.clear)
                        .foregroundColor(.black)
                        .cornerRadius(4)
                        
                }
            }
            
           
            .background(Color.white)
            .cornerRadius(8)
        }
    }

    
}



struct notesSection_Previews: PreviewProvider {
    @State static var field = ""
    static var previews: some View {
        notesSection(sectionHeader: "hello worldes", textField: $field, color: .white ).preferredColorScheme(.dark)
    }
}
