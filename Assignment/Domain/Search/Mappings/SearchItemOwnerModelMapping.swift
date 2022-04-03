//
//  SearchItemOwnerModelMapping.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import Assignment_Swagger

extension SearchItemOwnerModel: Mappable {
    /// Create an object from its mapped counterpart.
    init(from mapped: SearchResponseItemOwnerDTO) {
        self.init(name: mapped.login, avatarUrl: mapped.avatarUrl)
    }

    /// Get the mapped object.
    var mapped: SearchResponseItemOwnerDTO {
        .init(from: self)
    }
}

extension SearchResponseItemOwnerDTO: Mappable {
    /// Create an object from its mapped counterpart.
    init(from mapped: SearchItemOwnerModel) {
        self.init(login: mapped.name, avatarUrl: mapped.avatarUrl)
    }

    /// Get the mapped object.
    var mapped: SearchItemOwnerModel {
        .init(from: self)
    }
}
