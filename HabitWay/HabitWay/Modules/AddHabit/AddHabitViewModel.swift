//
//  AddHabitViewModel.swift
//  HabitWay
//
//  Created by Burak Yılmaz on 22.11.2023.
//

import SwiftUI
import Observation
import EmojiKit

@Observable
final class AddHabitViewModel {
    
    var habits: [HabitModel] = []
    var emojisByCategory: [EmojiCategory] = []
    
    private let dataController: DataController

    init(dataController: DataController = DataController.shared) {
        self.dataController = dataController
        
        getAvailableEmojis()
    }
    
    deinit {
        print("\(self)) Deinitialized")
    }
    
    func addHabit(habit: HabitModel) {
        dataController.createHabit(habit: habit)
        
        habits = dataController.fetchHabits()
    }
    
    func getAvailableEmojis() {
        emojisByCategory = EmojiManager.getAvailableEmojis().reversed()
    }
}
