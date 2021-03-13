//
//  existingMealsView.swift
//  shopping List (iOS)
//
//  Created by Andrew Miller on 26/01/2021.
//

import SwiftUI


struct existingMealsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.openURL) var openURL
    @AppStorage("theme") var currentTheme: colorTheme = .green
    @State var meal: Meal
    @State var show = false
    @State var viewing = 0
    @State var showOverlay = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var selectedDate: Date
    
    
    var body: some View {
        
        
        
        VStack {
            navBarView(curved: false)
                
                .overlay(
                    Text(meal.wrappedMealName)
                        .multilineTextAlignment(.center)
                        .lineLimit(12)
                        .frame(maxWidth:200)
                        .font(Font.body.weight(.bold))
                        .foregroundColor(Color.white).padding(.top, 40)
                    
                )
                .overlay(
                    HStack{
                        Spacer()
                        Menu{
                            
                            Text("Menu Item 2")
                            Text("Menu Item 3")
                            Divider()
                            Button(action: {removeit()}, label: {
                                Text("Remove Meal").foregroundColor(.red)
                            })
                            Button(action: {deleteit()}, label: {
                                Text("DeleteMeal").foregroundColor(.red)
                            })
                        }
                        label: {
                            Image(systemName: "ellipsis.circle").foregroundColor(.white)
                                .padding()
                        }
                    }.padding(.top, 30)
                    
                )
                .overlay(
                    HStack{
                        Button(action: {presentationMode.wrappedValue.dismiss()}, label: {
                            Label("Back", systemImage: "chevron.left")
                                .padding()
                                .foregroundColor(.white)
                                .font(Font.subheadline.weight(.semibold))
                        })
                        Spacer()
                        
                    }.padding(.top, 40)
                    
                )
            ScrollView{
                
                VStack (alignment: .leading){
                HStack {
                    Image(systemName: "link")
                    Text("Link to recipe".uppercased()).foregroundColor(Color.primary)
                        
                    Spacer()
                }.font(Font.caption.weight(.medium))
                .padding(10)
                .padding(.horizontal, 5)
                .background(Color("section"))
                VStack (alignment: .leading, spacing: 10){
                    
                   
                    
                    if(meal.wrappedMealLink != ""){
//                        Button("Visit Apple") {
//                            openURL(URL(string: "https://\(meal.wrappedMealLink)")!)
//                        }
//                        Button("Visit Apple2") {
//                            openURL(URL(string: meal.wrappedMealLink)!)
                        
                        Button(action: {openURL(URL(string: "https://\(meal.wrappedMealLink)")!)}, label: {

                                Text(meal.wrappedMealLink).underline().bold().foregroundColor(.primary)
                        })
                        
                    } else{
                            Text("No recipe link added").foregroundColor(.secondary)
                        }
                        
                    }
                .padding(.horizontal, 10)
                .padding(.bottom, 20)
                    
                    VStack (alignment: .leading){
                    HStack {
                        Image(systemName: "note.text")
                        Text("Recipe Notes".uppercased()).foregroundColor(Color.primary)
                            
                        Spacer()
                    }.font(Font.caption.weight(.medium))
                    .padding(10)
                    .padding(.horizontal, 5)
                    .background(Color("section"))
                    VStack{
                    if(meal.mealNotes != ""){
                        
                        Text(meal.wrappedMealNotes).foregroundColor(.secondary)
                        
                    } else{
                            Text("No recipe link added").foregroundColor(.secondary)
                        }
                    }
                    .padding(.horizontal, 10)
                        
                    }.padding(.bottom, 20)
                    
                    
                    HStack {
                        Image(systemName: "list.bullet")
                        Text("Ingredient List".uppercased()).foregroundColor(Color.primary)
                        Text("\(viewing)").opacity(0)
                        Spacer()
                    }.font(Font.caption.weight(.medium))
                    .padding(10)
                    .padding(.horizontal, 5)
                    .background(Color("section"))
                    
                    if(meal.ingredientArray.count > 0){
                        VStack (alignment: .leading, spacing: 10){
                            
                            ForEach(meal.ingredientArray){ item in
                                VStack (alignment: .leading, spacing: 0){
                                    Text(item.wrappedIngredientName)
                                        .font(.subheadline)
                                        .bold()
                                        .foregroundColor(.primary)
                                        .lineLimit(1)
                                    HStack (spacing: 2){
                                        Text("Quantity: \(item.ingredientQuantity)")
                                        
                                        if(item.ingredientMeasurement == "Items"){
                                            Text("")
                                        } else{
                                            Text(item.ingredientMeasurement!)
                                        }
                                        
                                    }.font(.caption)
                                    .foregroundColor(.secondary)
                                    .padding(.bottom, 10)
                                    Divider()
                                }
                            }
                            
                        }
                        .padding(.horizontal, 10)
                        .padding(.bottom, 20)
                    } else {

                            Text("No ingredients added").foregroundColor(.secondary)
                                .padding(.horizontal, 10)
                    }
                    
                    HStack {
                        Image(systemName: "calendar.badge.clock")
                        Text("Meal Count".uppercased()).foregroundColor(Color.primary)
                          
                        Text("\(viewing)").opacity(0)
                        Spacer()
                    }
                    .font(Font.caption.weight(.medium))
                    .padding(10)
                    .padding(.horizontal, 5)
                    .background(Color("section"))
                    
                    VStack (alignment: .leading, spacing: 10){
                        HStack (spacing: 10){
                        
                        Text("You have eaten this meal \(meal.dateArray.count) times!").foregroundColor(.secondary)
                            .padding(.horizontal, 10)
                    }
                    .padding(.bottom, 20)
  
                }
            }
        }
           
    }
        .edgesIgnoringSafeArea(.vertical)
        .navigationBarHidden(true)
        Spacer()
      
}
    func openURL(_ urlString: String) {
        guard let url = URL(string: urlString) else {
            
            return
        }
        UIApplication.shared.open(url, completionHandler: { success in
            if success {
                print("opened")
            } else {
                print("failed")
                // showInvalidUrlAlert()
            }
        })
    }
    
    
    
    func deleteit(){
        viewContext.delete(self.meal)
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    
    
    func removeit(){
        var selected = [Dates]()
        for i in meal.dateArray{
            if (i.date == selectedDate){
                selected.append(i)
            }
        }
        DispatchQueue.main.async {
            meal.removeFromMeal(NSSet(array: selected))
            do {
                
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }

    }
}

struct existingMealsView_Previews: PreviewProvider {
    
    static var viewContext = PersistenceController.preview.container.viewContext
    @State static var selectedDate = Date()
    
    static var previews: some View {
        let newIngredient = Ingredients(context: viewContext)
        newIngredient.ingredientName = "Ing 1 very long title"
        newIngredient.ingredientQuantity = 1
        newIngredient.isChecked = false
        newIngredient.isSelected = true
        newIngredient.ingredientMeasurement = "kilo"
        
        let newIngredient2 = Ingredients(context: viewContext)
        newIngredient2.ingredientName = "Ing 1 very ling title"
        newIngredient2.ingredientQuantity = 1
        newIngredient2.isChecked = false
        newIngredient2.isSelected = true
        newIngredient2.ingredientMeasurement = "kilo"
        
        
        
        
        let newDate = Dates(context:viewContext)
        newDate.date = Date()
        newDate.meal = Meal(context: viewContext)
        newDate.mealTypeNameStatus = .lunch
        
        let newMeal = Meal(context:viewContext)
        newMeal.mealName = "burgers and chips but a logner name"
        newMeal.mealLink = "www.google.com"
        newMeal.mealNotes = "Lorem Ipsum dolat amit this is a really long note what will it look like on the screen over 3 pages? Wow this is actually super long I need to type more"
        newMeal.myIngredientList = [newIngredient, newIngredient2]
        newMeal.meal = [newDate, newDate]
        
        return  existingMealsView(meal:newMeal, selectedDate: $selectedDate)
    }
}
