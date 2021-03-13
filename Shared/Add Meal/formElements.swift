//
//  formElements.swift
//  shopping List (iOS)
//
//  Created by Andrew Miller on 07/02/2021.
//

import SwiftUI

struct ingredientSection: View {
    @State var viewing: Int
    var body: some View{
        VStack (alignment:.leading, spacing: 2){
            HStack {
                Text("Ingredients: ".uppercased()).foregroundColor(Color.primary)
                Text("\(viewing)").foregroundColor(Color("section")).opacity(0.01)
                Spacer()
            }
            
            Text("Selected ingredients will be added to shopping list")
                
                .foregroundColor(Color.secondary)
        }
        .padding(10)
        .font(Font.caption.weight(.medium))
        .padding(.horizontal, 5)
        .background(Color("section"))
    }
}

struct selectDatesSection : View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("theme") var currentTheme: colorTheme = .green
    @Binding var dateList : [Dates]
    @Binding var addMealCount: Int
    
    var body: some View{
        Section (header: Text("Select Dates").font(.subheadline)
                    .foregroundColor(Color.primary)){
            
            HStack {
                if(addMealCount > -1){
                Text(" \(addMealCount) dates selected").foregroundColor(.primary)
                } else{
                    Text(" \(addMealCount) dates removed").foregroundColor(.primary)
                }
                Spacer()
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(currentTheme.colors.mainColor)
            }
            .padding(.vertical, 10)
            
        }
    }
}


struct textfieldSection: View {
    @State var sectionHeader: String
    @Binding var textField:String
    @State var keyboardType : UIKeyboardType
    @State var multiLine = false
    
    var body: some View {
        Section (header: Text(sectionHeader).font(.subheadline)
                    .foregroundColor(Color.primary)){
            if(multiLine == false){
                TextField("Enter \(sectionHeader)", text: $textField)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom, 20)
                    .keyboardType(keyboardType)
            } else {
                TextEditor(text: $textField)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8).stroke((Color.primary).opacity(0.1), lineWidth: 1.0)
                    )
                    .frame(height:80)
                    .padding(.bottom, 20)
            }
        }
    }
}

struct ingredientInput : View{
    @Binding var textField:String
    var buttonAction: () -> Void
    var keyboardReturn: () -> Void
    @AppStorage("theme") var currentTheme: colorTheme = .green

    var body: some View{
        HStack {
            TextField("Add Ingredient", text: $textField, onCommit: keyboardReturn)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onTapGesture {
    //                        self.showKeyboard = true
                }
            if let buttonAction = self.buttonAction {
            Button(action: {
                withAnimation{
                    buttonAction()
                }
            }, label: {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(currentTheme.colors.mainColor)
                    .padding(20)
            })
            }
        }
    }

}
