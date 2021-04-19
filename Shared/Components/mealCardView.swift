//
//  mealCardView.swift
//  shopping List
//
//  Created by Andrew Miller on 03/01/2021.
//

import SwiftUI
import CoreData

struct mealCardView: View {
     @AppStorage("theme", store: UserDefaults(suiteName: "group.Andrew-Miller.shoppingList")) var currentTheme: colorTheme = .green
    @Environment(\.managedObjectContext) private var viewContext
    var mealItem: Meal
    var selectedDate : Date
    @State var isTapped = false
    var dateRemove: () -> Void
    var editItem: () -> Void
    
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
                HStack{
                    
                    Image(systemName: "square.and.pencil")
                    Text("Edit")
                }.foregroundColor(Color(#colorLiteral(red: 0.2784313725, green: 0.862745098, blue: 0.5254901961, alpha: 1)))
                
                Spacer()
                HStack{
                    Image(systemName: "trash.fill")
                    Text("Delete")
                }
                .foregroundColor(Color(#colorLiteral(red: 0.8588235294, green: 0.168627451, blue: 0.4666666667, alpha: 1)))
                
            }
            .opacity((dragOffset == .zero) ? 0 : 1)
            .font(.headline)
            .padding(20)
            
            
            VStack (alignment: .leading, spacing: 2){
                
                if(isTapped == false){
                VStack (alignment: .leading, spacing: 0){
                VStack (alignment: .leading, spacing: 0){
                    Text(mealItem.wrappedMealName)
                        .interTextStyle(text: "Inter-ExtraBold", size: 22, color: Color.white)
                        .padding(.bottom, 5)
                    ForEach(mealItem.dateArray){ date in
                        
                        if(itemFormatter.string(from: selectedDate) == itemFormatter.string(from: date.date!)){
                            VStack {
                                Text(date.mealType!.uppercased())
                                    .interTextStyle(text: "Inter-ExtraBold", size: 13, color: currentTheme.colors.mainColor)
                                    
                            }
                        }
                    }
                }
                
                .padding(.bottom, 5)
                
                Rectangle()
                    .fill(currentTheme.colors.gradient)
                    .frame(height:1)
                    .padding(.vertical, 10)
                
                VStack (alignment: .leading, spacing: 10){
                    HStack (alignment: .top){
                        Image(systemName: "list.bullet")
                            .foregroundColor(Color.white.opacity(0.6))
                            .font(.custom("Inter-Medium", size: 15))
                            .padding(.top, 2)
                        Text("\(mealItem.ingredientArray.count) ingredients ")
                            .interTextStyle(text: "Inter-Medium", size: 15, color: Color.white.opacity(0.6))
                        
                    }
                    
                    
                    HStack (alignment: .top){
                        Image(systemName: "note.text")
                            .foregroundColor(Color.white.opacity(0.6))
                            .font(.custom("Inter-Medium", size: 15))
                            .padding(.top, 2)
                        if(mealItem.wrappedMealNotes != ""){
                            Text(mealItem.wrappedMealNotes)
                                .interTextStyle(text: "Inter-Medium", size: 15, color: Color.white.opacity(0.6))
                                .lineLimit(3)
                        } else {
                            Text("No meal notes saved")
                                .interTextStyle(text: "Inter-Medium", size: 15, color: Color.white.opacity(0.6))
                        }
                    }
                }
                }.opacity(isTapped ? 0 : 1)
                
              
                    
            } else{
                    VStack (alignment: .center, spacing: 0){
                    VStack (alignment: .leading, spacing: 0){
                        Text(mealItem.wrappedMealName)
                            .interTextStyle(text: "Inter-ExtraBold", size: 22, color: Color.white)
                            .padding(.bottom, 20)

                    }
                        mealCardListItem(image: "safari", title: "Link to recipe")
                    
                        VStack (alignment: .leading){
                            
                            

                        VStack (alignment: .leading, spacing: 10){
                            
                           
                            
                            if(mealItem.wrappedMealLink != ""){
                                Link(mealItem.wrappedMealLink, destination: URL(string: addHttps(link: mealItem.wrappedMealLink))!)
                                    .font(.custom("Inter-SemiBold", size: 15))
                                    .foregroundColor(currentTheme.colors.accentColor)

                            } else{
                                Text("No recipe link added").interTextStyle(text: "Inter-SemiBold", size: 15, color: Color.white.opacity(0.6))
                                }
                                
                            }
                        .padding(.horizontal, 10)
                        .padding(.bottom, 20)
                            
                            
                                mealCardListItem(image: "note.text", title: "Recipe Notes")
                            VStack{
                                if(mealItem.wrappedMealNotes != ""){
                                    Text(mealItem.wrappedMealNotes)
                                        .interTextStyle(text: "Inter-Medium", size: 15, color: Color.white.opacity(0.6))
                                        .lineLimit(3)
                                } else {
                                    Text("No meal notes saved")
                                        .interTextStyle(text: "Inter-Medium", size: 15, color: Color.white.opacity(0.6))
                                }
                            }
                            .padding(.horizontal, 10)
                                
                            .padding(.bottom, 20)
                            
                            mealCardListItem(image: "list.bullet", title: "ingredient list")
                            
                            if(mealItem.ingredientArray.count > 0){
                                VStack (alignment: .leading, spacing: 10){
                                    
                                    ForEach(mealItem.ingredientArray){ item in
                                        VStack (alignment: .leading, spacing: 2){
                                            Text(item.wrappedIngredientName)
                                                .interTextStyle(text: "Inter-SemiBold", size: 15, color: Color.white)
                                                .lineLimit(1)
                                            HStack (spacing: 5){
                                                Text("Quantity: \(item.ingredientQuantity)")
                                                    .interTextStyle(text: "Inter-Medium", size: 14, color: Color.white.opacity(0.6))
                                                if(item.ingredientMeasurement == "Items"){
                                                    Text("")
                                                } else{
                                                    Text(item.ingredientMeasurement!)
                                                        .interTextStyle(text: "Inter-Medium", size: 14, color: Color.white.opacity(0.6))
                                                }
                                                
                                            }
                                            .padding(.bottom, 10)
                                            Divider()
                                        }
                                    }
                                    
                                }
                                .padding(.horizontal, 10)
                            
                            } else {

                                    Text("No ingredients added")
                                        .interTextStyle(text: "Inter-Regular", size: 15, color: Color.white.opacity(0.6))
                                        .padding(.horizontal, 10)
                                        .padding(.bottom, 20)
                            }
                            mealCardListItem(image: "\(mealItem.dateArray.count).circle", title: "Meal Count")
                            
                                HStack (spacing: 10){
                                
                                Text("You have eaten this meal \(mealItem.dateArray.count) times!")
                                    .interTextStyle(text: "Inter-Regular", size: 15, color: Color.white.opacity(0.6))
                                    .padding(.horizontal, 10)
                            }
                            
          
                        
                    }
                        
                      
                        
                }
                    .opacity(isTapped ? 1 : 0)
                    .rotation3DEffect(Angle(degrees: isTapped ? 180 : 0), axis: (x: 0.0, y: 10.0, z: 0.0))
                }
            }
            .padding(20)
            .backgroundGradient(isTapped: isTapped, gradient: currentTheme.colors.gradient, color: currentTheme.colors.accentColor.opacity(0.1))
            
            .rotation3DEffect(Angle(degrees: isTapped ? 180 : 0), axis: (x: 0.0, y: 10.0, z: 0.0))
            .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 2)
            .padding(.horizontal, 20)
            
            .offset(x: dragOffset.width)
            .onTapGesture {
                withAnimation (.easeInOut){
                self.isTapped.toggle()
                }
            }
            .gesture(DragGesture()
                        .onChanged{ value in
                            
                            withAnimation(.spring()){
                                self.dragOffset = value.translation
                                
                            }
   
                        }
                        .onEnded{ value in
                            withAnimation(.spring()){
                            if (value.translation.width > 200){
                                self.dragOffset = CGSize.zero
                                    editItem()
                                
                            } else if(value.translation.width < -200){
                                self.dragOffset = CGSize.zero
                                    dateRemove()
                            } else {
                                self.dragOffset = CGSize.zero
                            }
                                
                            }
                            
                        }
            )
            
            

        }
    }
    
    
    func colored() -> Color{
        if (self.dragOffset.width > 0){
            return Color(#colorLiteral(red: 0.09019607843, green: 0.1843137255, blue: 0.1450980392, alpha: 1)).opacity(0 + Double(abs(dragOffset.width / 180)))
        } else{
            return Color(#colorLiteral(red: 0.1647058824, green: 0.06274509804, blue: 0.1137254902, alpha: 1)).opacity(0 + Double(abs(dragOffset.width / 180)))
        }
    }
    func addHttps(link: String) -> String{
        if(link.contains("https") || link.contains("HTTPS")){
            return link
        } else {
            return "https://"+link
        }
    }
    
}


struct mealCardView_Previews: PreviewProvider {
     static var prevDate = Date()
    
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
        newMeal.mealNotes = ""
        newMeal.myIngredientList = [newIngredient, newIngredient2]
        newMeal.meal = [newDate, newDate]
        
        return mealCardView(mealItem: newMeal, selectedDate: prevDate, isTapped: false, dateRemove: {}, editItem: {}).environment(\.managedObjectContext, viewContext)
    }
}
