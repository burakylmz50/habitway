//
//  DataController.swift
//  HabitWay
//
//  Created by Burak Yılmaz on 25.11.2023.
//

import SwiftUI
import SwiftData
import Observation

@Observable
final class DataController {
    
    var habits: [HabitModel] = []
    
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext
    
    @MainActor
    static let shared = DataController()
    
    @MainActor
    private init() {
        self.modelContainer = try! ModelContainer(for: HabitModel.self)
        self.modelContext = modelContainer.mainContext
    }
    
    func fetchHabits() -> [HabitModel] {
        do {
            habits = try modelContext.fetch(FetchDescriptor<HabitModel>(sortBy: [SortDescriptor(\.creationDate)]))
            return habits
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func createHabit(habit: HabitModel) {
        modelContext.insert(habit)
    }
    
    func deleteHabit(habit: HabitModel) -> Bool {
        modelContext.delete(habit)
        return true
    }
    
    func updateHabit(habit: HabitModel, dates: [String]) -> Bool {
        guard let habit = fetchHabits().first(where: { $0.id == habit.id }) else { return false }
       
        habit.date = dates
        return true
    }
    
    func deleteAllHabits() {
        do {
            try modelContext.delete(model: HabitModel.self)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func updateObject(habit: HabitModel, dates: [String]) {
        if let habit = fetchHabits().first(where: { $0.id == habit.id }) {
            var date = habit.date
            date.append(contentsOf: dates)
        }
    }
}
