//
//  InvestmentCalculator_UITestsLaunchTests.swift
//  InvestmentCalculator-UITests
//
//  Created by Pubudu Mihiranga on 2025-02-20.
//

import XCTest

final class InvestmentCalculator_UITestsLaunchTests: XCTestCase {

    let app = XCUIApplication()
    
    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    func testRequiredRateViewUI() {
        // given
        let presentValueField = app.textFields["presentValue"]
        let futureValueField = app.textFields["futureValue"]
        let yearsField = app.textFields["years"]
        let calculateButton = app.buttons["calculate"]
        let resultText = app.staticTexts["result"]
        
        // when
        presentValueField.tap()
        presentValueField.typeText("1000")
        
        futureValueField.tap()
        futureValueField.typeText("1200")
        
        yearsField.tap()
        yearsField.typeText("1")
        
        calculateButton.tap()
        
        // then
        XCTAssertTrue(resultText.exists, "Result text should be displayed")
    }
}
