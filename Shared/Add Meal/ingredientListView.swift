//
//  ingredientListView.swift
//  shopping List (iOS)
//
//  Created by Andrew Miller on 08/02/2021.
//

import SwiftUI

struct ingredientListView : View{
    @ObservedObject var addIngredientObject = addIngredientViewModel()
    @Binding var arrayName:[Ingredients]
    @State  var shoppingListItem: Bool
    @Binding var viewing: Int
    @Binding var selectedIngredient : Ingredients?
    @Binding var showOverlay: Bool
    @Environment(\.managedObjectContext) var managedObjectContext

    
    
    var body: some View{
        VStack (spacing: 0){
        ForEach(arrayName){ mealIngredient in
            
            HStack {
                checkmarkItemView(shoppingListItem: shoppingListItem, ingredient: mealIngredient, buttonAction: {mealIngredient.isSelected.toggle(); viewing += 1}, popupAction: {

                    addIngredientObject.selectedIngredient = mealIngredient
                }, viewing: viewing)
                Button(action: {
                   deleteIngredient(ingredient: mealIngredient)
                    viewing += 1
                }, label: {
                    Image(systemName: "trash.fill")
                .foregroundColor(Color(#colorLiteral(red: 0.8588235294, green: 0.168627451, blue: 0.4666666667, alpha: 1)))
                })
                .padding(5)
                .padding(.trailing, 10)
                    
                
            }
            .padding(.vertical, 5)
        }
        }
        
    }
    func deleteIngredient(ingredient: Ingredients){
        arrayName.removeAll{ value in
            return (value.wrappedIngredientName == ingredient.wrappedIngredientName);
        }
    managedObjectContext.delete(ingredient)
       
    }

    
}


