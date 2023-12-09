//
//  AddHabitViewModel.swift
//  HabitWay
//
//  Created by Burak Yılmaz on 22.11.2023.
//

import SwiftUI
import CoreData

enum AddHabitRoute : String , Hashable{
    case addHabit2
}

final class AddHabitViewModel: ObservableObject {
    
//    @Environment(\.managedObjectContext) var managedObjContext
    
    
//    @FetchRequest(sortDescriptors: [SortDescriptor(\., order: .reverse)]) 
//    var habit: FetchedResults<HabitEntity>
//    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \HabitModel.date, ascending: true)], animation: .default)
    
    @FetchRequest(
        sortDescriptors: [
            SortDescriptor(\HabitEntity.id, order: .reverse)
        ]
    ) var users: FetchedResults<HabitEntity>
    
    @Published var navigationPath = NavigationPath()
    
    init() { }
    
    deinit {
        print("\(self)) Deinitialized")
    }
    
    func addHabit(model: HabitModel) {
        DataController.shared.addHabit(model: model)
    }
}
