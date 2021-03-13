//
//  weightAdjustView.swift
//  shopping List (iOS)
//
//  Created by Andrew Miller on 27/01/2021.
//

import SwiftUI


struct weightAdjustView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @AppStorage("theme") var currentTheme: colorTheme = .green
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var ingredient: Ingredients
    @State var ingredQuantity = ""
    @State var shoppingItemWeight: Bool
    var body: some View {
        
        VStack {
            navBarView(curved: false)
                .overlay(
                    Text("Edit Ingredient")
                        .whiteTitleStyle()
                    
                )
                .overlay(
                    Capsule()
                        .fill(Color.white.opacity(0.6))
                        .frame(width: 30, height: 3)
                        .offset(y: -30)
                )
            
            
            VStack (alignment: .leading){
                
//                textfieldSection(sectionHeader: "Ingredient Name", textField: $ingredient.ingredientName, keyboardType: .default)
//            
                
                Section (header: Text("Quantity")
                            .font(.subheadline)
                            .foregroundColor(Color.primary)){
                    

                    HStack (spacing: 40){
                        TextField("\(ingredient.ingredientQuantity)", text: $ingredQuantity)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width:100)
                            .keyboardType(.numberPad)
                        
                        
                        Picker(selection: $ingredient.ingredientTypeNameStatus, label:
                                HStack (spacing: 10){
                                    Text(ingredient.ingredientTypeNameStatus.rawValue).foregroundColor(.primary)
                                    Image(systemName: "chevron.down").foregroundColor(currentTheme.colors.mainColor)
                                }
                                .padding(7)
                                .padding(.horizontal, 5)
                                .overlay(RoundedRectangle(cornerRadius: 4).stroke().foregroundColor(.secondary).opacity(0.5))
                               
                        ) {
                            ForEach(ingredientTypeName.allCases, id: \.self) { value in
                                Text(value.localizedName)
                                    .tag(value)
                            }
                        }.id(ingredientTypeName.allCases)
                        .pickerStyle(MenuPickerStyle())
                    }
                    .padding(.bottom, 20)
                }
                
                Button(action: {saveIngredient()}, label: {
                    Text("Save")
                })
                .buttonStyle(primaryButtonStyle())
                
                Button(action: {removeIngredient()
                    
                }, label: {
                    Text("Remove item")
                    
                })
                .buttonStyle(descructiveButtonStyle())
            }.padding()
        }
        
        Spacer()
    }
    
    func saveIngredient(){
        
        if(ingredQuantity != ""){
            let myInt1 = Int64(ingredQuantity)
            self.ingredient.ingredientQuantity = myInt1 ?? 0
        }
        
        do {
            try viewContext.save()
            presentationMode.wrappedValue.dismiss()
            
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    func removeIngredient(){
        do {
            
            ingredient.isSelected.toggle()
            try viewContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
}

//
//struct weightAdjustView_Previews: PreviewProvider {
//
//    @State static var prevDate = Date()
//    @State static var show = false
//
//    static var viewContext = PersistenceController.preview.container.viewContext
    
//    static var previews: some View {
//
//
//
//        let newIngredient = Ingredients(context: viewContext)
//        newIngredient.ingredientName = "Ing 1 very long title"
//        newIngredient.ingredientQuantity = 1
//        newIngredient.isChecked = false
//        newIngredient.isSelected = true
//        newIngredient.ingredientMeasurement = "kilo"
//
//        let newIngredient2 = Ingredients(context: viewContext)
//        newIngredient2.ingredientName = "Ing 1 very ling title"
//        newIngredient2.ingredientQuantity = 1
//        newIngredient2.isChecked = false
//        newIngredient2.isSelected = true
//        newIngredient2.ingredientMeasurement = "kilo"
//
//
//
//
//        let newDate = Dates(context:viewContext)
//        newDate.date = Date()
//        newDate.meal = Meal(context: viewContext)
//        newDate.mealTypeNameStatus = .lunch
//
//        let newMeal = Meal(context:viewContext)
//        newMeal.mealName = "burgers and chips"
//        newMeal.mealLink = "www.google.com"
//        newMeal.mealNotes = "Lorem Ipsum dolat amit this is a really long note what will it look like on the screen over 3 pages? Wow this is actually super long I need to type more"
//        newMeal.myIngredientList = [newIngredient, newIngredient2]
//        newMeal.meal = [newDate, newDate]
//
//
//
//        return weightAdjustView(ingredient: $ingredient, shoppingItemWeight: false)
//    }
//}
