//
//  dateviewModel.swift
//  shopping List (iOS)
//
//  Created by Andrew Miller on 05/01/2021.
//

import Foundation
import SwiftUI

struct DateViewModel: Equatable, Hashable {
    var actualDate: Date
    
}


extension Date{
    
    static var thisYear: Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let component = formatter.string(from: Date())
        
        if let value = Int(component) {
            return value
        }
        return 0
    }
    


    
    
    static func newerDate() -> [DateViewModel]{
        
        var datesListNew = [DateViewModel]()
        let customCalendar = Calendar(identifier: .iso8601)
        for i in 0 ... 6 {
            guard  let dayWeekList = customCalendar.date(byAdding: .day, value: i, to: Date().startOfWeek()) else { continue }

            let dateViewModel = DateViewModel(actualDate: dayWeekList)
            datesListNew.append(dateViewModel)
        }
        return datesListNew
    }
    
}





//Mark: day of the week formatting ************************************
extension Calendar {
    static let iso8601 = Calendar(identifier: .iso8601)
    
}

extension Date {
    func startOfWeek(using calendar: Calendar = .iso8601) -> Date {
        calendar.date(from: Calendar.iso8601.dateComponents([.calendar, .yearForWeekOfYear, .weekOfYear], from: self))!
        
    }
    
    var midnight:Date{
            let cal = Calendar(identifier: .gregorian)
            return cal.startOfDay(for: self)
        }
}


extension View{
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }
}
