//
//  AddReminderView.swift
//  TaskManager
//
//  Created by Pubudu Mihiranga on 2025-03-06.
//

import SwiftUI
import CoreData

struct AddReminderView: View {
    let category: CategoryEntity
    @ObservedObject var viewModel: RemindersViewModel
    @Binding var isPresented: Bool
    @State private var reminderTitle = ""
    @State private var reminderDueDate: Date = Date()
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $reminderTitle)
                DatePicker("dueDate", selection: $reminderDueDate, displayedComponents: .date)
            }
            .navigationTitle("Add Reminder")
            .navigationBarItems(
                leading: Button("Cancel") {
                    isPresented = false
                },
                trailing: Button("Add") {
                    if !reminderTitle.isEmpty {
                        viewModel.addReminder(title: reminderTitle, category: category, dueDate: reminderDueDate)
                        isPresented = false
                    }
                }
                .disabled(reminderTitle.isEmpty)
            )
        }
    }
}
