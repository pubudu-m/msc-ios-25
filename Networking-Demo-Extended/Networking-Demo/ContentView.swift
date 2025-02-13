//
//  ContentView.swift
//  Networking-Demo
//
//  Created by Pubudu Mihiranga on 2025-02-13.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            switch viewModel.state {
            case .idle:
                ContentUnavailableView("Ooops!",
                                       systemImage: "ladybug.fill",
                                       description: Text("Nothing to display"))
            
            case .loading:
                ProgressView()
            
            case .success(let albums):
                List(albums) { album in
                    HStack {
                        Text(album.title)
                    }
                }
                .listStyle(.plain)
                
            case .failure(let error):
                ContentUnavailableView("Ooops!",
                                       systemImage: "ladybug.fill",
                                       description: Text(error.errorDescription))
            }
        }
        .padding()
        .task {
            viewModel.getData()
        }
    }
}

#Preview {
    ContentView()
}
