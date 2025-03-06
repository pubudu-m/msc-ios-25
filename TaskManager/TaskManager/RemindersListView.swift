//
//  RemindersListView.swift
//  TaskManager
//
//  Created by Pubudu Mihiranga on 2025-03-06.
//

import SwiftUI

struct RemindersListView: View {
    let category: CategoryEntity
    @ObservedObject var viewModel: RemindersViewModel
    @State private var showingAddReminderSheet = false
    
    var body: some View {
        List {
            ForEach(category.remindersArray) { reminder in
                HStack {
                    Button(action: {
                        viewModel.toggleCompletion(for: reminder)
                    }) {
                        Image(systemName: reminder.isCompleted ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(reminder.isCompleted ? .primary : .secondary)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Text(reminder.title ?? "")
                        .strikethrough(reminder.isCompleted)
                        .foregroundColor(reminder.isCompleted ? .secondary : .primary)
                    
                    Spacer()
                }
            }
            .onDelete { indexSet in
                for index in indexSet {
                    let reminder = category.remindersArray[index]
                    viewModel.deleteReminder(reminder)
                }
            }
        }
        .navigationTitle(category.name ?? "")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showingAddReminderSheet = true
                }) {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddReminderSheet) {
            AddReminderView(category: category, viewModel: viewModel, isPresented: $showingAddReminderSheet)
        }
    }
}
