//
//  SearchSort.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 03..
//

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
