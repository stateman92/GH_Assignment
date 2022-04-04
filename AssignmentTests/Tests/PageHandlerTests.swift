//
//  PageHandlerTests.swift
//  AssignmentTests
//
//  Created by Kristof Kalai on 2022. 04. 04..
//

import XCTest
import Combine
@testable import Assignment

final class PageHandlerTests: BaseTestCase {
    // MARK: Properties

    private var sut: PageHandler!
}

// MARK: - Overridden methods

extension PageHandlerTests {
    override func setUp() {
        super.setUp()
        sut = PageHandler()
    }
}

// MARK: - Test initial state

extension PageHandlerTests {
    func testInitialState() {
        // Given

        // When
        let nextPage = sut.nextPage
        let objectsPerPage = sut.objectsPerPage

        // Then

        XCTAssertEqual(nextPage, 1)
        XCTAssertEqual(objectsPerPage, 10)
    }
}

// MARK: - Test fetching

extension PageHandlerTests {
    func testFetchingData() {
        // Given

        // When
        let canFetch = sut.fetchIfPossible()
        let canFetchDuringFetch = sut.fetchIfPossible()
        sut.fetchFinished()
        sut.incrementPage()
        let nextPageAfterFetch = sut.nextPage
        let canFetchAgain = sut.fetchIfPossible()

        // Then

        XCTAssertEqual(canFetch, true)
        XCTAssertEqual(canFetchDuringFetch, false)
        XCTAssertEqual(canFetchAgain, true)
        XCTAssertEqual(nextPageAfterFetch, 2)
    }
}

// MARK: - Test reset

extension PageHandlerTests {
    func testReset() {
        // Given

        // When
        sut.reset()
        let nextPage = sut.nextPage
        let objectsPerPage = sut.objectsPerPage

        // Then

        XCTAssertEqual(nextPage, 1)
        XCTAssertEqual(objectsPerPage, 10)
    }
}

// MARK: - Test increment page

extension PageHandlerTests {
    func testIncrementPage() {
        // Given

        // When
        sut.incrementPage()
        let nextPage = sut.nextPage

        // Then

        XCTAssertEqual(nextPage, 2)
    }
}
