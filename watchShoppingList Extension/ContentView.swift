//
//  ContentView.swift
//  watchShoppingList Extension
//
//  Created by Andrew Miller on 04/04/2021.
//

import SwiftUI

struct ContentView: View {
 
        @Environment(\.managedObjectContext) private var viewContext
    @AppStorage("theme", store: UserDefaults(suiteName: "group.Andrew-Miller.shoppingList")) var currentTheme: colorTheme = .green

    


        @FetchRequest(
            entity: Ingredients.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \Ingredients.ingredientName, ascending: true)],
            animation: .default)
    
        
        private var listingredients: FetchedResults<Ingredients>
        
        
        var body: some View {
           
               
            ScrollView{
                VStack (alignment: .leading, spacing: 10){
                Text("Remaining Items")
                    
                    
                    ForEach(listingredients){ ingredient in

                    if(ingredient.isSelected == true && !ingredient.isChecked){
                       
                        Button(action: {
                            checkItem(ingredient: ingredient)
                            print("\(ingredient.wrappedIngredientName) is checked")
                        }, label: {
                            watchCheckmark(ingredient: ingredient)
                        })
                    }
                }
                    Divider()
                    Text("Completed Items")
                    ForEach(listingredients){ ingredient in

                        if(ingredient.isSelected == true && ingredient.isChecked){
                           
                            Button(action: {
                                checkItem(ingredient: ingredient)
                                print("\(ingredient.wrappedIngredientName) is checked")
                            }, label: {
                                watchCheckmark(ingredient: ingredient)
                            })
                        }
                    }
            }
            }
                
            
            
        }
    func checkItem(ingredient: Ingredients){
        ingredient.isChecked.toggle()
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


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        
    }
}
