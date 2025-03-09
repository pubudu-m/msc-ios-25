//
//  ContentView.swift
//  TaskApp-PT
//
//  Created by Pubudu Mihiranga on 2025-03-09.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.categories) { category in
                    NavigationLink(destination: TaskItemsListView(category: category, viewModel: viewModel)) {
                        HStack {
                            Text(category.title ?? "")
                                .font(.headline)
                            
                            Spacer()
                            
                            Text("\(category.taskItems.count)")
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 8)
                    }
                }
            }
            .navigationTitle("Reminders")
            .listStyle(InsetGroupedListStyle())
        }
        .onAppear {
            viewModel.fetchCategories()
        }
    }
}
