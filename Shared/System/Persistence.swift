
    
//
//  Persistence.swift
//  Shared
//
//  Created by Andrew Miller on 30/12/2020.
//
import CoreData


public extension URL {
    static func storeURL(for appGroup: String, databaseName: String) -> URL {
        guard let fileContainer = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroup) else {
            fatalError("Shared file container could not be created.")
        }
        return fileContainer.appendingPathComponent("\(databaseName).sqlite")
    }
}


class PersistenceController: ObservableObject {
    
    
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController()
        let viewContext = result.container.viewContext

        
        let newIngredient = Ingredients(context: viewContext)
        newIngredient.ingredientName = "Ing 1"
        newIngredient.ingredientQuantity = 1
        newIngredient.isChecked = false
        newIngredient.isSelected = true
        newIngredient.ingredientMeasurement = "kilo"
        
        let newIngredient2 = Ingredients(context: viewContext)
        newIngredient2.ingredientName = "Ing 1"
        newIngredient2.ingredientQuantity = 1
        newIngredient2.isChecked = false
        newIngredient2.isSelected = true
        newIngredient2.ingredientMeasurement = "kilo"
        
        
        
        
        let newDate = Dates(context:viewContext)
        newDate.date = Date().midnight
        newDate.meal = Meal(context: viewContext)
        newDate.mealTypeNameStatus = .lunch
        newDate.sortedOrder = "b"
        
        let newMeal = Meal(context:viewContext)
        newMeal.mealName = "burgers and chips"
        newMeal.mealLink = "www.google.com"
        newMeal.mealNotes = "Lorem Ipsum dolat amit this is a really long note what will it look like on the screen over 3 pages? Wow this is actually super long I need to type more"
        newMeal.myIngredientList = [newIngredient, newIngredient2]
        newMeal.meal = [newDate, newDate]

        
        
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentCloudKitContainer
       let storeURL: URL
       let storeDescription: NSPersistentStoreDescription
    

    init() {
        
        storeURL = URL.storeURL(for: "group.Andrew-Miller.shoppingList", databaseName: "shopping_List")
                container = NSPersistentCloudKitContainer(name: "shopping_List")
                storeDescription = NSPersistentStoreDescription(url: storeURL)
                container.persistentStoreDescriptions = [storeDescription]
        storeDescription.cloudKitContainerOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: "iCloud.icloud.container.get.prepped")

        storeDescription.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
        storeDescription.setOption(true as NSObject, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
        
        
//        container = NSPersistentCloudKitContainer(name: "shopping_List")
//        let storeURL = containerURL.appendingPathComponent("shopping_List.sqlite")
//        let description = NSPersistentStoreDescription(url: storeURL)
//        container.persistentStoreDescriptions = [description]
//        if inMemory {
//
//            let storeURL = containerURL.appendingPathComponent("shopping_List.sqlite")
//            let description = NSPersistentStoreDescription(url: storeURL)
//            container.persistentStoreDescriptions = [description]
//        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
