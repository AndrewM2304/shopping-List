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
        predicate: NSPredicate(format: "isSelected == YES"),
        animation: .default)
    
        
        private var listingredients: FetchedResults<Ingredients>
        
        
        var body: some View {
           
               
            ScrollView{
                VStack (alignment: .leading, spacing: 5){

                    VStack  (alignment: .leading, spacing: 5){
                        Text("Shopping List ").bold()
                        Text("(\(remainingItems(fetch: listingredients, bool: false)) items)").font(.caption)
                            .opacity(0.8)
                    }
                    Divider().background(currentTheme.colors.gradient)
                    
                    
                    remainingItems(fetch: listingredients)
                    Divider()
                        .padding()
                    VStack  (alignment: .leading, spacing: 5){
                        Text("Completed Items").bold()
                        Text("(\(remainingItems(fetch: listingredients, bool: true)) items)").font(.caption)
                            .opacity(0.8)
                    }
                    Divider().background(currentTheme.colors.gradient)
          completedItems(fetch: listingredients)
                    
            }
            }.onAppear{
                refresher()
            }
                
            
            
        }
    
    func refresher(){
        viewContext.refreshAllObjects()
    }
    

    
    func remainingItems(fetch: FetchedResults
    <Ingredients>, bool: Bool) -> Int{
        let count = fetch.filter{ $0.isChecked == bool}
        return count.count
    }
    
    func remainingItems(fetch: FetchedResults
    <Ingredients>) -> some View{
        let count = fetch.filter{ $0.isChecked == false}
        
        if (count.count == 0){
            return AnyView(Text("No Items Remaining")
                            .padding(.vertical)
                .foregroundColor(Color.white.opacity(0.8)))
        } else {
            return  AnyView(
                ForEach(count){ ingredient in
                    Button(action: {
                        checkItem(ingredient: ingredient)
                        print("\(ingredient.wrappedIngredientName) is checked")
                    }, label: {
                        watchCheckmark(ingredient: ingredient)
                    })
            }
            )
        }
    }
    
    func completedItems(fetch: FetchedResults
    <Ingredients>) -> some View{
        let count2 = fetch.filter{ $0.isChecked == true}
        
        if (count2.count == 0){
            return AnyView(Text("No Items Completed")
                            .padding(.vertical)
                .foregroundColor(Color.white.opacity(0.8)))
        } else {
            return  AnyView(
                ForEach(count2){ ingredient in
                    Button(action: {
                        checkItem(ingredient: ingredient)
                        print("\(ingredient.wrappedIngredientName) is checked")
                    }, label: {
                        watchCheckmark(ingredient: ingredient)
                    })
            }
            )
        }
    }
    
    
    func checkItem(ingredient: Ingredients){
        ingredient.isChecked.toggle()
        do {

            try viewContext.save()

        } catch {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
 
    
    
    

    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        
    }
}
