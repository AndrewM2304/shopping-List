//
//  menuPopupView.swift
//  shopping List
//
//  Created by Andrew Miller on 02/01/2021.
//

import SwiftUI



struct menuPopupView: View {
    @State private var mealName = ""
    @State private var url = ""
    @State private var notes = ""
    @State private var ingredient = ""
    @State var ingList : [Ingredients] = []
    @State var activeSheet: ActiveSheet?
    @State  var dateList : [Dates] = []
    @State var viewing = 0
    @State var showKeyboard = false
    @State var newMeal = 0
    @State var showAlert = false
    @State var showOverlay = false
    @State var viewSheet = 0
    @State var alertMessageTitle = ""
    @State var alertMessageBody = ""
    
    
    
    
    

    @Environment(\.presentationMode) var presentationMode
    @AppStorage("theme") var currentTheme: colorTheme = .green
    @Environment(\.managedObjectContext) private var viewContext
    
    enum ActiveSheet: Identifiable {
        case first, second
        
        var id: Int {
            hashValue
        }
    }
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(currentTheme.colors.mainColor)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    }
    
    var body: some View {
        
        
        VStack (spacing:0){
            navBarView(curved: false)
                .zIndex(1.0)
                .overlay(
                    Text("Add Meal")
                        .whiteTitleStyle()
                )
                .overlay(
                    HStack{
                        Spacer()
                        Button(action: {
                                presentationMode.wrappedValue.dismiss()}, label: {
                                    Text("Cancel")
                                        .font(.subheadline)
                                        .foregroundColor(Color.white)
                                        .padding()
                                })
                        
                    }.padding(.top, 30)
                    
                )
            
            Picker(selection: $newMeal, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/) {
                Label("New Meal", systemImage: "42.circle").tag(0)
                Label("Search Meal", systemImage: "42.circle").tag(1)
            }.padding()
            .zIndex(2)
            
            .background(Color("section"))
            .pickerStyle( SegmentedPickerStyle())
            
            if(newMeal == 0){
                
                addMealView()
//                VStack (spacing: 0){
//
//                    ScrollView{
//
//                        VStack{
//
//                            VStack (alignment: .leading, spacing: 5){
//                                textfieldSection(sectionHeader: "Meal Name", textField: $mealName, keyboardType: .default)
//                                textfieldSection(sectionHeader: "Link to Recipe", textField: $url, keyboardType: .URL)
//                                textfieldSection(sectionHeader: "Notes about meal", textField: $notes, keyboardType: .default, multiLine: true)
////                                selectDatesSection(dateList: $dateList)
////                                    .background(Color.white.opacity(0.01))
////                                    .onTapGesture {
////                                        self.showOverlay.toggle()
////                                        viewSheet = 0
////                                    }
//
//
//                            }
//                            .padding()
//                            ingredientSection(viewing: viewing)
//                            ingredientArrayView(ingList: $ingList, showOverlay: $showOverlay, viewing: $viewing, viewSheet: $viewSheet, selectedIngredient: $selectedIngredient)
//                                .padding(.horizontal)
//
//                            HStack {
//                                TextField("Add Ingredient", text: $ingredient, onCommit: addIngredientsKeyboardHide)
//                                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                                    .onTapGesture {
//                                        self.showKeyboard = true
//                                    }
//                                Button(action: {
//                                    withAnimation{
//                                        addIngredients()
//
//                                    }
//                                }, label: {
//                                    Image(systemName: "plus.circle.fill")
//                                        .foregroundColor(currentTheme.colors.mainColor)
//                                        .padding(20)
//                                })
//                            }
//                            .padding(.leading)
//
//                        }
//                        .offset(y: showKeyboard ? -(CGFloat(ingList.count) * 56) : 0)
//                        .padding(.bottom, 10)
//
//                        Button(action: {checkFields()}, label: {
//                            HStack{
//                                Image(systemName: "plus.circle")
//                                Text("Add Meal")
//                            }
//                            .font(Font.headline.weight(.bold))
//                            .foregroundColor(.white)
//                            .padding()
//                            .frame(maxWidth: .infinity)
//                            .background(mealName == "" ? Color.gray : currentTheme.colors.mainColor)
//                            .opacity(mealName == "" ? 0.7 : 1)
//                            .cornerRadius(8)
//                            .shadow(color: Color("shadow").opacity(0.3), radius: 16, x: 0.0, y: 4)
//
//                        }).disabled(mealName.isEmpty)
//                        .padding(10)
//                        .padding(.bottom, 40)
//
//
//                    }
//
//
//                    .sheet(isPresented: $showOverlay, content: {
//                        if( viewSheet == 0){
//                        mealSelect(selectDate: $dateList)
//                        } else {
//                            weightAdjustView(ingredient: selectedIngredient, shoppingItemWeight: false)
//                        }
//                    })
//                    .alert(isPresented: $showAlert, content: {alertContent})
//                }
//                .dismissKeyboardOnTap()
//                .padding(.bottom, keyboard.currentHeight + 10)
//                .animation(.default)
            } else {
                mealListView()
            }
            
        }

    }
    
    
    var alertContent : Alert{
        
        Alert(title: Text(alertMessageTitle),
              message: Text(alertMessageBody),
              primaryButton: .default(Text("Yes"), action: addItem), secondaryButton: .cancel())
    }
    
//    var sheetContent: some View{
//        weightAdjustView(ingredient: self.selectedIngredient, shoppingItemWeight: false)
//    }
    
    
    // Functions here
    
    private func checkFields() {
        if(dateList.count == 0){
            self.showAlert.toggle()
            self.alertMessageTitle = "No Dates added"
            self.alertMessageBody = "Are you sure you want to add meal?"
        } else{
            addItem()
        }
    }
    
    
    private func addItem() {
        withAnimation {     
            if(!mealName.isEmpty){
                let newMeal = Meal(context: self.viewContext)
                newMeal.mealID = UUID()
                newMeal.mealLink = self.url
                newMeal.mealNotes = self.notes
                newMeal.mealName = self.mealName
                newMeal.addToMyIngredientList(NSSet(array: ingList))
                newMeal.addToMeal(NSSet(array: dateList))
                
                do {
                    
                    try viewContext.save()
                    self.ingredient = ""
                    presentationMode.wrappedValue.dismiss()
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
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
            self.showKeyboard.toggle()
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


struct menuPopupView_Previews: PreviewProvider {
    static var previews: some View {
        menuPopupView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}


// Mark: Additional Views here








struct ingredientArrayView : View{
    @Binding var ingList :[Ingredients]
    @Binding var showOverlay : Bool
    @Binding var viewing: Int
    @Binding var viewSheet: Int
    @Binding var selectedIngredient : Ingredients
    var body: some View{
        ForEach(ingList){ mealIngredient in
            HStack {
//                checkmarkItemView(shoppingListItem: false, ingredient: mealIngredient, buttonAction: {})
//                    .onTapGesture{
//                        viewing += 1
//                        mealIngredient.isSelected.toggle()
//                    }
                Button(action: {
                    self.selectedIngredient = mealIngredient
                    self.viewSheet = 1
                    self.showOverlay.toggle()
                    viewing += 1
                }, label: {
                    Image(systemName: "ellipsis.circle")
                        .padding(.vertical, 10)
                        .padding(.leading, 20)
                        .foregroundColor(.secondary)
                })
            }
            .padding(.vertical, 5)
        }
    }
}




