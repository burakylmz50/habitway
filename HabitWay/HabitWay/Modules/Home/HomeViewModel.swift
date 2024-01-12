//
//  HomeViewModel.swift
//  HabitWay
//
//  Created by Burak Yılmaz on 20.11.2023.
//

import SwiftUI
import CoreData

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

final class HomeViewModel: ObservableObject {
    
    @Published var paywallViewModel: PaywallViewModel?
    
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.isUpdated, order: .reverse)]) var habit: FetchedResults<HabitEntity>
    
    @Published var navigationPath = NavigationPath()
    @Published var isPresentedPaywall: Bool = false
    @Published var habits = [HabitModel]()
    @Published var activeSheet: ActiveSheet?
    @Published var isActive: Bool?
    
    var todayDate = Date.now.toString(withFormat: "yyyy-MM-dd")
    
    let container: ContainerViewModel
    
    init(container: ContainerViewModel) {
        self.container = container
    }
    
    deinit {
        print("\(self)) Deinitialized")
    }
    
    func setup(paywallViewModel: PaywallViewModel) {
        self.paywallViewModel = paywallViewModel
      }
    
    func getHabits() {
        habits = DataController.shared.getHabits()
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
    
    func removeHabit(habitModel: HabitModel) -> Bool {
        DataController.shared.deleteEntityObjectByKeyValue(
            entityName: HabitEntity.self,
            key: "id",
            value: habitModel.id
        )
    }
    
    func removeHabitDay(date: String) -> Bool {
        let isRemoveHabitDay = DataController.shared.updateEntityObjectByKeyValue(
            className: HabitEntity.self,
            key: "date",
            value: date,
            columns: Array(arrayLiteral: date)
        )
        
        if isRemoveHabitDay {
            getHabits()
            return true
        } else {
            return false
        }
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
        
        let isUpdateEntity = DataController.shared.updateEntityObjectByKeyValue(
            className: HabitEntity.self,
            key: "id",
            value: habitModel.id,
            columns: dates
        )
        
        if isUpdateEntity {
            getHabits()
            return true
        } else {
            return false
        }
    }
}

extension HomeViewModel {
    
    private func navigate(route: HomeRoute) {
        navigationPath.append(route)
    }
    
    private func pop() async {
        navigationPath.removeLast()
    }
}
