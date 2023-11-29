//
//  DataController.swift
//  HabitWay
//
//  Created by Burak Yılmaz on 25.11.2023.
//

import Foundation
import CoreData
import SwiftUI

final class DataController: ObservableObject {
    
    static let shared = DataController()
    
    let container: NSPersistentContainer
    let context : NSManagedObjectContext
    
    var habits: [HabitModel] = []
    
    init() {
        container = NSPersistentContainer(name: "HabitModel")
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolve Error: \(error)")
            }
        }
        context = container.viewContext
    }
    
    private func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved successfully. WUHU!!!")
        } catch {
            // Handle errors in our database
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func addHabit(model: HabitModel) {
        let habit = HabitEntity(context: context)
        habit.id = UUID()
        habit.name = model.name
        habit.desc = model.description
        habit.date = model.date
        habit.icon = model.icon
        
        save(context: context)
    }
    
    func editHabit(habit: HabitEntity, model: HabitModel) {
        habit.name = model.name
        habit.desc = model.description
        habit.date = model.date
        habit.icon = model.icon
        
        save(context: context)
    }
    
    func deleteAll() {
        let fetchRequest1: NSFetchRequest<NSFetchRequestResult> = HabitEntity.fetchRequest()
        let batchDeleteRequest1 = NSBatchDeleteRequest(fetchRequest: fetchRequest1)
        _ = try? container.viewContext.execute(batchDeleteRequest1)
    }
    
    func getHabits() -> [HabitModel] {
        let request = NSFetchRequest<HabitEntity>(entityName: "HabitEntity")
        
        do {
            habits = try context.fetch(request).map {
                HabitModel(
                    id: $0.id ?? UUID(),
                    name: $0.name ?? "",
                    description: $0.description ,
                    date: $0.date ?? "",
                    color: Color($0.color ?? ""),
                    icon: $0.icon ?? ""
                )
            }
            
        } catch let error {
            print("Error fetching (\(error.localizedDescription)")
        }
        return habits
    }
}
