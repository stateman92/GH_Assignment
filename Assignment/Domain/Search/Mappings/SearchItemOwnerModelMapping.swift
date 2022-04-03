//
//  SearchItemOwnerModelMapping.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import Assignment_Swagger

extension SearchItemOwnerModel: Mappable {
    init(from mapped: SearchResponseItemOwnerDTO) {
        self.init(name: mapped.login, avatarUrl: mapped.avatarUrl)
    }

    var mapped: SearchResponseItemOwnerDTO {
        .init(from: self)
    }
}

extension SearchResponseItemOwnerDTO: Mappable {
    init(from mapped: SearchItemOwnerModel) {
        self.init(login: mapped.name, avatarUrl: mapped.avatarUrl)
    }

    var mapped: SearchItemOwnerModel {
        .init(from: self)
    }
}
