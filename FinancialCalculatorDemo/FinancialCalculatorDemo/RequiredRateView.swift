//
//  RequiredRateView.swift
//  FinancialCalculatorDemo
//
//  Created by Pubudu Mihiranga on 2025-02-23.
//

import SwiftUI

// 1 - calculating required interest rate for given initial amount and expected final amount
// user input 1 - initial investment
// user input 2 - expected amount
// user input 3 - years
// calculate - required rate

struct RequiredRateView: View {
    @State private var presentValue: String = ""
    @State private var futureValue: String = ""
    @State private var years: String = ""
    @State private var result: Double?
    
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Initial Investment ($)", text: $presentValue)
                        .keyboardType(.decimalPad)
                        .accessibilityIdentifier("presentValue")
                    
                    TextField("Expected Amount ($)", text: $futureValue)
                        .keyboardType(.decimalPad)
                        .accessibilityIdentifier("futureValue")
                    
                    TextField("Years", text: $years)
                        .keyboardType(.decimalPad)
                        .accessibilityIdentifier("years")
                }
                
                if let result = result {
                    Section {
                        Text("Required Interest Rate: \(result, specifier: "%.2f")%")
                            .accessibilityIdentifier("result")
                    }
                }
                
                Button("Caclulate") {
                    calculateRate()
                }
                .accessibilityIdentifier("caclulate")
            }
            .navigationTitle("Required Rate")
            .alert("Ooops! Error", isPresented: $showAlert) {
                Button("Ok", role: .cancel) {}
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    private func calculateRate() {
        guard let pv = Double(presentValue),
                let fv = Double(futureValue),
                let t = Double(years) else {
            alertMessage = "Please enter valid numbers"
            showAlert.toggle()
            return
        }
        
        if pv <= 0 || fv <= 0 || t <= 0 {
            alertMessage = "Values must be greater than zero"
            showAlert.toggle()
            return
        }
        
        // perfrom the calculation
        result = InvestmentCalculation.calculateRequiredRate(presentValue: pv, futureValue: fv, years: t)
    }
}

#Preview {
    RequiredRateView()
}
