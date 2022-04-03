//
//  SearchOrder.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 03..
//

/// Types of ordering.
enum SearchOrder: String {
    case desc
    case asc

    var asQueryParameter: String {
        rawValue
    }
}
