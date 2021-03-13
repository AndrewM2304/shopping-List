//
//  updateMealView.swift
//  shopping List (iOS)
//
//  Created by Andrew Miller on 28/01/2021.
//

import SwiftUI

struct updateMealView: View {
    
    @State private var mealName = ""
    @State private var url = ""
    @State private var notes = ""
    @State private var ingredient = ""
    @State var ingList : [Ingredients] = []
    @State var showingModal = false
    @State var showOverlay = false
    @State  var dateList : [Dates] = []
    @State var viewing = 0
    @State var showKeyboard2 = false
    @State var selectedIngredient = Ingredients()
    @State var showAlertUpdate = false
    @State var alertMessageTitleUpdate = ""
    @State var alertMessageBodyUpdate = ""
    @State var viewSheet = 0
    
    
    
    
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("theme") var currentTheme: colorTheme = .green
    @StateObject private var keyboard2 = KeyboardResponder()
    @Environment(\.managedObjectContext) private var viewContext
    
    
    
    @State var meal:Meal
    var body: some View {

            
            VStack (spacing: 0){
                ScrollView{
                    
                    VStack{
                        
                        VStack (alignment: .leading, spacing: 5){
                            
                            Section (header: Text("Meal Name")
                                        .font(.subheadline)
                                        .foregroundColor(Color.primary)){
                                Text(meal.wrappedMealName)
                                    .font(Font.headline.weight(.semibold))
                                    .padding(.bottom, 20)
                            }
                            
                            
                            
                            textfieldSection(sectionHeader: "Link to Recipe", textField: $url, keyboardType: .URL)
                            
                            textfieldSection(sectionHeader: "Notes about meal", textField: $notes, keyboardType: .default, multiLine: true)
//                            selectDatesSection(dateList: $dateList)
//                                .background(Color.white.opacity(0.01))
//                                .onTapGesture {
//                                    self.showOverlay.toggle()
//                                    viewSheet = 0
//                                }
                        }
                        .padding()
                        
                        ingredientSection(viewing: viewing)
                        
                        ForEach(meal.ingredientArray){ mealIngredient in
                            HStack {
                                checkmarkItemView(shoppingListItem: false, ingredient: mealIngredient, buttonAction: {}, popupAction: {}, viewing: viewing)
                                   
                                    .onTapGesture{
                                        viewing += 1
                                        mealIngredient.isSelected.toggle()
                                    }
                                Button(action: {
                                    self.selectedIngredient = mealIngredient
                                    self.showOverlay.toggle() 
                                    viewing += 1
                                    self.viewSheet = 1
                                }, label: {
                                    Image(systemName: "ellipsis.circle")
                                        .padding(.vertical, 10)
                                        .padding(.leading, 20)
                                        .foregroundColor(.secondary)
                                })
                            }
                            .padding(.vertical, 5)
                        }
                        .sheet(isPresented: $showOverlay, content: {
                            if( viewSheet == 0){
                            mealSelect(selectDate: $dateList)
                            } else {
//                                weightAdjustView(ingredient: selectedIngredient, shoppingItemWeight: false)
                            }
                        })
                        .padding(.horizontal)

                    
                        
                        ingredientArrayView(ingList: $ingList, showOverlay: $showOverlay, viewing: $viewing, viewSheet: $viewSheet, selectedIngredient: $selectedIngredient)
                            .padding(.horizontal)
                        
                        HStack {
                            TextField("Add Ingredient", text: $ingredient, onCommit: addIngredientsKeyboardHide)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .onTapGesture {
                                    self.showKeyboard2 = true
                                }
                            
                            
                            Button(action: {
                                withAnimation{
                                    addIngredients() 
                                }
                            }, label: {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(currentTheme.colors.mainColor)
                                    .padding(20)
                            })
                            
                            
                        }
                        .padding(.leading)
                        
                    }
                    .offset(y: showKeyboard2 ? -(CGFloat(ingList.count) * 56) : 0)
                    .listRowInsets(EdgeInsets())
                    .padding(.bottom, 10)
                    .alert(isPresented: $showAlertUpdate) {
                        Alert(title: Text(alertMessageTitleUpdate),
                              message: Text(alertMessageBodyUpdate),
                              primaryButton: .default(Text("Yes"), action: addItem), secondaryButton: .cancel())
                    }
                    
                    Button(action: {
                        checkFieldsUpdate()
                        
                    }, label: {

                            Text("Save Meal")
                        .font(Font.headline.weight(.bold))
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(currentTheme.colors.mainColor)
                        .cornerRadius(8)
                        .shadow(color: Color("shadow").opacity(0.3), radius: 16, x: 0.0, y: 4)
                    })
                    .padding(10)
                    .padding(.bottom, 40)
                }
            }
            
            .padding(.bottom, keyboard2.currentHeight + 10)
            
            .animation(.default)
            
        
        .onAppear {
            self.url = meal.wrappedMealLink
            self.notes = meal.wrappedMealNotes
        }
        .blur(radius: showingModal ?  3 : 0)
        .overlay(mealSelect(selectDate: $dateList).padding().frame(maxHeight: .infinity).background(Color.white.opacity(0.01)).opacity( showingModal ? 1 : 0).animation(.default))
    }
    

    
    
