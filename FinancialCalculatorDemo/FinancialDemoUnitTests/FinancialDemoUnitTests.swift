//
//  FinancialDemoUnitTests.swift
//  FinancialDemoUnitTests
//
//  Created by Pubudu Mihiranga on 2025-02-23.
//

import XCTest
@testable import FinancialCalculatorDemo

final class FinancialDemoUnitTests: XCTestCase {

    func testCalculateRequiredRate() {
        // Given
        let presentValue: Double = 1000
        let futureValue: Double = 1200
        let years: Double = 1
        
        // When
        let result = InvestmentCalculation.calculateRequiredRate(presentValue: presentValue,
                                                                 futureValue: futureValue,
                                                                 years: years)
        
        // Then
        XCTAssertEqual(result, 20.00, accuracy: 0.0001, "Required rate calculation failed!")
    }

    func testCalculateInitialInvestment() {
        // Given
        let futureValue: Double = 1200
        let rate: Double = 20
        let years: Double = 1
        
        // When
        let result = InvestmentCalculation.calculatePresentValue(futureValue: futureValue,
                                                                 rate: rate,
                                                                 years: years)
        
        // Then
        XCTAssertEqual(result, 1000.00, accuracy: 0.0001, "Present valye calculation failed!")
    }
}
