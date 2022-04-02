//
//  SearchModelMapping.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import Assignment_Swagger

extension SearchModel: Mappable {
    init(from otherType: SearchResponseDTO) {
        self.init(totalCount: otherType.totalCount, items: otherType.items.map(\.otherType))
    }

    var otherType: SearchResponseDTO {
        .init(from: self)
    }
}

extension SearchResponseDTO: Mappable {
    init(from otherType: SearchModel) {
        self.init(totalCount: otherType.totalCount, items: otherType.items.map(\.otherType))
    }

    var otherType: SearchModel {
        .init(from: self)
    }
}
