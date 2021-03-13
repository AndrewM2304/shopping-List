//
//  mealSelect.swift
//  shopping List (iOS)
//
//  Created by Andrew Miller on 17/01/2021.
//

import SwiftUI

struct mealSelect: View {
    @State private var dates = Date.newerDate()
    @AppStorage("theme") var currentTheme: colorTheme = .green

    @Environment(\.presentationMode) var presentationMode
    @Binding var selectDate : Array<Dates>
    
    @Environment(\.managedObjectContext) private var viewContext


    
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
    
    
    
    var body: some View {
        VStack (spacing: 15){
            navBarView(curved: false)
                .overlay(
                    Text("Select Meals")
                        .whiteTitleStyle()
                    
                )
                .overlay(
                    Capsule()
                        .fill(Color.white.opacity(0.6))
                            .frame(width: 30, height: 3)
                        .offset(y: -30)
                        )

            VStack (spacing: 15){
            HStack {
                Group {
                if(monthFormatter.string(from:dates[0].actualDate) == monthFormatter.string(from:dates[6].actualDate)){
                    Image(systemName: "calendar")
                    Text("\(dateFormatter.string(from:dates[0].actualDate)) - \(dateFormatter.string(from:dates[6].actualDate))")
                    Text(monthFormatter.string(from:dates[6].actualDate))
                
                } else {
                    
                        Image(systemName: "calendar")
                        
                        Text("\(dateFormatter.string(from:dates[0].actualDate)) \(monthFormatter.string(from:dates[0].actualDate)) - \(dateFormatter.string(from:dates[6].actualDate))")
                        Text(monthFormatter.string(from:dates[6].actualDate))
                }
                }.font(Font.title2.weight(.semibold))
                .foregroundColor(.primary)
                Spacer()
                Group{
                    Button(action: {
                        decrementDate()
//
                      
                    }, label: {
                        Image(systemName: "chevron.left")
                            .padding(15)
                            .foregroundColor(currentTheme.colors.mainColor)
                    })
                    Button(action: {
                        incrementDate()
//
                        
                    }, label: {
                        Image(systemName: "chevron.right")
                            .padding(15)
                            .foregroundColor(currentTheme.colors.mainColor)
                            
                    })
                }
                .padding(5)
                .font(Font.headline.weight(.semibold))
                .foregroundColor(.white)
            }
            .padding(.bottom, 5)
            
            ForEach(dates, id: \.self){ date in
                
                HStack (spacing: 10){
                    Text("\(dayFormatter.string(from:date.actualDate))")
                        .font(Font.body.weight(.semibold))
                        .frame(width: 30)
                    ForEach(mealTypeName.allCases, id: \.self){ value in

                        buttonMealView(meal: value, mealName: value.localizedName, date: date.actualDate, selectDatePicker: $selectDate)
                        
                        Spacer()
                        
                    }
                }.frame(maxWidth: .infinity)
            }
            
            Button(action: {presentationMode.wrappedValue.dismiss()}, label: {
                Text("Save")
                    
            }) .buttonStyle(primaryButtonStyle())
            .padding(.top, 20)

        }
            .padding()
            Spacer()
        }

    }
    func incrementDate(){
        let Mon = Calendar.current.date(byAdding: .day, value: 7, to: dates[0].actualDate)!
        self.dates[0].actualDate = Mon;
        
        let Tue = Calendar.current.date(byAdding: .day, value: 7, to: dates[1].actualDate)!
        self.dates[1].actualDate = Tue
        
        let Wed = Calendar.current.date(byAdding: .day, value: 7, to: dates[2].actualDate)!
        self.dates[2].actualDate = Wed
        
        let Thu = Calendar.current.date(byAdding: .day, value: 7, to: dates[3].actualDate)!
        self.dates[3].actualDate = Thu
        
        let Fri = Calendar.current.date(byAdding: .day, value: 7, to: dates[4].actualDate)!
        self.dates[4].actualDate = Fri
        
        let Sat = Calendar.current.date(byAdding: .day, value: 7, to: dates[5].actualDate)!
        self.dates[5].actualDate = Sat
        
        let Sun = Calendar.current.date(byAdding: .day, value: 7, to: dates[6].actualDate)!
        self.dates[6].actualDate = Sun
    }
    
    
    func decrementDate(){
        let Mon = Calendar.current.date(byAdding: .day, value: -7, to: dates[0].actualDate)!
        self.dates[0].actualDate = Mon;
        
        let Tue = Calendar.current.date(byAdding: .day, value: -7, to: dates[1].actualDate)!
        self.dates[1].actualDate = Tue
        
        let Wed = Calendar.current.date(byAdding: .day, value: -7, to: dates[2].actualDate)!
        self.dates[2].actualDate = Wed
        
        let Thu = Calendar.current.date(byAdding: .day, value: -7, to: dates[3].actualDate)!
        self.dates[3].actualDate = Thu
        
        let Fri = Calendar.current.date(byAdding: .day, value: -7, to: dates[4].actualDate)!
        self.dates[4].actualDate = Fri
        
        let Sat = Calendar.current.date(byAdding: .day, value: -7, to: dates[5].actualDate)!
        self.dates[5].actualDate = Sat
        
        let Sun = Calendar.current.date(byAdding: .day, value: -7, to: dates[6].actualDate)!
        self.dates[6].actualDate = Sun
    }
}

struct mealSelect_Previews: PreviewProvider {
    @State static var hide = false
    @State static var selectDate: [Dates] = []
    static var viewContext = PersistenceController.preview.container.viewContext

    static var previews: some View {
        let newMeal = Meal(context:viewContext)
        newMeal.mealName = "burgers"
        newMeal.mealLink = "www.google.com"
        newMeal.mealNotes = "Lorem Ipsum"

        
        
        let newDate = Dates(context:viewContext)
        newDate.date = Date()
        newDate.meal = Meal(context: viewContext)
        
        let newIngredient = Ingredients(context: viewContext)
        newIngredient.ingredientName = "Ing 1"
        newIngredient.ingredientQuantity = 1
        newIngredient.isChecked = false
        newIngredient.isSelected = true
        newIngredient.ingredientMeasurement = "kilo"
        
        return mealSelect(selectDate: $selectDate).environment(\.managedObjectContext, viewContext)
    }
}


struct buttonMealView: View {
    @AppStorage("theme") var currentTheme: colorTheme = .green
    @State var meal:mealTypeName
    @State var mealName:LocalizedStringKey
    @State var tapped = false
    @State var date: Date
    @Environment(\.managedObjectContext) private var viewContext

    
    @Binding var selectDatePicker : Array<Dates>
    var body: some View {

        
        Button(action: {
            
            if(tapped == false){
            addDate()
            } else{
                delete()
            }
            
            self.tapped.toggle()
                
        }, label: {
            Text(mealName)
        })
               
                   
    }
    
    func addDate(){
        let newDate = Dates(context: self.viewContext)
       
            newDate.date = date
            newDate.mealTypeNameStatus = meal.self
            selectDatePicker.append(newDate)
        }
        
       
        
    
           
    func delete(){
        selectDatePicker.removeAll{ value in
            return value.mealTypeNameStatus == meal.self && value.date == date
        }
    }
    
    
    
    
    
}



