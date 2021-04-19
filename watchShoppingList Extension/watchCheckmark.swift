//
//  watchCheckmark.swift
//  watchShoppingList Extension
//
//  Created by Andrew Miller on 07/04/2021.
//

import SwiftUI

struct watchCheckmark: View {
     @AppStorage("theme", store: UserDefaults(suiteName: "group.Andrew-Miller.shoppingList")) var currentTheme: colorTheme = .green


    @State var ingredient: Ingredients!
    var body: some View {
        HStack (spacing: 10){
            if (ingredient.isChecked == true){
            Image(systemName: "checkmark.square.fill").foregroundColor(currentTheme.colors.accentColor)
                .font(Font.title3)
            } else {
                Image(systemName: "square").foregroundColor(Color.white.opacity(0.4))
                    .font(Font.title3)
            }
            VStack (alignment: .leading, spacing: 5){
                Text(ingredient.wrappedIngredientName)
                    .strikethrough(color: ingredient.isChecked ? Color.white : Color.clear)
                    .font(.subheadline)
                Text("\(ingredient.ingredientQuantity) \(ingredient.ingredientMeasurement! ) hello")
                    .strikethrough(color: ingredient.isChecked ? Color.white.opacity(0.6) : Color.clear)
                    .font(.caption)
                    .foregroundColor(Color.white.opacity(0.6))
            }
            Spacer()
        }
    }
    

}

struct watchCheckmark_Previews: PreviewProvider {
    static var viewContext = PersistenceController.preview.container.viewContext

    static var previews: some View {
        let newIngredient = Ingredients(context: viewContext)
        newIngredient.ingredientName = "Ing 1 very long title"
        newIngredient.ingredientQuantity = 1
        newIngredient.isChecked = false
        newIngredient.isSelected = true
        newIngredient.ingredientMeasurement = "kilo"
        
        return watchCheckmark(ingredient:newIngredient)
        
    }
    
}
