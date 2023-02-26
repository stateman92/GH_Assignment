//
//  NetworkServiceImpl.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import Assignment_Swagger

/// Service for network calls.
struct NetworkServiceImpl { }

// MARK: - NetworkService

extension NetworkServiceImpl: NetworkService {
    /// Search for GitHub repositories.
    /// - Parameters:
    ///   - searchTerm: the query contains one or more search keywords and qualifiers.
    ///   - perPage: results per page (max 100).
    ///   - page: page number of the results to fetch.
    ///   - completion: a completion handler which holds the result of the call.
    func searchRepositories(searchTerm: String,
                            perPage: Int,
                            page: Int,
                            completion: @escaping (Result<SearchResponseDTO, Error>) -> Void) {
        SearchAPI.searchRepositoriesGetWithRequestBuilder(accept: "application/json",
                                                          q: searchTerm,
                                                          perPage: perPage,
                                                          page: page).execute { response in
            switch response {
            case let .success(success): completion(.success(success.body))
            case let .failure(failure): completion(.failure(failure))
            }
        }
    }
}
