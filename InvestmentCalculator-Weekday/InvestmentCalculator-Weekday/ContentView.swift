//
//  ContentView.swift
//  InvestmentCalculator-Weekday
//
//  Created by Pubudu Mihiranga on 2025-02-20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            RequiredRateView()
                .tabItem {
                    Label("Rate", systemImage: "percent")
                }
            
            InitialInvestmentView()
                .tabItem {
                    Label("Investment", systemImage: "dollarsign")
                }
        }
    }
}

#Preview {
    ContentView()
}
