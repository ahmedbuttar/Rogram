//
//  RogramUITests.swift
//  RogramUITests
//
//  Created by Ahmed Buttar on 7/6/24.
//

import XCTest

final class RogramUITests: XCTestCase {

    func testCellTap() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        app.cells.element(boundBy: 0).tap()
        let title = app.staticTexts["photoDetailTitleView"]
        XCTAssertTrue(title.exists)
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
