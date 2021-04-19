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
                  animation: .default)
    private var listmeal: FetchedResults<Meal>
     @AppStorage("theme", store: UserDefaults(suiteName: "group.Andrew-Miller.shoppingList")) var currentTheme: colorTheme = .green
    
    @State var selected = false
    @State var selectedMealItem : Meal?
    @State var searchtext = ""
    @State var placeholder = "Search Meals"



    var body: some View {
        
        
        VStack (alignment: .leading, spacing: 0){
            if(selected == false){
               

                
                searchInputBox(textField: $searchtext, label: "Search for Meal", keyboardReturn: {})
                    .padding()
                    .padding(.bottom, 20)
                
                
                
                
                
                ForEach(listmeal.filter({ searchtext.isEmpty ? true : $0.wrappedMealName.contains(searchtext) })) { meal in
                        
                        VStack(alignment: .leading, spacing: 0){

                            HStack {
                                Text(meal.wrappedMealName)
                                    .interTextStyle(text: "Inter-SemiBold", size: 15, color: .white)
                                Spacer()
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(currentTheme.colors.accentColor)

                            }
                            .background(Color.black.opacity(0.01))
                            .onTapGesture {
                                self.selectedMealItem = meal
                                self.selected.toggle()
                            }
                            .background(Color.clear)


                            Divider().background(Color.white.opacity(0.2))
                                .padding(.vertical)
                    }
                        .background(Color.black.opacity(0.01))
                        .onTapGesture {
                            self.selectedMealItem = meal
                            self.selected.toggle()
                        }
                    
                    }
                    .padding(.horizontal, 15)
              
                
                
            } else{
                addMealView(mealObject: selectedMealItem)
            
            }
            
        }
        .background(radialBackgroundView())
        .frame(maxWidth: 600)
        
        
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


        return mealListView()


    }
}



