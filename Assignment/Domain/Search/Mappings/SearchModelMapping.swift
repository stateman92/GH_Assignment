//
//  SearchModelMapping.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import Assignment_Swagger

extension SearchModel: Mappable {
    init(from mapped: SearchResponseDTO) {
        self.init(items: mapped.items.map(\.mapped))
    }

    var mapped: SearchResponseDTO {
        .init(from: self)
    }
}

extension SearchResponseDTO: Mappable {
    init(from mapped: SearchModel) {
        self.init(items: mapped.items.map(\.mapped))
    }

    var mapped: SearchModel {
        .init(from: self)
    }
}
