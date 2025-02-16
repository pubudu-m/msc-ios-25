//
//  ContentView.swift
//  property-wrappers-last-session
//
//  Created by Pubudu Mihiranga on 2025-02-16.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.data, id: \.self) { car in
                    NavigationLink {
                        DetailedView(car: car)
                    } label: {
                        HStack {
                            Image(systemName: "car")
                            Text(car)
                        }
                    }
                }
            }
        }
        .environmentObject(viewModel)
    }
}

#Preview {
    ContentView()
}
