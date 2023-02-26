// Generated using Sourcery 2.0.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import Assignment_Swagger
import Combine
import UIKit
@testable import Assignment

class NetworkServiceMock: NetworkService {

    //MARK: - searchRepositories

    var searchRepositoriesSearchTermPerPagePageCompletionCallsCount = 0
    var searchRepositoriesSearchTermPerPagePageCompletionCalled: Bool {
        return searchRepositoriesSearchTermPerPagePageCompletionCallsCount > 0
    }
    var searchRepositoriesSearchTermPerPagePageCompletionReceivedArguments: (searchTerm: String, perPage: Int, page: Int, completion: (Result<SearchResponseDTO, Error>) -> Void)?
    var searchRepositoriesSearchTermPerPagePageCompletionReceivedInvocations: [(searchTerm: String, perPage: Int, page: Int, completion: (Result<SearchResponseDTO, Error>) -> Void)] = []
    var searchRepositoriesSearchTermPerPagePageCompletionClosure: ((String, Int, Int, @escaping (Result<SearchResponseDTO, Error>) -> Void) -> Void)?

    func searchRepositories(searchTerm: String, perPage: Int, page: Int, completion: @escaping (Result<SearchResponseDTO, Error>) -> Void) {
        searchRepositoriesSearchTermPerPagePageCompletionCallsCount += 1
        searchRepositoriesSearchTermPerPagePageCompletionReceivedArguments = (searchTerm: searchTerm, perPage: perPage, page: page, completion: completion)
        searchRepositoriesSearchTermPerPagePageCompletionReceivedInvocations.append((searchTerm: searchTerm, perPage: perPage, page: page, completion: completion))
        searchRepositoriesSearchTermPerPagePageCompletionClosure?(searchTerm, perPage, page, completion)
    }

}
