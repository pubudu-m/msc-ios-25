//
//  AddReminderView.swift
//  TaskApp-PT
//
//  Created by Pubudu Mihiranga on 2025-03-09.
//

import SwiftUI

struct AddReminderView: View {
    let category: CategoryEntity
    @ObservedObject var viewModel: ViewModel
    @Binding var showingAddItemView: Bool
    
    @State private var title: String = ""
    @State private var notes: String = ""
    @State private var dueDate: Date = Date()
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $title)
                TextField("Notes", text: $notes)
                DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
            }
            .navigationTitle("Add Task")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        showingAddItemView = false
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add") {
                        viewModel.addTaskItem(title: title, notes: notes, dueDate: dueDate, category: category)
                        showingAddItemView = false
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }
}


