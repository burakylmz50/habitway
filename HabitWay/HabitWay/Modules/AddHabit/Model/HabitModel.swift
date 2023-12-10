//
//  HabitModel.swift
//  HabitWay
//
//  Created by Burak Yılmaz on 25.11.2023.
//

import SwiftUI

struct HabitModel: Identifiable, Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
    
    var id = UUID()
    var title: String
    var subtitle: String
    var date: [String]
    var color: Color
    var icon: String
}
