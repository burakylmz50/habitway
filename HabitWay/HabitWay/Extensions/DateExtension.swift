//
//  DateExtension.swift
//  HabitWay
//
//  Created by Burak Yılmaz on 20.11.2023.
//

import Foundation

extension Date {
    
    func toString(withFormat format: String) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let myString = formatter.string(from: self)
        let yourDate = formatter.date(from: myString)
        
        return formatter.string(from: yourDate!)
    }
    
    func getCurrentDate(withFormat format: String = "yyyy-MM-dd") -> Date {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let dateInString  = dateFormatter.string(from: self)
        let dateinDate = dateFormatter.date(from: dateInString)
        
        return dateinDate!
    }
}

extension Date {
    
    var weekdayOrdinal: Int {
        return Calendar.current.component(.weekday, from: self)
    }
    
    func dayNumberOfWeek() -> Int? {
        Calendar.current.dateComponents([.weekday], from: self).weekday
    }
}
