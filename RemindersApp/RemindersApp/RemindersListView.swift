//
//  RemindersListView.swift
//  RemindersApp
//
//  Created by Pubudu Mihiranga on 2025-03-06.
//

import SwiftUI

struct RemindersListView: View {
    let category: CategoryEntity
    @ObservedObject var viewModel: ViewModel
    @State private var isPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(category.remindersArray) { reminder in
                    HStack {
                        Text(reminder.title ?? "")
                    }
                }
            }
            .navigationTitle(category.name ?? "")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("", systemImage: "plus") {
                        isPresented.toggle()
                    }
                }
            }
            .sheet(isPresented: $isPresented) {
                AddReminderView(category: category, viewModel: viewModel, isPresented: $isPresented)
            }
        }
    }
}
