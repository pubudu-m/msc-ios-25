//
//  ContentView.swift
//  FinancialCalculatorDemo
//
//  Created by Pubudu Mihiranga on 2025-02-23.
//

import SwiftUI

// 1 - calculating required interest rate for given initial amount and expected final amount
// 2 - calculating required initial value for given expected final amount and rate

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
