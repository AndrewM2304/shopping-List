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
    @AppStorage("theme") var currentTheme: colorTheme = .green
    var date: Date
    var delete = false
    
    
    var mealName: LocalizedStringKey
    var mealtype: mealTypeName
    var body: some View {
        
        
        Button(action: {vibratePress();   delete ? addDateLocal() : deleteDate()
        }, label: {
            Text(mealName)
                .font(Font.footnote.weight(delete ? .regular : .medium))
                .padding(.vertical, 10)
                .frame(minWidth: 80)
                .foregroundColor(delete ? .secondary : .white )
                .background(delete ? Color("CardBackground") : currentTheme.colors.mainColor )
                .cornerRadius(8)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(delete ? Color.secondary.opacity(0.3) : currentTheme.colors.mainColor , lineWidth: 1))
                .shadow(color: Color("shadow").opacity( delete ? 0 : 0.2), radius: 8, x: 0.0, y: 2)
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
        selectMealButtonView(addDate: vm, date: date, delete: true, mealName: name, mealtype:mealtype)
            .preferredColorScheme(.dark)
    }
}
