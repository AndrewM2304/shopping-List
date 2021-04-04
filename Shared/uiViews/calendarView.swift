//
//  calendarView.swift
//  shopping List (iOS)
//
//  Created by Andrew Miller on 16/03/2021.
//

import SwiftUI
import Foundation
//import UIKit

struct calendarViewTwo: View {
    @Environment(\.calendar) var calendar
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    private var year: DateInterval {
        calendar.dateInterval(of: .year, for: Date())!
    }
    @Binding var selectedDate :Date
    @AppStorage("theme") var currentTheme: colorTheme = .green
    @Environment(\.horizontalSizeClass) var sizeClass
    
    
    var body: some View {
        VStack(spacing: 0){
            if sizeClass == .compact {
                Capsule().foregroundColor(Color.white.opacity(0.3))
                    .frame(width: 58, height:6)
                    .padding()
            }
            
            GeometryReader { geometry in
                CalendarView(interval: year) { date in
                    
                    Button(action: {
                        
                        self.selectedDate = date
                        presentationMode.wrappedValue.dismiss()
                        
                    }, label: {
                        dayView(selectedDate: $selectedDate, geo: geometry, date: date)
                        
                    })
                    
                    
                }
            }
            
            
            .padding(10)
        }.background(Color(#colorLiteral(red: 0.08235294118, green: 0.09411764706, blue: 0.1019607843, alpha: 1)))
        .edgesIgnoringSafeArea(.vertical)
        
    }
    
}

struct calendarView_Previews: PreviewProvider {
    @State static var selectedDate = Date().midnight
    static var previews: some View {
        calendarViewTwo( selectedDate: $selectedDate)
    }
}



struct CalendarView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar
    
    let interval: DateInterval
    let content: (Date) -> DateView
    
    init(
        interval: DateInterval,
        @ViewBuilder content: @escaping (Date) -> DateView
    ) {
        self.interval = interval
        self.content = content
        
    }
    
    private var months: [Date] {
        calendar.generateDates(
            inside: interval,
            matching: DateComponents(day: 1, hour: 0, minute: 0, second: 0)
        )
    }
    
    var monthFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM YYY"
        return formatter
    }
    var thisDate: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "M"
        return formatter
    }
    
    
    var body: some View {
        ScrollView (.vertical){
            ScrollViewReader { value in
                
                LazyVStack(spacing: 10, pinnedViews: [.sectionHeaders]) {
                    ForEach(months, id: \.self) { month in
                        
                        
                        VStack (spacing: 0){
                            HStack {
                                Text(monthFormatter.string(from: month))
                                    .interTextStyle(text: "Inter-ExtraBold", size: 15, color: Color.white)
                                Spacer()
                            }
                            .padding(.vertical)
                            
                            
                            
                        }
                        MonthView(month: month, content: self.content)
                            .id(Int(thisDate.string(from: month)))
                            .background(radialBackgroundView())
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(.bottom, 30)
                        
                        
                    }
                }
                .onAppear{
                    
                    value.scrollTo(Int(thisDate.string(from: Date())), anchor: UnitPoint(x: 0.5, y: 0.3))
                    
                }
            }
            
        }
        
        
    }
    
}



struct MonthView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar
    
    let month: Date
    let content: (Date) -> DateView
    
    init(
        month: Date,
        @ViewBuilder content: @escaping (Date) -> DateView
    ) {
        self.month = month
        self.content = content
    }
    
    private var weeks: [Date] {
        guard
            let monthInterval = calendar.dateInterval(of: .month, for: month)
        else { return [] }
        return calendar.generateDates(
            inside: monthInterval,
            matching: DateComponents(hour: 0, minute: 0, second: 0, weekday: 2)
        )
    }
    
    var body: some View {
        
        
        LazyVStack (spacing:0){
            ForEach(weeks, id: \.self) { week in
                WeekView(week: week, content: self.content)
                
                Divider().background(Color.white.opacity(0.2))
                
            }
            
        }
        
    }
}


