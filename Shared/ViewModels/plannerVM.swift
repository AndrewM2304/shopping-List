//
//  plannerVM.swift
//  shopping List
//
//  Created by Andrew Miller on 24/03/2021.
//

import SwiftUI
import CoreData
import Foundation

//public class plannerVM: ObservableObject {
//    @Published var mealList: [Meal] = []
//
//    private let context: NSManagedObjectContext
//
//    init(context: NSManagedObjectContext) {
//           self.context = context
//           self.mealList = try! context.fetch(NSFetchRequest<Meal>(entityName: "Item"))
//       }
//
////    func createItem(item: MyItem) {
////        let newManagedItem = ManagedItem(context: self.context)
////        newManagedItem.property1 = item.property1 // etc...
////        try? self.context.save()
////        applyChanges() // this function should refetch data and assign it to the published itemList
////    }
//}
//
//lass TodoItemStorage: NSObject, ObservableObject {
//  @Published var dueSoon: [TodoItem] = []
//  private let dueSoonController: NSFetchedResultsController<TodoItem>
//
//  init(managedObjectContext: NSManagedObjectContext) {
//    dueSoonController = NSFetchedResultsController(fetchRequest: TodoItem.dueSoonFetchRequest,
//    managedObjectContext: managedObjectContext,
//    sectionNameKeyPath: nil, cacheName: nil)
//
//    super.init()
//
//    dueSoonController.delegate = self
//
//    do {
//      try dueSoonController.performFetch()
//      dueSoon = dueSoonController.fetchedObjects ?? []
//    } catch {
//      print("failed to fetch items!")
//    }
//  }
//}
//
//extension TodoItemStorage: NSFetchedResultsControllerDelegate {
//  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//    guard let todoItems = controller.fetchedObjects as? [TodoItem]
//      else { return }
//
//    dueSoon = todoItems
//  }
//}


class plannerVM: NSObject, ObservableObject {
    @Published var selectedMeal : Meal?
}
//  @Published var dueSoon: [Meal] = []
//  private let dueSoonController: NSFetchedResultsController<Meal>
//
//
//
//
//  init(managedObjectContext: NSManagedObjectContext) {
//    dueSoonController = NSFetchedResultsController(fetchRequest: Meal.dueSoonFetchRequest,
//    managedObjectContext: managedObjectContext,
//    sectionNameKeyPath: nil, cacheName: nil)
//
//    super.init()
//
//    dueSoonController.delegate = self
//
//    do {
//      try dueSoonController.performFetch()
//      dueSoon = dueSoonController.fetchedObjects ?? []
//    } catch {
//      print("failed to fetch items!")
//    }
//  }
//
//
//
//
//
//
//}
//
//extension plannerVM: NSFetchedResultsControllerDelegate {
//  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//    guard let meaalItems = controller.fetchedObjects as? [Meal]
//      else { return }
//
//    dueSoon = meaalItems
//  }
//}
//
//
//extension Meal {
//  static var dueSoonFetchRequest: NSFetchRequest<Meal> {
//    let request: NSFetchRequest<Meal> = Meal.fetchRequest()
//    request.predicate = NSPredicate(format: "dueDate < %@", Date() as CVarArg)
//    request.sortDescriptors = [NSSortDescriptor(key: "dueDate", ascending: true)]
//
//    return request
//  }
//}
