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
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func addHabit(model: HabitModel) {
        let habit = HabitEntity(context: context)
        habit.id = UUID()
        habit.title = model.title
        habit.subtitle = model.subtitle
        habit.date = model.date
        habit.icon = model.icon
        habit.color = model.hexColor
        
        save(context: context)
    }
    
    func editHabit(habit: HabitEntity, model: HabitModel) {
        habit.title = model.title
        habit.subtitle = model.subtitle
        habit.date = model.date
        habit.icon = model.icon
        habit.color = model.hexColor
        
        save(context: context)
    }
    
    func updateEntityObjectByKeyValue<T>(className: T.Type, key: String, value: Any, columns: [String]) -> Bool {
        guard columns.count != 0 else {
            return false
        }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: className.self))
        
        //Depends on data type.Added fetchRequest using Int and string
        
        if  let sValue = value as? String {
            let predicate = NSPredicate(format: "\(key) == %@", sValue)
            fetchRequest.predicate = predicate
        } else if let iValue = value as? Int {
            let predicate = NSPredicate(format: "\(key) == %d", iValue)
            fetchRequest.predicate = predicate
        } else if let iValue = value as? UUID {
            let predicate = NSPredicate(format: "\(key) == %@", iValue as CVarArg)
            fetchRequest.predicate = predicate
        }
        do {
            let result = try context.fetch(fetchRequest)
            if result.count != 0 {
                if let managedObject = result[0] as? NSManagedObject {

//                    managedObject.date = []
                    
                    managedObject.setValue(columns, forKey: "date")
                    do {
                        try context.save()
                        return true
                    }
                    catch let error {
                        print(error.localizedDescription)
                    }
                }
            }
            return false
        } catch let error {
            print(error.localizedDescription)
        }
//        do {
//            let result = try context.fetch(fetchRequest)
//            if result.count != 0 {
//                if let managedObject = result[0] as? NSManagedObject {
//                    for (value) in columns {
//                        managedObject.setValue(value, forKey: "id")
//                    }
//                    do {
//                        try context.save()
//                        return true
//                    }
//                    catch let error {
//                        print(error.localizedDescription)
//                    }
//                }
//            }
//            return false
//        } catch let error {
//            print(error.localizedDescription)
//        }
        return false
    }
    
    func deleteEntityObjectByKeyValue<T>(entityName: T.Type, key: String, value: Any) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: entityName.self))
        if  let sValue = value as? String {
            let predicate = NSPredicate(format: "\(key) == %@", sValue)
            fetchRequest.predicate = predicate
        } else if let iValue = value as? Int64 {
            let predicate = NSPredicate(format: "\(key) == %d", iValue)
            fetchRequest.predicate = predicate
        } else if let iValue = value as? UUID {
            let predicate = NSPredicate(format: "\(key) == %@", iValue as CVarArg)
            fetchRequest.predicate = predicate
        }
        do {
            let result = try context.fetch(fetchRequest)
            if result.count != 0 {
                if let managedObject = result[0] as? NSManagedObject {
                    context.delete(managedObject)
                    do {
                        try context.save()
                        return true
                    }
                    catch let error {
                        print(error.localizedDescription)
                    }
                }
            }
            return false
        } catch let error {
            print(error.localizedDescription)
        }
        return false
    }
    
    func deleteAll() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = HabitEntity.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        _ = try? container.viewContext.execute(batchDeleteRequest)
    }
    
    func getHabits() -> [HabitModel] {
        let request = NSFetchRequest<HabitEntity>(entityName: "HabitEntity")
        
        do {
            habits = try context.fetch(request).map {
                HabitModel(
                    id: $0.id ?? UUID(),
                    title: $0.title ?? "",
                    subtitle: $0.subtitle ?? "" ,
                    date: $0.date ?? [],
                    hexColor: $0.color ?? "",
                    icon: $0.icon ?? ""
                )
            }
            
        } catch let error {
            print("Error fetching (\(error.localizedDescription)")
        }
        return habits
    }
}
