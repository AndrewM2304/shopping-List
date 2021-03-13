//
//  Meal+CoreDataProperties.swift
//  shopping List (iOS)
//
//  Created by Andrew Miller on 11/01/2021.
//
//

import Foundation
import CoreData


extension Meal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Meal> {
        return NSFetchRequest<Meal>(entityName: "Meal")
    }

    @NSManaged public var mealID: UUID?
    @NSManaged public var mealLink: String?
    @NSManaged public var mealName: String?
    @NSManaged public var mealNotes: String?
    @NSManaged public var meal: NSSet?
    @NSManaged public var myIngredientList: NSSet?
    
    
    
   

    public var ingredientArray : [Ingredients]{
        let set = myIngredientList as? Set<Ingredients>  ?? []
        return set.sorted {
            $0.wrappedIngredientName    < $1.wrappedIngredientName
        }
    }
    
    
    public var dateArray : [Dates]{
        let set = meal as? Set<Dates>  ?? []
        return set.sorted {
            $0.mealType! < $1.mealType!
        }
    }
    
    public var wrappedMealName: String{
        mealName ?? ""
    }
    
    public var wrappedMealLink: String{
        mealLink ?? ""
    }
    
    public var wrappedMealNotes: String{
        mealNotes ?? ""
    }
    
    

    
    
}







// MARK: Generated accessors for meal
extension Meal {

    @objc(addMealObject:)
    @NSManaged public func addToMeal(_ value: Dates)

    @objc(removeMealObject:)
    @NSManaged public func removeFromMeal(_ value: Dates)

    @objc(addMeal:)
    @NSManaged public func addToMeal(_ values: NSSet)

    @objc(removeMeal:)
    @NSManaged public func removeFromMeal(_ values: NSSet)

}

// MARK: Generated accessors for myIngredientList
extension Meal {

    @objc(addMyIngredientListObject:)
    @NSManaged public func addToMyIngredientList(_ value: Ingredients)

    @objc(removeMyIngredientListObject:)
    @NSManaged public func removeFromMyIngredientList(_ value: Ingredients)

    @objc(addMyIngredientList:)
    @NSManaged public func addToMyIngredientList(_ values: NSSet)

    @objc(removeMyIngredientList:)
    @NSManaged public func removeFromMyIngredientList(_ values: NSSet)

}

extension Meal : Identifiable {

}

extension Meal{
    /// FetchRequest for selected Account, sorted by name

    static func selectedMealFetchRequest(filter: String) -> NSFetchRequest<Meal> {
    let request: NSFetchRequest<Meal> = Meal.fetchRequest() // typical fetch request for all Account records
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Meal.mealName, ascending: true)] // sort Accounts, probably not needed
    request.predicate = NSPredicate(format: "mealName == %@", filter) // add a predicate where Account. name is equal to the filter string
    return request // returns the <Account>
    }
    
    
    
}


