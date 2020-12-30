//
//  shopping_ListApp.swift
//  Shared
//
//  Created by Andrew Miller on 30/12/2020.
//

import SwiftUI

@main
struct shopping_ListApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
