//
//  ContentView.swift
//  networking-layer-demo
//
//  Created by Pubudu Mihiranga on 2025-02-16.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            switch viewModel.state {
            case .idle, .loading:
                ProgressView()
                    .frame(width: 100, height: 100)
                    .tint(.black)
            case .success(let todos):
                List {
                    ForEach(todos) { todo in
                        HStack {
                            Text(todo.title)
                        }
                    }
                }
                .listStyle(.plain)
            case .error(let error):
                ContentUnavailableView(error.localizedDescription, systemImage: "ladybug")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
