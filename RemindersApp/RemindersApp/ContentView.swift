//
//  ContentView.swift
//  RemindersApp
//
//  Created by Pubudu Mihiranga on 2025-03-06.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.categories) { category in
                    NavigationLink {
                        RemindersListView(category: category, viewModel: viewModel)
                    } label: {
                        HStack {
                            Text(category.name ?? "")
                            Spacer()
                            Text("\(category.remindersArray.count)")
                        }
                    }
                }
            }
        }
    }
}


