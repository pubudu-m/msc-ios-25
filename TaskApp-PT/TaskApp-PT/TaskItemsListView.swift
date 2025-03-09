//
//  TaskItemsListView.swift
//  TaskApp-PT
//
//  Created by Pubudu Mihiranga on 2025-03-09.
//

import SwiftUI

struct TaskItemsListView: View {
    let category: CategoryEntity
    @ObservedObject var viewModel: ViewModel
    @State private var showingAddItemView = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(category.taskItems) { item in
                    HStack {
                        Button(action: {
                            viewModel.toggleCompletion(for: item)
                        }) {
                            Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundStyle(item.isCompleted ? .primary : .secondary)
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        VStack(alignment:. leading) {
                            Text(item.title ?? "")
                                .font(.headline)
                            
                            Text(item.notes ?? "")
                        }
                        .strikethrough(item.isCompleted)
                        .foregroundStyle(item.isCompleted ? .secondary : .primary)
                        
                        Spacer()
                    }
                }
            }
            .navigationTitle(category.title ?? "")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showingAddItemView.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddItemView) {
                AddReminderView(category: category, viewModel: viewModel, showingAddItemView: $showingAddItemView)
            }
        }
    }
}


