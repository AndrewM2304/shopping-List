//
//  leftover.swift
//  shopping List (iOS)
//
//  Created by Andrew Miller on 11/01/2021.
//

//import Foundation
//
//
//private func addItem() {
//    withAnimation {
//        if(!ingredient.isEmpty){
//        let newItem = Ingredients(context: viewContext)
//        newItem.item = ingredient
//            newItem.date = Date().startOfWeek
//
//        do {
//
//            try viewContext.save()
//            self.ingredient = ""
//        } catch {
//            // Replace this implementation with code to handle the error appropriately.
//            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//        }
//    }
//    }
//}
//
//
//ForEach(listingredients){ item in
//
//    HStack{
//        Text(item.item ?? "")
//
//
//    }
//}
//
//
//@FetchRequest(
//    sortDescriptors: [NSSortDescriptor(keyPath: \Ingredients.item, ascending: true)],
//    animation: .default)
//private var listingredients: FetchedResults<Ingredients>


//private func deleteItems(offsets: IndexSet) {
//    withAnimation {
//        offsets.map { listingredients[$0] }.forEach(viewContext.delete)
//
//        do {
//            try viewContext.save()
//        } catch {
//            // Replace this implementation with code to handle the error appropriately.
//            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//        }
//    }
//}
