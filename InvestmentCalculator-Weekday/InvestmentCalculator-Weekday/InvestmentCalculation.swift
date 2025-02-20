//
//  InvestmentCalculation.swift
//  InvestmentCalculator-Weekday
//
//  Created by Pubudu Mihiranga on 2025-02-20.
//

import Foundation

struct InvestmentCalculation {
    static func calculateRequiredRate(presentValue: Double, futureValue: Double, years: Double) -> Double {
        return (pow(futureValue/presentValue, 1/years) - 1) * 100
    }
    
    static func calculatePresentValue(futureValue: Double, rate: Double, years: Double) -> Double {
        return futureValue / pow(1 + rate/100, years)
    }
}
