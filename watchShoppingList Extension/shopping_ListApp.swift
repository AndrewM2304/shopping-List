//
//  shopping_ListApp.swift
//  watchShoppingList Extension
//
//  Created by Andrew Miller on 04/04/2021.
//

import SwiftUI

@main
struct shopping_ListApp: App {
    
    let persistenceController = PersistenceController.shared

    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
