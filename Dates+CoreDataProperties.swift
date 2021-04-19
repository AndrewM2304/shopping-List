//
//  Dates+CoreDataProperties.swift
//  shopping List (iOS)
//
//  Created by Andrew Miller on 08/02/2021.
//
//

import Foundation
import CoreData
import SwiftUI


extension Dates {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dates> {
        return NSFetchRequest<Dates>(entityName: "Dates")
    }

    @NSManaged public var date: Date?
    @NSManaged public var mealType: String?
    @NSManaged public var meal: Meal?
    @NSManaged public var sortedOrder: String
    
    var mealTypeNameStatus :mealTypeName{
            set{
                mealType = newValue.rawValue
            }
            get{
                mealTypeName(rawValue: mealType!) ?? .breakfast
            }
        }

}

extension Dates : Identifiable {

}

enum mealTypeName: String, CaseIterable, Equatable, Comparable{

    
    case breakfast = "Breakfast"
    case lunch = "Lunch"
    case dinner = "Dinner"
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
    
     var sortOrder: Int{
        switch self{
        case .breakfast :
            return 1
        case .lunch:
            return 2
        case .dinner:
            return 3
        }
    }
    
    
    static func < (lhs: mealTypeName, rhs: mealTypeName) -> Bool {
        return lhs.sortOrder < rhs.sortOrder
    }
    
    
}
