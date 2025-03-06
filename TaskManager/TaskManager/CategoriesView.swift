//
//  CategoriesView.swift
//  TaskManager
//
//  Created by Pubudu Mihiranga on 2025-03-06.
//

import SwiftUI

struct CategoriesView: View {
    @ObservedObject var viewModel: RemindersViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.categories) { category in
                    NavigationLink(destination: RemindersListView(category: category, viewModel: viewModel)) {
                        HStack {
                            Text(category.name ?? "")
                                .font(.headline)
                            
                            Spacer()
                            
                            Text("\(category.remindersArray.count)")
                                .foregroundColor(.secondary)
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

#Preview {
    CategoriesView(viewModel: RemindersViewModel())
}
