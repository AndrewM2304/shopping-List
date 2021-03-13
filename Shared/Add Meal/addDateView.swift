//
//  addDateView.swift
//  shopping List (iOS)
//
//  Created by Andrew Miller on 08/02/2021.
//

import SwiftUI

struct addDateView: View {
    @ObservedObject var addDate : addMealViewModel
    @Environment(\.managedObjectContext) var managedObjectContext
    var body: some View {
        VStack(spacing: 12){
            
            
            HStack (spacing:15){
                Group{
                if(addDate.monthFormatter.string(from: addDate.dates[0].actualDate) == addDate.monthFormatter.string(from: addDate.dates[6].actualDate)) {
                    Image(systemName: "calendar")
                    Text("\(addDate.dateFormatter.string(from:addDate.dates[0].actualDate)) - \(addDate.dateFormatter.string(from:addDate.dates[6].actualDate))")
                    Text(addDate.monthFormatter.string(from:addDate.dates[6].actualDate))
                } else {
                    Image(systemName: "calendar")
                    
                    Text("\(addDate.dateFormatter.string(from:addDate.dates[0].actualDate)) \(addDate.monthFormatter.string(from:addDate.dates[0].actualDate)) - \(addDate.dateFormatter.string(from:addDate.dates[6].actualDate))")
                    Text(addDate.monthFormatter.string(from:addDate.dates[6].actualDate))
                }
                }
                Spacer()
                Group{
                Button(action: {addDate.decrementDate()}, label: {
                    Image(systemName: "chevron.left")
                })
                
                Button(action: {addDate.incrementDate()}, label: {
                    Image(systemName: "chevron.right")
                })
                }
                .padding(10)
                .foregroundColor(.primary)
                .background(Color.secondary.opacity(0.15))
                .clipShape(Circle())
                
                
                
            }  
            
            ForEach(addDate.dates, id: \.self){ date in
                
                HStack (spacing: 10){
                    Text("\(addDate.dayFormatter.string(from:date.actualDate))")
                        .font(Font.body.weight(.semibold))
                        .frame(width: 30)
                    ForEach(mealTypeName.allCases, id: \.self){ value in
                        menuButton(value: value, date: date)

                        
                        Spacer()
                        
                    }
                }.frame(maxWidth: .infinity)
            }
        }
    }
    
    func menuButton(value: mealTypeName, date:DateViewModel) -> some View{
        if(addDate.dateList.contains(where: {$0.mealTypeNameStatus == value && $0.date == date.actualDate})){
            return
                AnyView (selectMealButtonView(addDate: addDate, date: date.actualDate, delete: false, mealName: value.localizedName, mealtype: value)
                )
        } else {
            return  AnyView(
                selectMealButtonView(addDate: addDate, date: date.actualDate, delete: true,  mealName: value.localizedName, mealtype: value)
            )
            }
        }
    
    
    
}

struct addDateView_Previews: PreviewProvider {
    static var addmeal = addMealViewModel()
    static var previews: some View {
        addDateView(addDate: addmeal)
    }
}
