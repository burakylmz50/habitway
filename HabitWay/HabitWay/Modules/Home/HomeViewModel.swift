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
}

final class HomeViewModel: ObservableObject {
    
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.isUpdated, order: .reverse)]) var habit: FetchedResults<HabitEntity>
    
    @Published var navigationPath = NavigationPath()
    @Published var habits = [HabitModel]()
    
    let container: ContainerViewModel
    
    init(container: ContainerViewModel) {
        self.container = container
    }
    
    deinit {
        print("\(self)) Deinitialized")
    }
    
    func getHabits() {
        habits = DataController.shared.getHabits()
    }
    
    func addButton() {
        navigationPath.append(HomeRoute.addHabit)
    }
    
    func removeHabit(habitModel: HabitModel) -> Bool {
        DataController.shared.deleteEntityObjectByKeyValue(
            entityName: HabitEntity.self,
            key: "id",
            value: habitModel.id
        )
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
