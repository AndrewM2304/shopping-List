//
//  plannerVM.swift
//  shopping List
//
//  Created by Andrew Miller on 24/03/2021.
//

import SwiftUI
import CoreData
import Foundation


class plannerVM: NSObject, ObservableObject {
    @Published var selectedMeal : Meal?
}

