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
                                    .foregroundColor(ingredient.isSelected ? currentTheme.colors.mainColor : .primary)
                            } else {
                                Image(systemName: ingredient.isChecked ? "largecircle.fill.circle" : "circle")
                                    .padding(.horizontal, 10)
                                    .foregroundColor(ingredient.isChecked ? currentTheme.colors.mainColor : .primary)
                            }
                            VStack (alignment: .leading, spacing: 3) {
                                Text(ingredient.ingredientName ?? "no ingredient Name").strikethrough(color: ingredient.isChecked ? Color.primary : Color.clear)
                                    .primaryTextStyle()
                                
                                HStack (spacing: 2){
                                    Text("Quantity: \(ingredient.ingredientQuantity)").secondaryTextStyle()
                                    if(ingredient.ingredientMeasurement != "Items"){
                                        Text(ingredient.ingredientMeasurement ?? "").secondaryTextStyle()
                                    }
                                    Text("\(viewing)").opacity(0).font(Font.caption)
                                }
                            }
                           
                            Spacer()
                        }
                        .background(Color.white.opacity(0.01))})
                
                Button(action: {
                    withAnimation{
                    
                        self.showWeights.toggle()
                    }
                }, label: {
                    Image(systemName: "chevron.down")
                        
                        .frame(width: 30, height: 30)
                        .foregroundColor(.secondary)
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
                        Text(enumIt.localizedName).foregroundColor(.primary)
                        Image(systemName: "chevron.down").foregroundColor(currentTheme.colors.mainColor)
                    }

                    .padding(7)
                    .padding(.horizontal, 5)
                    
                    .cornerRadius(4)
                    .overlay(RoundedRectangle(cornerRadius: 4).stroke().foregroundColor(.secondary).opacity(0.5))

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
                    .font(Font.subheadline.bold())
                    .padding(8)
                    .padding(.horizontal, 10)
                    .foregroundColor(.white)
                    .background(currentTheme.colors.mainColor)
                    .cornerRadius(4)
            })
            Spacer()
            
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 7)
        .padding(.leading, 45)
        
        .background(Color.primary.opacity(0.05))
        .opacity( showWeights ? 0 : 1)
        .offset(y: showWeights ? 0 : 50)
        
        }

            
        }.frame(height: showWeights ? 50 : 100)
        

       

        
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
        
        return checkmarkItemView(shoppingListItem: false, ingredient: newIngredient, buttonAction: {}, popupAction: {}, viewing: viewing)
            .preferredColorScheme(.dark)
        
    }
    
}



