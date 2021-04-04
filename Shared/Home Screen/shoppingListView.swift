//
//  shoppingListView.swift
//  shopping List (iOS)
//
//  Created by Andrew Miller on 08/01/2021.
//

import SwiftUI

struct shoppingListView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @State var hidekeyboard = true
    @State var ingredient = ""
    @AppStorage("theme") var currentTheme: colorTheme = .green
    @State var viewing = 0

    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Ingredients.ingredientName, ascending: true)],
        animation: .default)
    
    private var listingredients: FetchedResults<Ingredients>
    
    var body: some View {
      
        
        ZStack (alignment: .top){
            radialBackgroundView()
            VStack (spacing: 0){
                
                
                HStack{
                    Spacer()
                VStack (spacing: 5){
                HStack (alignment: .center){
                    Text("Shopping List")
                        .interTextStyle(text: "Inter-ExtraBold", size: 28, color: Color.white)
                Spacer()
                    menuItems
            }
                    HStack {
                        TextField("Add Ingredient", text: $ingredient, onCommit: addIngredients)
                            .textFieldStyle(RoundedBorderTextFieldStyle())

                        Button(action: {
                            withAnimation{
                                addIngredients()
                                
                            }
                        }, label: {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(currentTheme.colors.mainColor)
                                .padding(.vertical, 10)
                                .padding(.leading, 20)
                        })
                    }
                }
                
                .frame(maxWidth: 600)
                   
               Spacer()
            }
                .padding(.top, UIDevice.current.hasNotch ? 40 : 20)
                .padding( 10)
                .modifier(pageHeader())
                
 

            ScrollView{
            VStack (spacing: 0){
                ForEach(listingredients){ ingredient in
                    
                    if(ingredient.isSelected == true){
                        HStack(alignment: .top){
                            checkmarkItemView(shoppingListItem: true, ingredient: ingredient, buttonAction: {checkItem(ingredient: ingredient)}, popupAction: {save()}, viewing: viewing)
                           
                        }
                        .listRowInsets(EdgeInsets())
                        Divider()
                    }
                }.dismissKeyboardOnTap()
            }


        }
            .frame(maxWidth: 600)
            
        }.dismissKeyboardOnTap()
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
    
    var menuItems : some View{

            Menu{
               
                Text("Menu Item 2")
                Text("Menu Item 3")
                Divider()
                Button(action: {deleteAll()}, label: {
                    Text("Delete All Items").foregroundColor(.red).accentColor(.green)
                })
            }
            label: {
                Image(systemName: "ellipsis.circle").foregroundColor(.white)
                    .padding(.vertical, 20)
                    .padding(.leading, 20)
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
                do {
                    
                    try viewContext.save()
                    
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
                
                self.ingredient = ""
                
            }
        }
        
    }
    
    func unselectItem(at offsets: IndexSet) {
        for index in offsets {
            let item = listingredients[index]
            viewContext.delete(item)
        }
    }
    
    func deleteAll(){
        for ingredientFunction in listingredients {
            ingredientFunction.isSelected = false
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
    
    func save(){
        do {
            
            try viewContext.save()
            
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    func checkItem(ingredient: Ingredients){
        do {
            ingredient.isChecked.toggle()
            try viewContext.save()
            
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    
 
}

struct shoppingListView_Previews: PreviewProvider {
    static var previews: some View {
        shoppingListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
