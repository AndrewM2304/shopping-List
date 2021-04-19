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

    
//    init(ingredientObject: Ingredients? = nil,
//         shoppingListItem: Bool,
//         viewing: Int
//    ){
//
//        addIngredientObject.ingredientObject = ingredientObject
//        addIngredientObject.ingredientName = ingredientObject?.ingredientName ?? ""
//        addIngredientObject.ingredientQuantity = ingredientObject?.ingredientQuantity ?? 1
//        addIngredientObject.enumSwitch = ingredientObject?.ingredientTypeNameStatus ?? .items
//        addIngredientObject.selectedIngredient = Ingredients?
//
//    }
    
    
    
    var body: some View{
        VStack (spacing: 0){
        ForEach(arrayName){ mealIngredient in
            HStack {
                checkmarkItemView(shoppingListItem: shoppingListItem, ingredient: mealIngredient, buttonAction: {mealIngredient.isSelected.toggle(); viewing += 1}, popupAction: {
                    
                    addIngredientObject.selectedIngredient = mealIngredient
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                        showOverlay.toggle()
//                    }
                }, viewing: viewing)
            }
            .padding(.vertical, 5)
        }
        }
    }
    
}