    private func checkFieldsUpdate() {
        if(dateList.count == 0){
        self.showAlertUpdate.toggle()
        self.alertMessageTitleUpdate = "No Dates added"
        self.alertMessageBodyUpdate = "Are you sure you want to save?"
        } else{
            addItem()
        }
    }
    
    private func addItem() {
        withAnimation {
            let updatedMeal = meal
                updatedMeal.addToMeal(NSSet(array: dateList))
                updatedMeal.mealLink = self.url
                updatedMeal.mealNotes = self.notes
                updatedMeal.addToMyIngredientList(NSSet(array: ingList))
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
        }
    
    
    private func addIngredients() {
        withAnimation {
            if(!ingredient.isEmpty){
                
                let newIngredient = Ingredients(context: self.viewContext)
                newIngredient.isChecked = false
                newIngredient.ingredientName = ingredient
                newIngredient.isSelected = true
                newIngredient.ingredientQuantity = 1
                newIngredient.ingredientTypeNameStatus = .items
                ingList.append(newIngredient)
                self.ingredient = ""
                
            }
        }
        
    }
    
    private func addIngredientsKeyboardHide() {
        withAnimation {
            self.showKeyboard2.toggle()
            if(!ingredient.isEmpty){
                
                let newIngredient = Ingredients(context: self.viewContext)
                newIngredient.isChecked = false
                newIngredient.ingredientName = ingredient
                newIngredient.isSelected = true
                newIngredient.ingredientQuantity = 1
                newIngredient.ingredientTypeNameStatus = .items
                ingList.append(newIngredient)
                self.ingredient = ""
                
                
            }
        }
        
    }

}

struct updateMealView_Previews: PreviewProvider {
    
    static var viewContext = PersistenceController.preview.container.viewContext
    static var previews: some View {
        let newIngredient = Ingredients(context: viewContext)
        newIngredient.ingredientName = "Ing 1 very long title"
        newIngredient.ingredientQuantity = 1
        newIngredient.isChecked = false
        newIngredient.isSelected = true
        newIngredient.ingredientMeasurement = "kilo"
        
        let newIngredient2 = Ingredients(context: viewContext)
        newIngredient2.ingredientName = "Ing 1 very ling title"
        newIngredient2.ingredientQuantity = 1
        newIngredient2.isChecked = false
        newIngredient2.isSelected = true
        newIngredient2.ingredientMeasurement = "kilo"
        
        let newDate = Dates(context:viewContext)
        newDate.date = Date()
        newDate.meal = Meal(context: viewContext)
        newDate.mealTypeNameStatus = .lunch
        
        let newMeal = Meal(context:viewContext)
        newMeal.mealName = "burgers and chips"
        newMeal.mealLink = "www.google.com"
        newMeal.mealNotes = "Lorem Ipsum dolat amit this is a really long note what will it look like on the screen over 3 pages? Wow this is actually super long I need to type more"
        newMeal.myIngredientList = [newIngredient, newIngredient2]
        newMeal.meal = [newDate, newDate]
        return updateMealView(meal: newMeal).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
