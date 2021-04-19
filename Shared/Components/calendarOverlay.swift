//
//  calendarOverlay.swift
//  shopping List (iOS)
//
//  Created by Andrew Miller on 11/04/2021.
//

import SwiftUI

struct calendarOverlay: View {
    var fetchRequest: FetchRequest<Meal>
    @AppStorage("theme", store: UserDefaults(suiteName: "group.Andrew-Miller.shoppingList")) var currentTheme: colorTheme = .green

    var body: some View {

        if(fetchRequest.wrappedValue.count > 0){
        
        HStack (alignment: .bottom, spacing: 4){
            Image("fork 2")
                .resizable()
                
                .frame(width: 7, height: 12)
            Text("x\(countOfMeals())")
                .interTextStyle(text: "Inter-SemiBold", size: 10, color: currentTheme.colors.accentColor)
                .layoutPriority(0)
            
            Spacer()
        }.foregroundColor(currentTheme.colors.accentColor)
        }
        }
    
    init(filter: Date){
        fetchRequest = FetchRequest<Meal>(entity: Meal.entity(), sortDescriptors: [],
            predicate: NSPredicate(format: "ANY meal.date ==%@", filter as CVarArg), animation: .default)
        
       
    }
    
    func countOfMeals() -> Int{
        var x = 0
        if(fetchRequest.wrappedValue.count > 0){
            for _ in fetchRequest.wrappedValue{
                x += 1
            }
           
        }
        
        return x
        }
        
        
    
}

struct calendarOverlay_Previews: PreviewProvider {
    static var previews: some View {
        calendarOverlay(filter: Date().midnight).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