struct WeekView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar
    
    let week: Date
    let content: (Date) -> DateView
    
    init(
        week: Date,
        @ViewBuilder content: @escaping (Date) -> DateView
    ) {
        self.week = week
        self.content = content
    }
    
    private var days: [Date] {
        guard
            let weekInterval = calendar.dateInterval(of: .weekOfYear, for: week)
        else { return [] }
        return calendar.generateDates(
            inside: weekInterval,
            matching: DateComponents(hour: 0, minute: 0, second: 0)
        )
    }
    
    var body: some View {
        LazyHStack (spacing:0){
            ForEach(days, id: \.self) { date in
                LazyHStack (spacing: 0){
                    if self.calendar.isDate(self.week, equalTo: date, toGranularity: .month) {
                        self.content(date)
                        
                    } else {
                        self.content(date).opacity(0.5)
                        
                    }
                    
                }
                
            }
            
        }
        
    }
}


fileprivate extension Calendar {
    func generateDates(
        inside interval: DateInterval,
        matching components: DateComponents
    ) -> [Date] {
        var dates: [Date] = []
        dates.append(interval.start)
        
        enumerateDates(
            startingAfter: interval.start,
            matching: components,
            matchingPolicy: .nextTime
        ) { date, _, stop in
            if let date = date {
                if date < interval.end {
                    dates.append(date)
                } else {
                    stop = true
                }
            }
        }
        
        return dates
    }
    
}


struct dayView: View{
    @State var today = Date()
    
    @Environment(\.calendar) var calendar
    @AppStorage("theme") var currentTheme: colorTheme = .green
    @Binding var selectedDate: Date
    var geo : GeometryProxy
    @FetchRequest(entity: Dates.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Dates.date, ascending: true)],
                  animation: .default)
    private var listDates: FetchedResults<Dates>
    
    @FetchRequest(entity: Meal.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Meal.mealName, ascending: true)],
                  animation: .default)
    private var listMeal: FetchedResults<Meal>
    
    private var year: DateInterval {
        calendar.dateInterval(of: .year, for: Date())!
    }
    
    var date: Date
    var body: some View {
        
        ZStack (alignment:.topLeading){
            VStack (spacing: 0) {
                Spacer()
                HStack {
                    Text("30")
                        .hidden()
                    Spacer()
                }
                
                HStack (alignment: .bottom, spacing: 4){
                    Image("fork 2")
                        .resizable()
                        
                        .frame(width: 7, height: 12)
                    Text(" x\(countDays2(dates: date))")
                        .interTextStyle(text: "Inter-SemiBold", size: 10, color: currentTheme.colors.accentColor)
                        .layoutPriority(0)
                    
                    Spacer()
                }.foregroundColor(currentTheme.colors.accentColor)
                .opacity(countDays2(dates: date) > 0 ? 1 : 0)
                
                
            } .padding(.leading, 8)
            .padding(.vertical, 8)
            
            
            Text(String(self.calendar.component(.day, from: date)))
                .interTextStyle(text: "Inter-Medium", size: 13, color: Color.white)
                .padding(8)
                .background(Circle()
                                .frame(height: 20)
                                .foregroundColor(currentTheme.colors.accentColor)
                                .opacity( self.calendar.isDate(self.date, equalTo: today, toGranularity: .day) ? 1 : 0))
        }
        .frame(width: geo.size.width / 7.5, height: 80)
        
        .overlay(
            Group{
                if self.calendar.isDate(self.date, equalTo: selectedDate, toGranularity: .day){
                    
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(currentTheme.colors.gradient)
                        .background(Color.white.opacity(0.05))
                        .opacity(0.6)
                    
                }
            }
        )
        
    }
    func countDays(date: Date) -> Int{
        var x = 0
        for dates in listDates{
            
            if dates.date == date{
                let mealArray = [dates.meal]
                x = mealArray.count
            }
            //            if dates. == selectedDate{
            //            let y =  [dates.meal]
            //            x = y.count
            //            }
            //           let y =  [meal.dateArray.contains(where: {$0.date == selectedDate})]
            
        }
        return x
    }
    
    
    func countDays2(dates: Date) -> Int{
        var x = 0
        for meal in listMeal{
            
            if( meal.dateArray.contains(where: {$0.date == dates})){
                x += 1
            }
            
        }
        
        return x
    }
    
    
}
