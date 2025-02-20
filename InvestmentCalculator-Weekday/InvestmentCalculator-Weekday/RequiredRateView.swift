//
//  RequiredRateView.swift
//  InvestmentCalculator-Weekday
//
//  Created by Pubudu Mihiranga on 2025-02-20.
//

import SwiftUI

struct RequiredRateView: View {
    @State private var presentValue: String = ""
    @State private var futureValue: String = ""
    @State private var years: String = ""
    @State private var result: Double?
    @State private var showingAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Initial Investment ($)", text: $presentValue)
                        .keyboardType(.decimalPad)
                    
                    TextField("Target Amount ($)", text: $futureValue)
                        .keyboardType(.decimalPad)
                    
                    TextField("Time Period (Years)", text: $years)
                        .keyboardType(.decimalPad)
                } header: {
                    Text("Input Values")
                }
                
                if let result = result {
                    Section {
                        Text("Required Interest Rate: \(result, specifier: "%.2f")%")
                    } header: {
                        Text("Result")
                    }

                }

                Button("Calculate") {
                    calculateRate()
                }
            }
            .navigationTitle("Required Rate")
            .alert("Error", isPresented: $showingAlert) {
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
            showingAlert = true
            return
        }
        
        if pv <= 0 || fv <= 0 || t <= 0 {
            alertMessage = "Values must be greater than zero"
            showingAlert = true
            return
        }
        
        result = InvestmentCalculation.calculateRequiredRate(presentValue: pv,
                                                             futureValue: fv,
                                                             years: t)
    }
}

#Preview {
    RequiredRateView()
}
