//
//  addMealVM.swift
//  shopping List (iOS)
//
//  Created by Andrew Miller on 07/02/2021.
//

import SwiftUI
import CoreData

class addMealViewModel: ObservableObject{

    //meal items
    var mealObject: Meal?
     var mealName = ""
     var mealUrl = ""
     var mealNotes = ""
    @Published var mealType = mealTypeName(rawValue: "")
    
    //ingredient items
    @Published var ingredientObject: Ingredients?
    @Published var ingredientList : [Ingredients] = []
    @Published var selectedIngredient : Ingredients?
    @Published var isSelected = true
    @Published var isChecked = true
    @Published var ingredientName = ""
    @Published var ingredientQuant: Int64 = 1
    @Published var enumSwitch = ingredientTypeName.allCases
    
    
    //date items
    @Published var dateList : [Dates] = []
    @Published  var dates = Date.newerDate()
    
    var monthFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter
    }
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }
    var dayFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEEE"
        return formatter
    }
    
    //ui alert items
    @Published var alertMessageTitle = ""
    @Published var alertMessageBody = ""
    @Published var alertMsg = String()
    @Published var showAlert = false


    @Environment(\.managedObjectContext) var managedObjectContext

    
    init() {
//        mealObject = Meal(context: managedObjectContext)
        selectedIngredient = Ingredients(context: managedObjectContext)
        ingredientObject = Ingredients(context: managedObjectContext)
    }
    
    func addIngredients(managedObjectContext: NSManagedObjectContext, myIngredientName: String, myarray: Array<Any>) {
        withAnimation {
            if(!myIngredientName.isEmpty){
                
                let newIngredient = Ingredients(context: managedObjectContext)
                newIngredient.isChecked = false
                newIngredient.ingredientName = myIngredientName
                newIngredient.isSelected = true
                newIngredient.ingredientQuantity = 1
                newIngredient.ingredientTypeNameStatus = .items
                newIngredient.ingredientMeasurement = "Item"
                ingredientList.append(newIngredient)
                print("this has worked")
            }
        }
        
    }
    

        
    
    func addDate(managedObjectContext: NSManagedObjectContext, dateEntry: Date, mealtypeEntry: mealTypeName) {
        withAnimation {
            
            let newDate = Dates(context: managedObjectContext)
            newDate.date = dateEntry
            newDate.mealTypeNameStatus = mealtypeEntry
            
            if(!dateList.contains(newDate)){
            dateList.append(newDate)
                print("this has worked")
            } else{
                print("this is a duplcate")
            }
            do {
               
                try managedObjectContext.save()
                print(" saved successfully")
            } catch { alertMsg = "\(error)"; showAlert = true }
            
        }
        
    }
        
    
    func saveMeal(managedObjectContext: NSManagedObjectContext, myMealName: String) {
        
        if myMealName.isEmpty{
            alertMsg = "No Meal Name Entered"; showAlert = true
            return
        }
        
        
        if myMealName == ""{
            alertMsg = "No Meal Name Entered"; showAlert = true
            return
        }
        
        if dateList.isEmpty{
            alertMsg = "No Dates Selected"; showAlert = true
            return
        }
            
        let meal: Meal
        if mealObject != nil {
            meal = mealObject!
            managedObjectContext.delete(meal)
        }
        
         let   newMeal = Meal(context: managedObjectContext)
        
        newMeal.mealLink = mealUrl
        newMeal.mealNotes = mealNotes
        newMeal.mealName = myMealName
        newMeal.addToMyIngredientList(NSSet(array: ingredientList))
        print("after ingredients")
        newMeal.addToMeal(NSSet(array: dateList))
        print("after meal")
        do {
           
            try managedObjectContext.save()
            print(" saved successfully")
        } catch { alertMsg = "\(error)"; showAlert = true }
    }
    
    
    func decrementDate(){
        for index in 0...6 {
          let thisDay =   Calendar.current.date(byAdding: .day, value: -7, to: dates[index].actualDate)!
            self.dates[index].actualDate = thisDay;
        }
        
    }
    
    func incrementDate(){
        
        for index in 0...6 {
          let thisDay =   Calendar.current.date(byAdding: .day, value: 7, to: dates[index].actualDate)!
            self.dates[index].actualDate = thisDay;
        }
    }
    
    
}



