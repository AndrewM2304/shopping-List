//
//  selectMealButtonView.swift
//  shopping List (iOS)
//
//  Created by Andrew Miller on 08/02/2021.
//

import SwiftUI

struct selectMealButtonView: View {
    @ObservedObject var addDate : addMealViewModel
    @Environment(\.managedObjectContext) private var viewContext
     @AppStorage("theme", store: UserDefaults(suiteName: "group.Andrew-Miller.shoppingList")) var currentTheme: colorTheme = .green
    var date: Date
    var delete = false
    
    
    var mealName: LocalizedStringKey
    var mealtype: mealTypeName
    var body: some View {
        
        
        Button(action: {vibratePress();   delete ? addDateLocal() : deleteDate()
        }, label: {
            Text(mealName)
                .font(.custom("Inter-ExtraBold", size: 13))
                .lineLimit(nil)
                .padding(.vertical, 11)
                .frame(minWidth: 80)
                .foregroundColor(.white )
                .background(delete ? (LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1215686275, green: 0.1490196078, blue: 0.168627451, alpha: 1)), Color(#colorLiteral(red: 0.07058823529, green: 0.1137254902, blue: 0.137254902, alpha: 1))]), startPoint: .leading, endPoint: .trailing)) : currentTheme.colors.gradient )
                .cornerRadius(8)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.white.opacity(0.08) , lineWidth: 1))
        }).buttonStyle(popButtonStyle())
        
    }
    func deleteDate(){
//        // this removes anything from locally created date list, but not if it is an existing date
        addDate.dateList.removeAll{ value in
            return (value.mealTypeNameStatus.localizedName == mealtype.localizedName) && (value.date == date);
        }
        do {
           
            try viewContext.save()
            print(" saved successfully")
        } catch { print(error) }
        
    }
    
    func addDateLocal(){
        addDate.addDate( managedObjectContext: viewContext, dateEntry: date, mealtypeEntry: mealtype)
    }
}

struct selectMealButtonView_Previews: PreviewProvider {
    static var name: LocalizedStringKey = "breakfast"
    static var vm = addMealViewModel()
    static var mealtype: mealTypeName = .breakfast
    static var date = Date()
    static var previews: some View {

        Group {
            selectMealButtonView(addDate: vm, date: date, delete: true, mealName: name, mealtype:mealtype)
                .preferredColorScheme(.dark)
            
        }
            
        
    }
}
