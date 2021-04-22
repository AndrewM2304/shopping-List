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
    
     @AppStorage("theme", store: UserDefaults(suiteName: "group.Andrew-Miller.shoppingList")) var currentTheme: colorTheme = .green
    
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
    @State var offset = 0
    
    init(mealObject: Meal? = nil){
        
        addMealObject.mealObject = mealObject
        addMealObject.mealName = mealObject?.mealName ?? mealNameText
        addMealObject.mealUrl = mealObject?.mealLink ?? mealLinkText
        addMealObject.mealNotes = mealObject?.mealNotes ?? mealNotesText
        addMealObject.ingredientList = mealObject?.ingredientArray ?? [Ingredients]()
        addMealObject.dateList = mealObject?.dateArray ?? [Dates]()
        
    }
    
    
    var body: some View {
        ScrollView {
            
            
            
            
                
                    VStack (alignment: .leading, spacing: 30){
                        textfieldSection(sectionHeader: "Meal Name", textField: $mealNameText, keyboardType: .default, color: currentTheme.colors.accentColor, keyboardReturn: {})
                        
                        textfieldSection(sectionHeader: "Link to Recipe", textField: $mealLinkText, keyboardType: .URL, color: currentTheme.colors.accentColor, keyboardReturn: {})
                        notesSection(sectionHeader: "Meal Notes", textField: $mealNotesText, color: currentTheme.colors.accentColor)
                        
                    }
                    .padding()
                    .padding(.bottom, 40)
            VStack (spacing: 0){
                    sectionBreak(viewing: UpdateUI, mainText: "Select Dates", secondaryText: "Select when to have your meal", multiText: true)
                    addDateView(addDate: addMealObject)
                        
                        .padding()
                        .padding(.bottom, 40)
                    
           
                    sectionBreak(viewing: UpdateUI, mainText: "Ingredients", secondaryText: "Selected ingredients will be added to your Shopping List", multiText: true)
                    ingredientListView(arrayName: $addMealObject.ingredientList, shoppingListItem: false, viewing: $UpdateUI, selectedIngredient: $addIngredientObject.selectedIngredient, showOverlay: $showOverlay)
                    
                    
                HStack {
                    searchInputBox(textField: $ingredientName, search: false, label: "Add Ingredient", keyboardReturn: {
                        withAnimation{
                            self.showKeyboard = false
                            self.offset = 0
                        }
                        addItem()
                    }).onTapGesture {
                        withAnimation {
                            self.showKeyboard = true
                        }
                    }
                    Button(action: {
                        withAnimation{
                            addItem()
                            self.offset += 1
                        }
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(currentTheme.colors.accentColor)
                            .padding(.vertical, 10)
                            .padding(.leading, 20)
                    })

                }
                
                .padding( 15)
            .alert(isPresented: $addMealObject.showAlert,
                   content: { Alert(title: Text("error"), message: Text(addMealObject.alertMsg), dismissButton: .default(Text("OK"))) })
            
            
            Button(action: {addMealObject.saveMeal(managedObjectContext: viewContext, myMealName: mealNameText, myMealLink: mealLinkText, myMealNotes: mealNotesText);
                    self.presentationMode.wrappedValue.dismiss()}, label: {
                        Text("save")
                            .interTextStyle(text: "Inter-ExtraBold", size: 17, color: Color.white)
                            .frame(maxWidth: .infinity)
                            .padding(15)
                    })
                
                
                .buttonStyle(primaryButtonStyle(gradient: currentTheme.colors.gradient)).padding()
                .padding(.bottom, 50)
            }.opacity(mealNameText == "" ? 0 : 1)
        }.frame(maxWidth: 600)
        .offset(y: showKeyboard ?  -(keyboard.currentHeight - 130 + (CGFloat(offset) * 68)) : 0)
        .background(radialBackgroundView())

        .onAppear{
            self.showKeyboard = false
            self.mealNameText = addMealObject.mealName
            self.mealNotesText = addMealObject.mealNotes
            self.mealLinkText = addMealObject.mealUrl
            addMealObject.checkAndSelect(meal: addMealObject.mealObject)
        }
        .dismissKeyboardOnTap()
        
        
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
        
        
        return addMealView().preferredColorScheme(.dark)
    }
}
