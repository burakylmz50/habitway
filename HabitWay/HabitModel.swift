//
//  HabitModel.swift
//  HabitWay
//
//  Created by Burak Yılmaz on 20.01.2024.
//
//

import Foundation
import SwiftData

@Model
final class HabitModel {
    
    var id = UUID()
    var creationDate = Date()
    var color = ""
    var date = [""]
    var icon = ""
    var subtitle = ""
    var title = ""

//    init(
//        color: String? = nil,
//        date: [String]? = nil,
//        icon: String? = nil,
//        subtitle: String? = nil,
//        title: String? = nil
//    ) {
//        self.id = UUID()
//        self.creationDate = .now
//        self.color = color
//        self.date = date
//        self.icon = icon
//        self.subtitle = subtitle
//        self.title = title
//    }
    
    init(
        id: UUID = UUID(),
        creationDate: Date = Date(),
        color: String = "",
        date: [String] = [""],
        icon: String = "",
        subtitle: String = "",
        title: String = ""
    ) {
        self.id = id
        self.creationDate = creationDate
        self.color = color
        self.date = date
        self.icon = icon
        self.subtitle = subtitle
        self.title = title
    }
}
