//
//  SearchItemModel.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

struct SearchItemModel {
    let id: Int
    let name: String
    let owner: SearchItemOwnerModel
    let description: String
    let language: String
    let stars: Int
    let url: String
    let forks: Int
}

extension SearchItemModel: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
