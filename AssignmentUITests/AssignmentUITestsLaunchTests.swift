//
//  AssignmentUITestsLaunchTests.swift
//  AssignmentUITests
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import XCTest

final class AssignmentUITestsLaunchTests: XCTestCase {
    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }
}

extension AssignmentUITestsLaunchTests {
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
