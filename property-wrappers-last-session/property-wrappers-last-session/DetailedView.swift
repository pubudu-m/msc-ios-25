//
//  DetailedView.swift
//  property-wrappers-last-session
//
//  Created by Pubudu Mihiranga on 2025-02-16.
//

import SwiftUI

struct DetailedView: View {
    var car: String
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Hello, \(car)!")
                
                NavigationLink(destination: LastView()) {
                    Text("Go to LastView")
                }
            }
        }
    }
}

#Preview {
    DetailedView(car: "bmw")
}
