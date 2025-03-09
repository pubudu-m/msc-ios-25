//
//  TaskApp_PTApp.swift
//  TaskApp-PT
//
//  Created by Pubudu Mihiranga on 2025-03-09.
//

import SwiftUI

@main
struct TaskApp_PTApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject private var viewModel = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
