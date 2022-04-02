//
//  NetworkService.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import Assignment_Swagger

struct NetworkService { }

// MARK: - Nested types

extension NetworkService {
    enum NetworkError: Error {
        case unknown
    }

    enum SearchSort: String {
        case stars
        case forks
        case helpWantedIssues
        case updated

        fileprivate var asQueryParameter: String {
            switch self {
            case .helpWantedIssues: return "help-wanted-issues"
            default: return rawValue
            }
        }
    }

    enum SearchOrder: String {
        case desc
        case asc

        fileprivate var asQueryParameter: String {
            rawValue
        }
    }
}

// MARK: - Search endpoints

extension NetworkService {
    func searchRepositories(searchTerm: String,
                            sort: SearchSort? = nil,
                            order: SearchOrder? = nil,
                            perPage: Int? = nil,
                            page: Int? = nil,
                            completion: @escaping (Result<SearchResponseDTO, Error>) -> Void) {
        SearchAPI.searchRepositoriesGetWithRequestBuilder(accept: "application/vnd.github.v3+json",
                                                          q: searchTerm,
                                                          sort: sort?.asQueryParameter,
                                                          order: order?.asQueryParameter,
                                                          perPage: perPage,
                                                          page: page).execute { response, error in
            if let searchResponse = response?.body {
                completion(.success(searchResponse))
            } else if let error = error {
                completion(.failure(error))
            } else {
                completion(.failure(NetworkError.unknown))
            }
        }
    }
}
