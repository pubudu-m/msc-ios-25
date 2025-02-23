//
//  FinancialDemoUITests.swift
//  FinancialDemoUITests
//
//  Created by Pubudu Mihiranga on 2025-02-23.
//

import XCTest

final class FinancialDemoUITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInvestmentCalculatorMainUI() {
        // Given
        let presentValueTextField = app.textFields["presentValue"]
        let futureValueTextField = app.textFields["futureValue"]
        let yearsTextField = app.textFields["years"]
        let calculateButton = app.buttons["caclulate"]
        let resultLabel = app.staticTexts["result"]
        
        // When
        presentValueTextField.tap()
        presentValueTextField.typeText("1000")
        
        futureValueTextField.tap()
        futureValueTextField.typeText("1200")
        
        yearsTextField.tap()
        yearsTextField.typeText("1")
        
        calculateButton.tap()
        
        // Then
        XCTAssertTrue(resultLabel.exists, "Result text should be displayed!")
    }
}
