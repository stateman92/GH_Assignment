//
//  MainViewModelTests.swift
//  AssignmentTests
//
//  Created by Kristof Kalai on 2022. 04. 04..
//

import XCTest
import Combine
@testable import Assignment

final class MainViewModelTests: BaseTestCase {
    // MARK: Properties

    private var sut: MainViewModel!
    private var cancellables: Set<AnyCancellable>!

    @LazyInjected(DependencyInjector.loadingServiceMock) private var loadingServiceMock
    @LazyInjected(DependencyInjector.navigationControllerMock) private var navigatorMock
    @LazyInjected(DependencyInjector.networkServiceMock) private var networkServiceMock
}

// MARK: - Overridden methods

extension MainViewModelTests {
    override func setUp() {
        super.setUp()
        cancellables = .init()
        sut = MainViewModel()
        sut.loadingService = loadingServiceMock
        sut.navigator = navigatorMock
        sut.networkService = networkServiceMock
    }
}

// MARK: - Test searchModelSubject

extension MainViewModelTests {
    func testSearchTermDidChangeToEmptyString() {
        // Given

        sut.searchTerm = .init()
        wait(for: 1)

        // When

        let result = sut.searchModelSubject.value

        // Then

        XCTAssertEqual(result.items, [])

        XCTAssertEqual(loadingServiceMock.loadingDuringCalled, false)
        XCTAssertEqual(loadingServiceMock.setStateIsShowingCalled, false)

        XCTAssertEqual(navigatorMock.presentAnimatedCompletionCalled, false)

        XCTAssertEqual(networkServiceMock.searchRepositoriesSearchTermPerPagePageCompletionCalled, false)
    }

    func testSearchTermDidChangeToNotEmptyStringSuccessfulSearch() {
        // Given

        let searchTerm = "swift"
        let networkResult = SearchModel(items: [.init(id: 1,
                                                      name: "Repository 1",
                                                      owner: .init(name: "Owner 1", avatarUrl: "avatarUrl 1"),
                                                      description: "Description 1",
                                                      language: "Language 1",
                                                      stars: 20,
                                                      url: "https://www.google.com",
                                                      forks: 25),
                                                .init(id: 2,
                                                      name: "Repository 2",
                                                      owner: .init(name: "Owner 2", avatarUrl: "avatarUrl 2"),
                                                      description: "Description 2",
                                                      language: "Language 2",
                                                      stars: 21,
                                                      url: "https://www.facebook.com",
                                                      forks: 26)])

        loadingServiceMock.loadingDuringClosure = {
            $0 { }
        }

        networkServiceMock
            .searchRepositoriesSearchTermPerPagePageCompletionClosure = { searchTerm, perPage, page, closure in
                XCTAssertEqual(searchTerm, searchTerm)
                XCTAssertEqual(perPage, 10)
                XCTAssertEqual(page, 1)
                closure(.success(networkResult.mapped))
            }

        // When

        sut.searchTerm = searchTerm
        wait(for: 1)

        // Then

        let result = sut.searchModelSubject.value
        XCTAssertEqual(result, networkResult)

        XCTAssertEqual(loadingServiceMock.loadingDuringCallsCount, 1)
        XCTAssertEqual(loadingServiceMock.setStateIsShowingCalled, false)

        XCTAssertEqual(navigatorMock.presentAnimatedCompletionCalled, false)

        XCTAssertEqual(networkServiceMock.searchRepositoriesSearchTermPerPagePageCompletionCallsCount, 1)
    }
}

// MARK: - Test didSelect(index:)

extension MainViewModelTests {
    func testRepositorySelectedValidIndexValidUrl() {
        // Given

        let networkResult = SearchModel(items: [.init(id: 1,
                                                      name: "Repository 1",
                                                      owner: .init(name: "Owner 1", avatarUrl: "avatarUrl 1"),
                                                      description: "Description 1",
                                                      language: "Language 1",
                                                      stars: 20,
                                                      url: "https://www.google.com",
                                                      forks: 25),
                                                .init(id: 2,
                                                      name: "Repository 2",
                                                      owner: .init(name: "Owner 2", avatarUrl: "avatarUrl 2"),
                                                      description: "Description 2",
                                                      language: "Language 2",
                                                      stars: 21,
                                                      url: "https://www.facebook.com",
                                                      forks: 26)])

        // When

        sut.searchModelSubject.send(networkResult)
        sut.didSelect(index: 1)

        // Then

        XCTAssertEqual(loadingServiceMock.loadingDuringCalled, false)
        XCTAssertEqual(loadingServiceMock.setStateIsShowingCalled, false)

        XCTAssertEqual(navigatorMock.presentAnimatedCompletionCallsCount, 1)

        XCTAssertEqual(networkServiceMock.searchRepositoriesSearchTermPerPagePageCompletionCalled, false)
    }

