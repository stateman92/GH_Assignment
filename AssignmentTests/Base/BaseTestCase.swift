//
//  BaseTestCase.swift
//  AssignmentTests
//
//  Created by Kristof Kalai on 2022. 04. 04..
//

import XCTest
@testable import Assignment

class BaseTestCase: XCTestCase { }

// MARK: - Overridden methods

extension BaseTestCase {
    override class func setUp() {
        super.setUp()
        DependencyInjector.registerDependenciesForTests()
    }
}
