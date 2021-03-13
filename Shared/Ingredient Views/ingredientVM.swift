//
//  ingredientVM.swift
//  shopping List (iOS)
//
//  Created by Andrew Miller on 10/02/2021.
//


import SwiftUI
import CoreData

class addIngredientViewModel: ObservableObject, Identifiable {

     var ingredientObject: Ingredients?
    
    @Published var  ingredientName = ""
    
    
    @Published var ingredientID =  UUID()
    @Published var ingredientMeasurement = ""
    @Published var ingredientQuantity: Int64 = 0
    @Published var isChecked: Bool = false
    @Published var isSelected: Bool = true
    @Published var selectedIngredient : Ingredients?
    @Published var enumSwitch = ingredientTypeName(rawValue: "")
    
    
    
    @Environment(\.managedObjectContext) var managedObjectContext
 
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Ingredients.ingredientName, ascending: true)],
        animation: .default)
    
    private var listingredients: FetchedResults<Ingredients>
    
    
    
    
    init(){
        ingredientObject = Ingredients(context: managedObjectContext)
        selectedIngredient = Ingredients(context: managedObjectContext)
    }
    
    func saveIngredient(myIngredientName: String){
        let newIngredient = Ingredients(context: managedObjectContext)
        newIngredient.ingredientID = UUID()
        newIngredient.ingredientName = myIngredientName
        newIngredient.isSelected = true
        newIngredient.isChecked = false
        newIngredient.ingredientTypeNameStatus = .items
        newIngredient.ingredientQuantity = 1
        newIngredient.ingredientMeasurement = "Item"
    }
}
    
