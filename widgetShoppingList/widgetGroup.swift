//
//  widgetGroup.swift
//  shopping List
//
//  Created by Andrew Miller on 13/04/2021.
//

import SwiftUI
import WidgetKit

@main
struct groupedWidgets: WidgetBundle {
    var body: some Widget{
        widgetIngredientList()
        widgetShoppingList()
    }
}
