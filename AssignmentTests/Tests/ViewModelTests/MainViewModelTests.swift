//
//  MainViewModelTests.swift
//  AssignmentTests
//
//  Created by Kristof Kalai on 2022. 04. 04..
//

import XCTest
import Combine
@testable import Assignment

// swiftlint:disable force_cast
final class MainViewModelTests: BaseTestCase {
    // MARK: Properties

    private var sut: MainViewModel!
    private var cancellables: Set<AnyCancellable>!

    private var loadingService: LoadingServiceProtocolMock {
        sut.loadingService as! LoadingServiceProtocolMock
    }

    private var navigatorMock: NavigatorMock {
        sut.navigator as! NavigatorMock
    }

    private var networkServiceMock: NetworkServiceProtocolMock {
        sut.networkService as! NetworkServiceProtocolMock
    }
}

// MARK: - Overridden methods

extension MainViewModelTests {
    override func setUp() {
        super.setUp()
        cancellables = .init()
        sut = MainViewModel()
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

        XCTAssertEqual(loadingService.loadingDuringCalled, false)
        XCTAssertEqual(loadingService.setStateIsShowingCalled, false)

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

        loadingService.loadingDuringClosure = {
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

        XCTAssertEqual(loadingService.loadingDuringCallsCount, 1)
        XCTAssertEqual(loadingService.setStateIsShowingCalled, false)

        XCTAssertEqual(navigatorMock.presentAnimatedCompletionCalled, false)

        XCTAssertEqual(networkServiceMock.searchRepositoriesSearchTermPerPagePageCompletionCallsCount, 1)
    }

    func testSearchTermDidChangeToNotEmptyStringUnsuccessfulSearch() {
        // Given

        let searchTerm = "swift"
        let networkError = NetworkError.unknown

        loadingService.setStateIsShowingClosure = {
            XCTAssertEqual($0, true)
        }

        loadingService.loadingDuringClosure = {
            $0 { }
        }

        networkServiceMock
            .searchRepositoriesSearchTermPerPagePageCompletionClosure = { searchTerm, perPage, page, closure in
                XCTAssertEqual(searchTerm, searchTerm)
                XCTAssertEqual(perPage, 10)
                XCTAssertEqual(page, 1)
                closure(.failure(networkError))
            }

        sut.errorSubject
            .sink { XCTAssert($0 as? NetworkError == networkError) }
            .store(in: &cancellables)

        // When

        sut.searchTerm = searchTerm
        wait(for: 1)

        // Then

        let result = sut.searchModelSubject.value
        XCTAssertEqual(result.items, [])

        XCTAssertEqual(loadingService.loadingDuringCallsCount, 1)
        XCTAssertEqual(loadingService.setStateIsShowingCalled, false)

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

        XCTAssertEqual(loadingService.loadingDuringCalled, false)
        XCTAssertEqual(loadingService.setStateIsShowingCalled, false)

        XCTAssertEqual(navigatorMock.presentAnimatedCompletionCallsCount, 1)

        XCTAssertEqual(networkServiceMock.searchRepositoriesSearchTermPerPagePageCompletionCalled, false)
    }

    func testRepositorySelectedInvalidIndex() {
        // Given

        // When

        sut.didSelect(index: 1)

        // Then

        XCTAssertEqual(loadingService.loadingDuringCalled, false)
        XCTAssertEqual(loadingService.setStateIsShowingCalled, false)

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

        XCTAssertEqual(loadingService.loadingDuringCalled, false)
        XCTAssertEqual(loadingService.setStateIsShowingCalled, false)

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

        XCTAssertEqual(loadingService.loadingDuringCalled, false)
        XCTAssertEqual(loadingService.setStateIsShowingCalled, false)

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

        XCTAssertEqual(loadingService.loadingDuringCalled, false)
        XCTAssertEqual(loadingService.setStateIsShowingCalled, false)

        XCTAssertEqual(navigatorMock.presentAnimatedCompletionCalled, false)

        XCTAssertEqual(networkServiceMock.searchRepositoriesSearchTermPerPagePageCompletionCalled, false)
    }
}
// swiftlint:enable force_cast
