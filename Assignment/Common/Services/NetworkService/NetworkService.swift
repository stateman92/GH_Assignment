//
//  NetworkService.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 03..
//

import Assignment_Swagger

protocol NetworkService: AutoMockable {
    /// Search for GitHub repositories.
    /// - Parameters:
    ///   - searchTerm: the query contains one or more search keywords and qualifiers.
    ///   - perPage: results per page (max 100).
    ///   - page: page number of the results to fetch.
    ///   - completion: a completion handler which holds the result of the call.
    func searchRepositories(searchTerm: String,
                            perPage: Int,
                            page: Int,
                            completion: @escaping (Result<SearchResponseDTO, Error>) -> Void)
}
