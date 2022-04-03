//
//  SearchModelMapping.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import Assignment_Swagger

extension SearchModel: Mappable {
    /// Create an object from its mapped counterpart.
    init(from mapped: SearchResponseDTO) {
        self.init(items: mapped.items.map(\.mapped))
    }

    /// Get the mapped object.
    var mapped: SearchResponseDTO {
        .init(from: self)
    }
}

extension SearchResponseDTO: Mappable {
    /// Create an object from its mapped counterpart.
    init(from mapped: SearchModel) {
        self.init(items: mapped.items.map(\.mapped))
    }

    /// Get the mapped object.
    var mapped: SearchModel {
        .init(from: self)
    }
}
