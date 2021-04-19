//
//  filteresMealsView.swift
//  shopping List (iOS)
//
//  Created by Andrew Miller on 19/04/2021.
//

import SwiftUI

struct filteredMealsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    var fetchRequest: FetchRequest<Meal>
    var selectedDate: Date
    var planVM: plannerVM
    @Binding var addMealPopup: Bool
    @State var deletedMeal : Meal?
    @Binding var showingAlert: Bool
    var body: some View {
        ForEach(sortmyArray(meal: fetchRequest.wrappedValue)){ mealItem in
            mealCardView(mealItem: mealItem, selectedDate: selectedDate, dateRemove: {
                self.showingAlert.toggle()
                self.deletedMeal = mealItem
                
            }, editItem: {editItem(mealItem: mealItem)})
            .actionSheet(isPresented: $showingAlert) {
                ActionSheet(title: Text("Delete \(deletedMeal!.wrappedMealName)"),
                            message: Text("Deleting meal will remove the meal and linked ingredients from your devices permenantly "),buttons: [
                                .destructive(Text("Remove meal from this date")){removeDate(selectedDate: selectedDate, meal: deletedMeal!, dateArray: deletedMeal!.dateArray)},
                                .destructive(Text("Delete meal permenantly")){
                                    deleteMeal(meal: deletedMeal!)
                                },
                                .cancel()
                            ])
            }
            
        }
        
    }
    
    init(selectedDate: Date, addMealPopup: Binding<Bool>, planVM: plannerVM, deletedMeal: Meal?, showingAlert: Binding<Bool>){
        
        fetchRequest = FetchRequest<Meal>(entity: Meal.entity(), sortDescriptors: [],
                                          predicate: NSPredicate(format: "ANY meal.date ==%@", selectedDate as CVarArg), animation: .default)
        self.selectedDate = selectedDate
        _addMealPopup = addMealPopup
        self.planVM = planVM
        _showingAlert = showingAlert
        
    }
    
    
    func sortmyArray(meal:FetchedResults<Meal> ) -> [Meal]{
        let myMeal = meal.sorted(by: {$0.dateArray[0].sortedOrder < $1.dateArray[0].sortedOrder})
        return myMeal
    }
    func editItem(mealItem: Meal){
        self.planVM.selectedMeal = mealItem
        self.addMealPopup.toggle()
        
    }
    func deleteMeal(meal:Meal){
        viewContext.delete(meal)
        do {
            
            try viewContext.save()
            
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            print(nsError)
        }
    }
    
    func removeDate(selectedDate: Date, meal: Meal, dateArray: [Dates]) {
        let myArray = dateArray.filter { $0.date == selectedDate }
        
        meal.removeFromMeal(NSSet(array: myArray))
        deletedMeal = nil
        print( "removed \(meal.wrappedMealName) ")
        do {
            
            try viewContext.save()
            
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            print(nsError)
        }
    }
    
    
}

struct filteredMealsView_Previews: PreviewProvider {
    @State static var selectedDate = Date().midnight
    static var planM = plannerVM()
    @State static var mealPopup = false
    @State static var showAlert = false
    static var previews: some View {
        filteredMealsView(selectedDate: selectedDate, addMealPopup: $mealPopup, planVM: planM, deletedMeal: Meal(), showingAlert: $showAlert).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
