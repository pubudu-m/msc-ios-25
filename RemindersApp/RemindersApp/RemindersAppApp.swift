//
//  RemindersAppApp.swift
//  RemindersApp
//
//  Created by Pubudu Mihiranga on 2025-03-06.
//

import SwiftUI

@main
struct RemindersAppApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject private var viewModel = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
