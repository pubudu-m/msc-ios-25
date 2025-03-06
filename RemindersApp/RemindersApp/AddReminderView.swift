//
//  AddReminderView.swift
//  RemindersApp
//
//  Created by Pubudu Mihiranga on 2025-03-06.
//

import SwiftUI

struct AddReminderView: View {
    let category: CategoryEntity
    @ObservedObject var viewModel: ViewModel
    @Binding var isPresented: Bool
    @State private var title: String = ""
    @State private var notes: String = ""
    @State private var date: Date = Date()
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $title)
                TextField("Notes", text: $notes)
                DatePicker("Due date", selection: $date, displayedComponents: .date)
            }
            .navigationTitle("Add Reminder")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add") {
                        if !title.isEmpty {
                            viewModel.addReminder(title: title, category: category, dueDate: date)
                        }
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }
}
