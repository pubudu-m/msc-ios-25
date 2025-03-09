//
//  ViewModel.swift
//  TaskApp-PT
//
//  Created by Pubudu Mihiranga on 2025-03-09.
//

import Foundation
import CoreData

class ViewModel: ObservableObject {
    @Published var categories: [CategoryEntity] = []
    private var viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.viewContext = viewContext
        fetchCategories()
        
        if categories.isEmpty {
            createDefaultCategories()
        }
    }
    
    func fetchCategories() {
        // fetch request (in other terms query)
        let request = NSFetchRequest<CategoryEntity>(entityName: "CategoryEntity")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \CategoryEntity.title, ascending: true)]
        
        do {
            categories = try viewContext.fetch(request)
        } catch {
            print("Error fetching categories: \(error.localizedDescription)")
        }
    }
    
    private func createDefaultCategories() {
        let defaultCategories: [String] = ["Work", "Personal", "Shopping", "Travel"]
        
        for category in defaultCategories {
            let categoryEntity = CategoryEntity(context: viewContext)
            categoryEntity.id = UUID()
            categoryEntity.title = category
        }
        
        saveContext()
    }
    
    func addTaskItem(title: String, notes: String, dueDate: Date, category: CategoryEntity) {
        let taskItem = ItemEntity(context: viewContext)
        taskItem.id = UUID()
        taskItem.title = title
        taskItem.notes = notes
        taskItem.dueDate = dueDate
        taskItem.isCompleted = false
        taskItem.category = category
        
        saveContext()
        objectWillChange.send() // manully trigger the UI updates
    }
    
    func toggleCompletion(for taskItem: ItemEntity) {
        taskItem.isCompleted.toggle()
        
        saveContext()
        objectWillChange.send()
    }
    
    func deleteTaskItem(_ taskItem: ItemEntity) {
        viewContext.delete(taskItem)
        
        saveContext()
        objectWillChange.send()
    }
    
    private func saveContext() {
        PersistenceController.shared.saveContext()
    }
}
