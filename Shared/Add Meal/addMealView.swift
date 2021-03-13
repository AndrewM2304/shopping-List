//
//  addMealView.swift
//  shopping List (iOS)
//
//  Created by Andrew Miller on 07/02/2021.
//

import SwiftUI

struct addMealView: View {
    
    @ObservedObject private var keyboard = KeyboardResponder()
    @ObservedObject var addMealObject = addMealViewModel()
    @ObservedObject var addIngredientObject = addIngredientViewModel()
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    

    @State var UpdateUI = 0
    @State var showKeyboard = true
    @State var addMealCount = 0
@State var showOverlay = false
    @State var mealNameText = ""
    @State var mealLinkText = ""
    @State var mealNotesText = ""
    @State var ingredientName = ""
    @State var dateArray = [Dates]()
    @State var ingredientArray = [Ingredients]()
    
    init(mealObject: Meal? = nil){

        addMealObject.mealObject = mealObject
        addMealObject.mealName = mealObject?.mealName ?? mealNameText
        addMealObject.mealUrl = mealObject?.mealLink ?? mealLinkText
        addMealObject.mealNotes = mealObject?.mealNotes ?? mealNotesText
        addMealObject.ingredientList = mealObject?.ingredientArray ?? [Ingredients]()
        addMealObject.dateList = mealObject?.dateArray ?? [Dates]()
        
//        addIngredientObject.ingredientObject = ingredientObject
//        addIngredientObject.ingredientName = ingredientObject?.ingredientName ?? ""
//        addIngredientObject.ingredientQuantity = ingredientObject?.ingredientQuantity ?? 1
//        addIngredientObject.enumSwitch = ingredientObject?.ingredientTypeNameStatus ?? .items
//        addIngredientObject.selectedIngredient = Ingredients(context: managedObjectContext) 
    
    }
    
    
    var body: some View {
        ScrollView {
            VStack (spacing: 0){
            VStack(alignment: .leading, spacing: 0){
                VStack (alignment: .leading, spacing: 5){
                    textfieldSection(sectionHeader: "Meal Name", textField: $mealNameText, keyboardType: .default)
                    textfieldSection(sectionHeader: "Link to Recipe", textField: $mealLinkText, keyboardType: .URL)
                    textfieldSection(sectionHeader: "Notes about meal", textField: $mealNotesText, keyboardType: .default, multiLine: true)
                    addDateView(addDate: addMealObject)
                }
                .padding()
                
                
                ingredientSection(viewing: UpdateUI)
                ingredientListView(arrayName: $addMealObject.ingredientList, shoppingListItem: false, viewing: $UpdateUI, selectedIngredient: $addIngredientObject.selectedIngredient, showOverlay: $showOverlay)
            }
            .padding(.bottom, 10)
               
            
            ingredientInput(textField: $ingredientName,buttonAction:{addItem()}, keyboardReturn:{
                addItem()
                self.showKeyboard = false
                
            })
            .onTapGesture {
                self.showKeyboard = true
            }
//            .padding(.leading)

//            .sheet(isPresented: $showOverlay, content: {
////                weightAdjustView(ingredient: addMealObject.selectedIngredient, shoppingItemWeight: false)
//                Text(addMealObject.selectedIngredient.ingredientName ?? "help")
//
//            })
                Button(action: {addMealObject.saveMeal(managedObjectContext: viewContext, myMealName: mealNameText);self.presentationMode.wrappedValue.dismiss()}, label: {
                Text("save")
            })
            .buttonStyle(primaryButtonStyle()).padding()
                .padding(.bottom, 40)
            }
            .offset(y: showKeyboard ? -(CGFloat(addMealObject.ingredientList.count) * 60) : 0)
            
            .alert(isPresented: $addMealObject.showAlert,
                   content: { Alert(title: Text("error"), message: Text(addMealObject.alertMsg), dismissButton: .default(Text("OK"))) })
        }
        
        .onAppear{
            self.showKeyboard = false
            self.mealNameText = addMealObject.mealName
            self.mealNotesText = addMealObject.mealNotes
            self.mealLinkText = addMealObject.mealUrl
        }
        .dismissKeyboardOnTap()
        .padding(.bottom, keyboard.currentHeight + 15)
        .animation(.default)
        
    }
    
    
    
    func addItem() {
        withAnimation{
        self.addMealObject.addIngredients( managedObjectContext: self.viewContext, myIngredientName: self.ingredientName, myarray: self.addMealObject.ingredientList)
                        self.ingredientName = ""
        }
        

    }
}

struct addMealView_Previews: PreviewProvider {
    
    static var viewContext = PersistenceController.preview.container.viewContext
    
    static var previews: some View {
        
        let newIngredient = Ingredients(context: viewContext)
        newIngredient.ingredientName = "Ing 1"
        newIngredient.ingredientQuantity = 1
        newIngredient.isChecked = false
        newIngredient.isSelected = true
        newIngredient.ingredientMeasurement = "kilo"
        
        
        let newDate = Dates(context:viewContext)
        newDate.date = Date()
        newDate.meal = Meal(context: viewContext)
        newDate.mealTypeNameStatus = .lunch
        
        let newMeal = Meal(context:viewContext)
        newMeal.mealName = "burgers and chips"
        newMeal.mealLink = "www.google.com"
        newMeal.mealNotes = "Lorem Ipsum dolat amit this is a really long note what will it look like on the screen over 3 pages? Wow this is actually super long I need to type more"
        newMeal.myIngredientList = [newIngredient]
        newMeal.meal = [newDate]
        
        
        return addMealView()
    }
}