    func testRepositorySelectedInvalidIndex() {
        // Given

        // When

        sut.didSelect(index: 1)

        // Then

        XCTAssertEqual(loadingServiceMock.loadingDuringCalled, false)
        XCTAssertEqual(loadingServiceMock.setStateIsShowingCalled, false)

        XCTAssertEqual(navigatorMock.presentAnimatedCompletionCalled, false)

        XCTAssertEqual(networkServiceMock.searchRepositoriesSearchTermPerPagePageCompletionCalled, false)
    }

    func testRepositorySelectedValidIndexInvalidUrl() {
        // Given

        let networkResult = SearchModel(items: [.init(id: 1,
                                                      name: "Repository 1",
                                                      owner: .init(name: "Owner 1", avatarUrl: "avatarUrl 1"),
                                                      description: "Description 1",
                                                      language: "Language 1",
                                                      stars: 20,
                                                      url: "Invalid url 1",
                                                      forks: 25),
                                                .init(id: 2,
                                                      name: "Repository 2",
                                                      owner: .init(name: "Owner 2", avatarUrl: "avatarUrl 2"),
                                                      description: "Description 2",
                                                      language: "Language 2",
                                                      stars: 21,
                                                      url: "Invalid url 2",
                                                      forks: 26)])

        // When

        sut.searchModelSubject.send(networkResult)
        sut.didSelect(index: 1)

        // Then

        XCTAssertEqual(loadingServiceMock.loadingDuringCalled, false)
        XCTAssertEqual(loadingServiceMock.setStateIsShowingCalled, false)

        XCTAssertEqual(navigatorMock.presentAnimatedCompletionCalled, false)

        XCTAssertEqual(networkServiceMock.searchRepositoriesSearchTermPerPagePageCompletionCalled, false)
    }
}

// MARK: - Test getItem(with:)

extension MainViewModelTests {
    func testGetModelAtInvalidIndex() {
        // Given

        // When

        let result = sut.getItem(with: 1)

        // Then

        XCTAssertEqual(result, nil)

        XCTAssertEqual(loadingServiceMock.loadingDuringCalled, false)
        XCTAssertEqual(loadingServiceMock.setStateIsShowingCalled, false)

        XCTAssertEqual(navigatorMock.presentAnimatedCompletionCalled, false)

        XCTAssertEqual(networkServiceMock.searchRepositoriesSearchTermPerPagePageCompletionCalled, false)
    }

    func testGetModelAtValidIndex() {
        // Given

        let networkResult = SearchModel(items: [.init(id: 1,
                                                      name: "Repository 1",
                                                      owner: .init(name: "Owner 1", avatarUrl: "avatarUrl 1"),
                                                      description: "Description 1",
                                                      language: "Language 1",
                                                      stars: 20,
                                                      url: "Invalid url 1",
                                                      forks: 25),
                                                .init(id: 2,
                                                      name: "Repository 2",
                                                      owner: .init(name: "Owner 2", avatarUrl: "avatarUrl 2"),
                                                      description: "Description 2",
                                                      language: "Language 2",
                                                      stars: 21,
                                                      url: "Invalid url 2",
                                                      forks: 26)])

        // When

        let index = 1
        sut.searchModelSubject.send(networkResult)
        let result = sut.getItem(with: index)

        // Then

        XCTAssertEqual(result, networkResult.items[index])

        XCTAssertEqual(loadingServiceMock.loadingDuringCalled, false)
        XCTAssertEqual(loadingServiceMock.setStateIsShowingCalled, false)

        XCTAssertEqual(navigatorMock.presentAnimatedCompletionCalled, false)

        XCTAssertEqual(networkServiceMock.searchRepositoriesSearchTermPerPagePageCompletionCalled, false)
    }
}
// swiftlint:enable force_cast
