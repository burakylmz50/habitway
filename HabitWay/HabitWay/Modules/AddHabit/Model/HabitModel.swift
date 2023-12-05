//
//  HabitModel.swift
//  HabitWay
//
//  Created by Burak Yılmaz on 25.11.2023.
//

import SwiftUI

struct HabitModel: Identifiable, Hashable {
    var id = UUID()
    var title: String
    var subtitle: String
    var date: String
    var color: Color
    var icon: String
}
