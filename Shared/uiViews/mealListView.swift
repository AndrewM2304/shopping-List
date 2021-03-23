//
//  mealListView.swift
//  shopping List (iOS)
//
//  Created by Andrew Miller on 24/01/2021.
//

import SwiftUI




struct mealListView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(entity: Meal.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Meal.mealName, ascending: true)],
                  predicate: nil,
                  animation: .default
    )
    
    private var listmeal: FetchedResults<Meal>
    @AppStorage("theme") var currentTheme: colorTheme = .green
    
    @State var selected = false
    @State var selectedMealItem : Meal?
    @State var searchtext = ""
    @State var placeholder = "Search Meals"


    var body: some View {
        
        
        VStack (alignment: .leading){
            if(selected == false){
                SearchBar(text: $searchtext, placeholder: placeholder)
                List{
                    ForEach(listmeal) { meal in
                       
                        if(self.searchtext == ""){
                            HStack {
                                Text(meal.wrappedMealName).font(.headline).foregroundColor(.primary)
                                Spacer()
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(currentTheme.colors.mainColor)
                                    .padding(10)
                            }
                            .background(Color("CardBackground").opacity(0.01))
                            .onTapGesture {
                                self.selectedMealItem = meal
                                self.selected.toggle()
                            }
                        } else{
                            if(meal.wrappedMealName.contains(self.searchtext)){
                                HStack {
                                    Text(meal.wrappedMealName).font(.headline).foregroundColor(.primary)
                                    Spacer()
                                    Image(systemName: "plus.circle.fill")
                                        .foregroundColor(currentTheme.colors.mainColor)
                                        .padding(20)
                                }
                                .background(Color("CardBackground"))
                                .onTapGesture {
                                    self.selectedMealItem = meal
                                    self.selected.toggle()
                                }
                            }
                        }
                    }.onDelete(perform: removeMeal)
                }
            } else{
                addMealView(mealObject: selectedMealItem)
            
            }
            
        }.frame(maxWidth: 600)
        
    }
    func removeMeal(at offsets: IndexSet) {
        for index in offsets {
            let meal = listmeal[index]
            viewContext.delete(meal)
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

}

struct mealListView_Previews: PreviewProvider {
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
        return mealListView(selectedMealItem: newMeal).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
       
        
    }
}



