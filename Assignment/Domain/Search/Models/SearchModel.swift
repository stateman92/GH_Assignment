//
//  SearchModel.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

struct SearchModel {
    let items: [SearchItemModel]
}

extension SearchModel: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        zip(lhs.items, rhs.items).allSatisfy { $0.0 == $0.1 }
    }
}
