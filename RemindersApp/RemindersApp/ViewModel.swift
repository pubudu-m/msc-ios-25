//
//  ViewModel.swift
//  RemindersApp
//
//  Created by Pubudu Mihiranga on 2025-03-06.
//

import Foundation
import CoreData

class ViewModel: ObservableObject {
    @Published var categories: [CategoryEntity] = [] // id, title, reminders belongs to that category
    private var viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.viewContext = viewContext
        
        if categories.isEmpty {
            createDefaultCategories()
        }
    }
    
    func fetchCategories() {
        let request = NSFetchRequest<CategoryEntity>(entityName: "CategoryEntity")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \CategoryEntity.name, ascending: true)]
        
        do {
            categories = try viewContext.fetch(request)
        } catch {
            print("Error fetching categories: \(error.localizedDescription)")
        }
    }
    
    private func createDefaultCategories() {
        let defaultCategories = ["High", "Medium", "Low"]
        
        for name in defaultCategories {
            let category = CategoryEntity(context: viewContext)
            category.id = UUID()
            category.name = name
        }
        
        saveContext()
        fetchCategories()
    }
    
    func addReminder(title: String, category: CategoryEntity, dueDate: Date) {
        let reminder = ReminderEntity(context: viewContext)
        reminder.id = UUID()
        reminder.title = title
        reminder.isCompleted = false
        reminder.category = category
        reminder.dueDate = dueDate
        
        saveContext()
        objectWillChange.send()
    }
    
    func toggleCompletion(for reminder: ReminderEntity) {
        reminder.isCompleted.toggle()
        
        saveContext()
        objectWillChange.send()
    }
    
    func deleteReminder(reminder: ReminderEntity) {
        viewContext.delete(reminder)
        
        saveContext()
        objectWillChange.send()
    }
    
    private func saveContext() {
        PersistenceController.shared.saveContext()
    }
}
