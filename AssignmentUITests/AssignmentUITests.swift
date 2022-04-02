//
//  AssignmentUITests.swift
//  AssignmentUITests
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import XCTest

final class AssignmentUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws { }
}

extension AssignmentUITests {
    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
    }

    func testLaunchPerformance() throws {
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
