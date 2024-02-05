//
//  HomeViewModel.swift
//  HabitWay
//
//  Created by Burak Yılmaz on 20.11.2023.
//

import SwiftUI
import Observation

enum HomeRoute : String , Hashable{
    case addHabit
    case paywall
}

enum ActiveSheet: Identifiable {
    case addHabit
    case paywall
    
    var id: Int {
        hashValue
    }
}

@Observable
final class HomeViewModel {
    
    var paywallViewModel: PaywallViewModel?
    var isPresentedPaywall: Bool = false
    var habits = [HabitModel]()
    var activeSheet: ActiveSheet?
    var isActive: Bool?
    
    var todayDate = Date.now.toString(withFormat: "yyyy-MM-dd")
    
    private let container: ContainerViewModel
    private let dataController: DataController
    
    init(dataController: DataController = DataController.shared, container: ContainerViewModel) {
        self.dataController = dataController
        self.container = container
    }
    
    deinit {
        print("\(self)) Deinitialized")
    }
    
    func setup(paywallViewModel: PaywallViewModel) {
        self.paywallViewModel = paywallViewModel
    }
    
    func getHabits() {
        habits = DataController.shared.fetchHabits()
    }
    
    func addButton() { //TODO: isActive e göre iş yapılacak
        if habits.count > 3 && !(paywallViewModel?.isActive ?? false) {
            activeSheet = .paywall
        } else {
            activeSheet = .addHabit
        }
    }
    
    func paywallButton() {
        activeSheet = .paywall
    }
    
    func removeHabit(habit: HabitModel) -> Bool {
        dataController.deleteHabit(habit: habit)
    }
    
    func editHabit(habitModel: HabitModel) -> Bool {
        var dates = habitModel.date
        
        if !dates.contains(todayDate) {
            dates.append(todayDate)
        } else {
            if let index = dates.firstIndex(of: todayDate) {
                dates.remove(at: index)
            }
        }
        
        return DataController.shared.updateHabit(habit: habitModel, dates: dates)
        
        
//        if isUpdateEntity {
//            getHabits()
//            return true
//        } else {
//            return false
//        }
    }
}
