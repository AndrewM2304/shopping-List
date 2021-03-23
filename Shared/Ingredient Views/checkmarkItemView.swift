//
//  checkmarkItemView.swift
//  shopping List (iOS)
//
//  Created by Andrew Miller on 20/01/2021.
//





import SwiftUI

struct checkmarkItemView: View {
    @AppStorage("theme") var currentTheme: colorTheme = .green
    @ObservedObject var addIngredient = addMealViewModel()
    @ObservedObject var addIngredientVM = addIngredientViewModel()
    @Environment(\.managedObjectContext) private var viewContext

    
    var shoppingListItem : Bool
    @State var ingredient: Ingredients!
    var buttonAction: () -> Void
    var popupAction: () -> Void
    @State private var text = ""
    @State var showWeights = true
    @State var viewing: Int
    @State var enumIt : ingredientTypeName = .items

    @Namespace private var animation
  

    
    var body: some View {
        VStack (spacing: 0){
            
            ZStack (alignment: .topLeading){
                Rectangle().foregroundColor(currentTheme.colors.mainColor)
                    .opacity( showWeights ? 0 : 1)
                    .zIndex(2)
                    
                    .frame(width:4, height:  showWeights ? 0 : 100)
                    
            HStack (alignment: .top){
                Button(action: {
                        buttonAction()}
                       , label: {
                        HStack{
                            
                            if(shoppingListItem == false){
                                Image(systemName: ingredient.isSelected ? "checkmark.square.fill" : "square")
                                    .padding(.horizontal, 10)
                                    .foregroundColor(ingredient.isSelected ? currentTheme.colors.mainColor : Color(.white).opacity(0.6))
                            } else {
                                Image(systemName: ingredient.isChecked ? "largecircle.fill.circle" : "circle")
                                    .padding(.horizontal, 10)
                                    .foregroundColor(ingredient.isChecked ? currentTheme.colors.mainColor : Color(.white).opacity(0.6))
                            }
                            VStack (alignment: .leading, spacing: 3) {
                                Text(ingredient.ingredientName ?? "no ingredient Name")
                                    .foregroundColor(Color.white)
                                    .strikethrough(color: ingredient.isChecked ? Color.white : Color.clear)
                                    .primaryTextStyle()
                                
                                HStack (spacing: 5){
                                    Text("Quantity: \(ingredient.ingredientQuantity)")
                                        .interTextStyle(text: "Inter-Medium", size: 15, color: Color.white.opacity(0.6))
                                    if(ingredient.ingredientMeasurement != "Items"){
                                        Text(ingredient.ingredientMeasurement ?? "")
                                            .interTextStyle(text: "Inter-Medium", size: 15, color: Color.white.opacity(0.6))
                                    }
                                    Text("\(viewing)").opacity(0).font(Font.caption)
                                }
                            }
                           
                            Spacer()
                        }
                        .background(Color(#colorLiteral(red: 0.03921568627, green: 0.0431372549, blue: 0.04705882353, alpha: 1)).opacity(0.01))
                        
                       })
                
                Button(action: {
                    withAnimation{
                    
                        self.showWeights.toggle()
                    }
                }, label: {
                    Image(systemName: "chevron.down")
                        
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color.white.opacity(0.6))
                        .rotation3DEffect(Angle(degrees: showWeights ? 0 : 180), axis: (x: 10.0, y: 0.0, z: 0.0))
                    
                })
            }
            
            .padding(.horizontal, 15)
            .frame(height: 50)
            
            .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
            
        HStack (spacing: 15){
            TextField("\(ingredient.ingredientQuantity)", text: $text, onCommit: {viewing += 1})
                .textFieldStyle(RoundedBorderTextFieldStyle())

                .keyboardType(.numberPad)
                .frame(width: 50)
            Picker(selection: $enumIt, label:
                    HStack (spacing: 10){
                        Text(enumIt.localizedName)
                            .interTextStyle(text: "Inter-Medium", size: 15, color: Color.white.opacity(0.15))
                        Image(systemName: "chevron.down").foregroundColor(currentTheme.colors.mainColor)
                    }

                    .padding(8)
                    .cornerRadius(4)
                    .overlay(RoundedRectangle(cornerRadius: 4).stroke().foregroundColor(.white).opacity(0.5))

            ) {
                ForEach(ingredientTypeName.allCases, id: \.id) { value in
                    Text(value.localizedName)
                        .tag(value.rawValue)
                }
            }
            .pickerStyle(MenuPickerStyle())
            Button(action: {
                withAnimation{
                    saveIngredient();
                    viewing += 1 ;
                    self.showWeights.toggle()
                    popupAction()
                }
                
            }, label: {
                Text("Save")
                    .padding(.horizontal, 10)
            })
            .buttonStyle(primaryButtonStyle(gradient: currentTheme.colors.gradient))
            Spacer()
            
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 7)
        .padding(.leading, 45)
        
        .background(Color(#colorLiteral(red: 0.1411764706, green: 0.1647058824, blue: 0.2, alpha: 1)))
        .opacity( showWeights ? 0 : 1)
        .offset(y: showWeights ? 0 : 60)
        
        }

            
        }.frame(height: showWeights ? 60 : 100)
   
    }
    
    
    func saveIngredient(){
        viewing += 1
        if(text != ""){
            let myInt1 = Int64(text)
            self.ingredient.ingredientQuantity = myInt1 ?? 0
        }
        
        let newValue = enumIt.rawValue
        self.ingredient.ingredientMeasurement = newValue
//        do {
//            try viewContext.save()
//            print("saved")
//        } catch {
//            // Replace this implementation with code to handle the error appropriately.
//            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//            let nsError = error as NSError
//            
//            print(nsError)
//        }
    }

}




struct checkmarkItemView_Previews: PreviewProvider {
    @State static var prevDate = Date()
    @State static var show = false
    @State static var viewing = 0
  
    
    static var viewContext = PersistenceController.preview.container.viewContext
    
    static var previews: some View {
        
        let newIngredient = Ingredients(context: viewContext)
        newIngredient.ingredientName = "Ing 1 very long title"
        newIngredient.ingredientQuantity = 1
        newIngredient.isChecked = false
        newIngredient.isSelected = true
        newIngredient.ingredientMeasurement = "kilo"
        
        return checkmarkItemView(shoppingListItem: true, ingredient: newIngredient, buttonAction: {}, popupAction: {}, viewing: viewing)
            .preferredColorScheme(.light)
            .background(radialBackgroundView())
        
    }
    
}



