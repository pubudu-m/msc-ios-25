//
//  InitialInvestmentView.swift
//  FinancialCalculatorDemo
//
//  Created by Pubudu Mihiranga on 2025-02-23.
//

import SwiftUI

// 2 - calculating required initial value for given expected final amount and rate

struct InitialInvestmentView: View {
    @State private var futureValue: String = ""
    @State private var rate: String = ""
    @State private var years: String = ""
    @State private var result: Double?
    
    @State private var showingAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Expected Amount ($)", text: $futureValue)
                        .keyboardType(.decimalPad)
                    
                    TextField("Interest Rate (%)", text: $rate)
                        .keyboardType(.decimalPad)
                    
                    TextField("Time Period (Years)", text: $years)
                        .keyboardType(.decimalPad)
                }
                
                if let result = result {
                    Section {
                        Text("Required Initial Investment: $\(result, specifier: "%.2f")")
                    }
                }
                
                Button("Calculate") {
                    calculateIntialInvestment()
                }
            }
            .navigationTitle("Intial Investment")
            .alert("Error", isPresented: $showingAlert) {
                Button("Ok", role: .cancel) {}
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    private func calculateIntialInvestment() {
        guard let fv = Double(futureValue),
              let r = Double(rate),
              let t = Double(years) else {
            alertMessage = "Please enter valid numbers"
            showingAlert = true
            return
        }
        
        if fv <= 0 || r <= 0 || t <= 0 {
            alertMessage = "Values must be greater than zero"
            showingAlert = true
            return
        }
        
        result = InvestmentCalculation.calculatePresentValue(futureValue: fv, rate: r, years: t)
    }
}

#Preview {
    InitialInvestmentView()
}
