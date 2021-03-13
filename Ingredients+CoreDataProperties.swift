//
//  Ingredients+CoreDataProperties.swift
//  shopping List (iOS)
//
//  Created by Andrew Miller on 10/02/2021.
//
//

import Foundation
import CoreData
import SwiftUI


extension Ingredients {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ingredients> {
        return NSFetchRequest<Ingredients>(entityName: "Ingredients")
    }

    @NSManaged public var ingredientID: UUID?
    @NSManaged public var ingredientMeasurement: String?
    @NSManaged public var ingredientName: String?
    @NSManaged public var ingredientQuantity: Int64
    @NSManaged public var isChecked: Bool
    @NSManaged public var isSelected: Bool
    @NSManaged public var mealIngredientList: Meal?
    
    
        public var wrappedIngredientName: String{
            ingredientName ?? " placeholder ingredient"
        }
    
    var ingredientTypeNameStatus :ingredientTypeName{
        set{
            ingredientMeasurement = newValue.rawValue
        }
        get{
            ingredientTypeName(rawValue: wrappedIngredientName) ?? .items
        }
    }

}

extension Ingredients : Identifiable {

}

enum ingredientTypeName:  String, Equatable, CaseIterable {
    case items = "Items"
    case gram = "Grams"
    case kilograms = "Kilograms"
    case mililitres = "ml"
    case litres = "Litres"
    case pounds = "Lbs"
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue)}
    var id : ingredientTypeName {ingredientTypeName(rawValue: self.rawValue)!}
        
    }
