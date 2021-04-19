//
//  textFieldSection.swift
//  shopping List (iOS)
//
//  Created by Andrew Miller on 06/04/2021.
//

import SwiftUI

struct textfieldSection: View {
    
    @State var sectionHeader: String
    @Binding var textField:String
    @State var keyboardType : UIKeyboardType
    @State var multiLine = false
    @State var color: Color
    var keyboardReturn: () -> Void
    
    var body: some View {
        VStack (alignment: .leading, spacing: 4){
            Text(sectionHeader).interTextStyle(text: "Inter-Medium", size: 17, color: .white)
            ZStack (alignment: .leading){
                if (textField == "" ){
                    Text("Enter \(sectionHeader)")
                        .interTextStyle(text: "Inter-SemiBold", size: 15, color: Color.black.opacity(0.6))
                        .padding(.horizontal, 10)
                }
                HStack (spacing: 0){
                    
                    TextField("", text: $textField, onCommit: keyboardReturn)
                        .textFieldStyle(SearchTextFieldStyle())
                        .disableAutocorrection(true)
                        .keyboardType( keyboardType)
                }
                HStack{
                    Spacer()
                    Image(systemName: "checkmark").foregroundColor(color).opacity(textField != "" ? 1 : 0)
                        .font(Font.body.weight(.bold))
                        .padding(.horizontal, 10)
                }
            }
            
           
            .background(Color.white)
            .cornerRadius(8)
        }
    }
}


struct textfieldSection_Previews: PreviewProvider {
    @State static var text = ""
    static var previews: some View {
        textfieldSection(sectionHeader: "this is the label", textField: $text,  keyboardType: .default, color: .green, keyboardReturn: {})
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}
