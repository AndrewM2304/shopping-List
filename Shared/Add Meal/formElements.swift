//
//  formElements.swift
//  shopping List (iOS)
//
//  Created by Andrew Miller on 07/02/2021.
//

import SwiftUI

struct sectionBreak: View {
    @State var viewing: Int
    @State var mainText : String
    @State var secondaryText : String
    @State var multiText = false
    var body: some View{
        VStack (alignment:.leading, spacing: 2){
            HStack {
                Text(mainText.uppercased())
                    .interTextStyle(text: "Inter-ExtraBold", size: 12, color: Color.white)
                Text("\(viewing)").foregroundColor(Color("section")).opacity(0.01)
                Spacer()
            }
            if(multiText == true){
            Text(secondaryText)
            
                .interTextStyle(text: "Inter-SemiBold", size: 10, color: Color.white.opacity(0.6))
            }
        }
        .padding(10)
        
        .padding(.horizontal, 5)
        .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1215686275, green: 0.1490196078, blue: 0.168627451, alpha: 1)), Color(#colorLiteral(red: 0.07058823529, green: 0.1137254902, blue: 0.137254902, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .border(Color.white.opacity(0.1))
    }
}


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
                .frame(width: .infinity, height: 1)
            .foregroundColor(Color.white.opacity(0.4))
        }
    }
}



struct textfieldSection: View {
    @State var sectionHeader: String
    @Binding var textField:String
    @State var keyboardType : UIKeyboardType
    @State var multiLine = false
    @State var gradient: LinearGradient
    
    var body: some View {
        Section (header: Text(sectionHeader)
                    .interTextStyle(text: "Inter-Medium", size: 15, color: Color.white)
                    ){
            if(multiLine == false){
                ZStack (alignment: .leading){
                    if (textField == "" ){
                        Text("Enter \(sectionHeader)")
                            .interTextStyle(text: "Inter-Medium", size: 15, color: Color.white.opacity(0.4))
                            .padding(.horizontal, 10)
                    }
                   
                TextField("",text: $textField)
                    .textFieldStyle(CustomTextFieldStyle())
                   
                    
                        RoundedRectangle(cornerRadius: 4, style: .continuous)
                            .stroke(gradient, lineWidth: 1)
                            .opacity( textField == "" ? 0 : 1)
                        
                    
                    .keyboardType(keyboardType)
                }
                .background(Color(#colorLiteral(red: 0.05490196078, green: 0.06274509804, blue: 0.07058823529, alpha: 1)))
                .padding(.bottom, 20)
            } else {
                TextEditor(text: $textField)
                    .textFieldStyle(CustomTextFieldStyle())
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
    var onTap: () -> Void
    @AppStorage("theme") var currentTheme: colorTheme = .green

    var body: some View{
        HStack (spacing: 0) {
            ZStack (alignment: .leading){
                if (textField == "" ){
                    Text("Enter Ingredient")
                        .interTextStyle(text: "Inter-Medium", size: 15, color: Color.white.opacity(0.4))
                        .padding(.horizontal, 10)
                }
               
            TextField("",text: $textField)
                .textFieldStyle(CustomTextFieldStyle())
               
                
                    RoundedRectangle(cornerRadius: 4, style: .continuous)
                        .stroke(currentTheme.colors.gradient, lineWidth: 1)
                        .opacity( textField == "" ? 0 : 1)
            }.background(Color(#colorLiteral(red: 0.05490196078, green: 0.06274509804, blue: 0.07058823529, alpha: 1)))
                
            if let buttonAction = self.buttonAction {
            Button(action: {
                withAnimation{
                    buttonAction()
                }
            }, label: {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(currentTheme.colors.mainColor)
                    .padding(.leading, 20)
            })
            }
        }
        .onTapGesture {
            withAnimation{
                onTap()
            }
        }
    }

}


struct textfieldSection_Previews: PreviewProvider {
    @State static var text = ""
    @State static var heading = "hi andrew"
    
    static var previews: some View {
        
        ingredientInput(textField: $text, buttonAction: {}, keyboardReturn: {}, onTap: {})
    }
}
