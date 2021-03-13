//
//  mealCardView.swift
//  shopping List
//
//  Created by Andrew Miller on 03/01/2021.
//

import SwiftUI
import CoreData

struct mealCardView: View {
    @AppStorage("theme") var currentTheme: colorTheme = .green
    @Environment(\.managedObjectContext) private var viewContext
    var mealItem: Meal
    @Binding  var selectedDate : Date
    
    let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        
        return formatter
    }()
    @State private var dragOffset = CGSize.zero
    
    
    var body: some View {
        
        ZStack{
            colored()
            HStack{
                Image(systemName: "square.and.pencil").foregroundColor(Color(#colorLiteral(red: 0.137254902, green: 0.3058823529, blue: 0.0862745098, alpha: 1)))
                Spacer()
                Image(systemName: "trash.fill").foregroundColor(Color(#colorLiteral(red: 0.6784313725, green: 0.07058823529, blue: 0.07058823529, alpha: 1)))

            }
            .font(.headline)
            .padding(40)

            VStack (alignment: .leading, spacing: 2){
                
                HStack (spacing:10){
                    ZStack{
                        
                        Circle()
                            .foregroundColor(currentTheme.colors.mainColor)
                            .frame(width: 34, height:34)
                    Image("fork 2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height:20)
                        .foregroundColor(Color("CardBackground"))
                        
                    }
                        
                VStack (alignment: .leading, spacing: 0){
                    Text(mealItem.wrappedMealName)
                        .font(.headline)
                        .foregroundColor(.primary)
                    ForEach(mealItem.dateArray){ date in
                        
                        if(itemFormatter.string(from: selectedDate) == itemFormatter.string(from: date.date!)){
                            VStack {
                                Text(date.mealType!.uppercased())
                                    .font(.footnote)
                                    .fontWeight(.bold)
                                    .foregroundColor(currentTheme.colors.mainColor)
                            }
                        }
                    }
                }
                
                .padding(.bottom, 5)
                    Spacer(minLength: 20)
                    Image(systemName: "chevron.right")
                        .font(.headline)
                        .foregroundColor(currentTheme.colors.mainColor)
                }
                Divider()
                    .padding(.vertical, 10)
                if(mealItem.wrappedMealNotes != ""){
                    Text(mealItem.wrappedMealNotes).lineLimit(3)
                        .foregroundColor(.secondary)
                        .font(.subheadline)
                }
            }
        .cardStyle()
            .padding(.horizontal, 10)
        .offset(x: dragOffset.width)
            .gesture(DragGesture()
                        .onChanged{ value in
                            
                            if(value.translation.width < 120 && value.translation.width > -120){
                self.dragOffset = value.translation
                            }
                            
            }
                        .onEnded{ value in
                            self.dragOffset = CGSize.zero
                        }
            )
            .animation(.spring())
        }
    }
    
    
    func colored() -> Color{
        if (self.dragOffset.width > 0){
            return Color(#colorLiteral(red: 0.737254902, green: 0.831372549, blue: 0.7568627451, alpha: 1)).opacity(0 + Double(abs(dragOffset.width / 120)))
        } else{
            return Color(#colorLiteral(red: 0.9058823529, green: 0.7098039216, blue: 0.7215686275, alpha: 1)).opacity(0 + Double(abs(dragOffset.width / 120)))
        }
    }
    
}


struct mealCardView_Previews: PreviewProvider {
    @State static var prevDate = Date()
    
    static var viewContext = PersistenceController.preview.container.viewContext
    
    static var previews: some View {
        
        let newIngredient = Ingredients(context: viewContext)
        newIngredient.ingredientName = "Ing 1"
        newIngredient.ingredientQuantity = 1
        newIngredient.isChecked = false
        newIngredient.isSelected = true
        newIngredient.ingredientMeasurement = "kilo"
        
        let newIngredient2 = Ingredients(context: viewContext)
        newIngredient2.ingredientName = "Ing 1"
        newIngredient2.ingredientQuantity = 1
        newIngredient2.isChecked = false
        newIngredient2.isSelected = true
        newIngredient2.ingredientMeasurement = "kilo"
        
        
        
        
        let newDate = Dates(context:viewContext)
        newDate.date = Date()
        newDate.meal = Meal(context: viewContext)
        newDate.mealTypeNameStatus = .lunch
        
        let newMeal = Meal(context:viewContext)
        newMeal.mealName = "burgers and chips"
        newMeal.mealLink = "www.google.com"
        newMeal.mealNotes = "Lorem Ipsum dolat amit this is a really long note what will it look like on the screen over 3 pages? Wow this is actually super long I need to type more"
        newMeal.myIngredientList = [newIngredient, newIngredient2]
        newMeal.meal = [newDate, newDate]
        
        return mealCardView(mealItem: newMeal, selectedDate: $prevDate).environment(\.managedObjectContext, viewContext)
    }
}
