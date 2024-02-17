//
//  StringExtension.swift
//  HabitWay
//
//  Created by Burak Yılmaz on 20.11.2023.
//

import Foundation

extension String {
    
    func toDate(withFormat format: String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        
        return date
    }
}

extension String {
    
    func isEmoji() -> Bool {
        for scalar in self.unicodeScalars {
            if scalar.properties.isEmoji {
                return true
            }
        }
        return false
    }
}
