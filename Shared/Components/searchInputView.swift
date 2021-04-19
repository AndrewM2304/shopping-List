//
//  searchInputView.swift
//  shopping List (iOS)
//
//  Created by Andrew Miller on 07/04/2021.
//

import SwiftUI



struct searchInputBox : View{
    @Binding var textField:String
    @State var search = true
    @State var label : String
    @State var keyboard = true
    var keyboardReturn: () -> Void

     @AppStorage("theme", store: UserDefaults(suiteName: "group.Andrew-Miller.shoppingList")) var currentTheme: colorTheme = .green

    var body: some View{
     
        ZStack (alignment: .leading){
            if (textField == "" ){
                Text(label)
                    .interTextStyle(text: "Inter-SemiBold", size: 15, color: Color.black.opacity(0.6))
                    .padding(.horizontal, search ? 40 : 10)
            }
            HStack (spacing: 0){
                if(search)
                {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.black).padding(.leading, 10)
                    TextField("", text: $textField)
                        .textFieldStyle(SearchTextFieldStyle())
                    Button(action: {textField = ""}, label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(currentTheme.colors.accentColor)
                            .opacity(textField != "" ? 1 : 0)
                    }).padding(.trailing, 10)
                } else {
                TextField("", text: $textField, onCommit: keyboardReturn)
                    .textFieldStyle(SearchTextFieldStyle())
                    .keyboardType( keyboard ? .default : .numberPad)
                }
            }
          
        }
        
        
        .background(Color.white)
        .cornerRadius(8)
       
        
        
        
    }

}


struct searchInputBox_Previews: PreviewProvider {
    
    @State static var text = ""
    static var previews: some View {
        searchInputBox(textField: $text, label: "hello", keyboardReturn: {})
    }
}
