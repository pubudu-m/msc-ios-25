//
//  RemindersViewModel.swift
//  TaskManager
//
//  Created by Pubudu Mihiranga on 2025-03-06.
//

import SwiftUI
import CoreData

class RemindersViewModel: ObservableObject {
    @Published var categories: [CategoryEntity] = []
    private var viewContext: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.viewContext = context
        fetchCategories()
        
        // Create default categories if none exist
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
        let reminder = TaskEntity(context: viewContext)
        reminder.id = UUID()
        reminder.title = title
        reminder.isCompleted = false
        reminder.category = category
        reminder.dueDate = dueDate
        
        saveContext()
        objectWillChange.send()
    }
    
    func toggleCompletion(for reminder: TaskEntity) {
        reminder.isCompleted.toggle()
        saveContext()
        
        // manually triggers UI updates when data changes in your model
        objectWillChange.send()
    }
    
    func deleteReminder(_ reminder: TaskEntity) {
        viewContext.delete(reminder)
        saveContext()
        objectWillChange.send()
    }
    
    private func saveContext() {
        PersistenceController.shared.saveContext()
    }
}
