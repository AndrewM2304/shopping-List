//
//  dateSelectorView.swift
//  shopping List (iOS)
//
//  Created by Andrew Miller on 05/01/2021.
//

import SwiftUI

struct dateSelectorView: View {
    
    var dayFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEEE"
        return formatter
    }
    
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
    
    
    let st = ["1","21","31"]
    let nd = ["2", "22"]
    let rd = ["3", "23"]
    
    
    @Binding  var selectedDate : Date
    @State private var dates = Date.newerDate()
    @AppStorage("theme") var currentTheme: colorTheme = .green
    
    var body: some View {
        
        
        VStack {
            
            HStack {
                
                if(monthFormatter.string(from:dates[0].actualDate) == monthFormatter.string(from:dates[6].actualDate)){
                Group {
                    Image(systemName: "calendar")
                    
                    Text("\(dateFormatter.string(from:dates[0].actualDate)) - \(dateFormatter.string(from:dates[6].actualDate))")
                    Text(monthFormatter.string(from:dates[6].actualDate))
                }.font(Font.title2.weight(.bold))
                .foregroundColor(.white)
                } else {
                    Group {
                        Image(systemName: "calendar")
                        
                        Text("\(dateFormatter.string(from:dates[0].actualDate)) \(monthFormatter.string(from:dates[0].actualDate)) - \(dateFormatter.string(from:dates[6].actualDate))")
                        Text(monthFormatter.string(from:dates[6].actualDate))
                    }.font(Font.title2.weight(.bold))
                    .foregroundColor(.white)
                }
                Spacer()
                Group{
                    Button(action: {
                        decrementDate()
                         decrementSelectedDay()
                      
                    }, label: {
                        Image(systemName: "chevron.left")
                            .padding(15)
                            .background(currentTheme.colors.mainColor.opacity(0.4))
                            .clipShape(Circle())
                    })
                    Button(action: {
                        incrementDate()
                         incrementSelectedDay()
                        
                    }, label: {
                        Image(systemName: "chevron.right")
                            .padding(15)
                            .background(currentTheme.colors.mainColor.opacity(0.4))
                            .clipShape(Circle())
                    })
                }
                .padding(5)
                .font(Font.headline.weight(.semibold))
                .foregroundColor(.white)
            }
            .padding(.bottom, 5)
            
            HStack {
                
                ForEach(dates, id: \.self){ date in
                    
                        Button(action: {
                            
                            selectedDate = date.actualDate
                        }, label: {
                            VStack (spacing:2){
                                Text("\(dayFormatter.string(from:date.actualDate))")
                                    .font(Font.headline.weight(.semibold))
                                HStack (spacing:0){
                                    Text("\(dateFormatter.string(from:date.actualDate))")
                                        
                                    if( rd.contains(dateFormatter.string(from:date.actualDate))){
                                        Text("rd")
                                    } else if(st.contains(dateFormatter.string(from:date.actualDate))){
                                        Text("st")
                                    }else if(nd.contains(dateFormatter.string(from:date.actualDate))){
                                        Text("nd")
                                    } else{
                                        Text("th")
                                    }
                                }.font(Font.footnote.weight(.medium))
                                
                            }
                            .frame(minWidth:30)
                            .foregroundColor(dateFormatter.string(from:selectedDate) == dateFormatter.string(from:date.actualDate) ? .white :  currentTheme.colors.mainColor)
                            
                            .padding(.vertical, 10)
                            .padding(.horizontal, 8)
                            .background(dateFormatter.string(from:selectedDate) == dateFormatter.string(from:date.actualDate) ?      currentTheme.colors.mainColor : Color("CardBackground"))
                            .cornerRadius(8)
                            .shadow(color: Color("shadow").opacity(0.1), radius: 16, x: 0.0, y: 0)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.primary, lineWidth: 1).opacity(0.08))
                        })
                    if date != dates.last{
                        Spacer(minLength:3)
                    }
                }
            }
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
    
    func incrementSelectedDay(){
        self.selectedDate = Calendar.current.date(byAdding: .day, value: 7, to: self.selectedDate)!
        
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
    
    func decrementSelectedDay(){
        self.selectedDate = Calendar.current.date(byAdding: .day, value: -7, to: self.selectedDate)!
        
    }
    
    
    
}




struct dateSelectorView_Previews: PreviewProvider {
   @State static var prevDate = Date()
    
    static var previews: some View {
        dateSelectorView(selectedDate:$prevDate)
    }
}



