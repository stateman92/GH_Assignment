//
//  NetworkServiceProtocol.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 03..
//

import Assignment_Swagger

/// Network errors.
enum NetworkError: Error {
    case unknown
}

/// Types of sortings.
enum SearchSort: String {
    case stars
    case forks
    case helpWantedIssues
    case updated

    var asQueryParameter: String {
        switch self {
        case .helpWantedIssues: return "help-wanted-issues"
        default: return rawValue
        }
    }
}

/// Types of ordering.
enum SearchOrder: String {
    case desc
    case asc

    var asQueryParameter: String {
        rawValue
    }
}

protocol NetworkServiceProtocol {
    func searchRepositories(searchTerm: String,
                            perPage: Int,
                            page: Int,
                            completion: @escaping (Result<SearchResponseDTO, Error>) -> Void)
}
