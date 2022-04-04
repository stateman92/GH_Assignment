//
//  XCTestCase+Extensions.swift
//  AssignmentTests
//
//  Created by Kristof Kalai on 2022. 04. 04..
//

import XCTest

extension XCTestCase {
    func wait(for seconds: TimeInterval) {
        _ = XCTWaiter.wait(for: [expectation(description: "Waiting")], timeout: seconds)
    }
}
