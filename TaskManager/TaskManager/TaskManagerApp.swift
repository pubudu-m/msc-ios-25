//
//  TaskManagerApp.swift
//  TaskManager
//
//  Created by Pubudu Mihiranga on 2025-03-06.
//

import SwiftUI

@main
struct TaskManagerApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject private var viewModel = RemindersViewModel()
    
    var body: some Scene {
        WindowGroup {
            CategoriesView(viewModel: viewModel)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
