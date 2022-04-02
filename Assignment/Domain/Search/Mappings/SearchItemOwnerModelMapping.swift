//
//  SearchItemOwnerModelMapping.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import Assignment_Swagger

extension SearchItemOwnerModel: Mappable {
    init(from otherType: SearchResponseItemOwnerDTO) {
        self.init(name: otherType.login, avatarUrl: otherType.avatarUrl)
    }

    var otherType: SearchResponseItemOwnerDTO {
        .init(from: self)
    }
}

extension SearchResponseItemOwnerDTO: Mappable {
    init(from otherType: SearchItemOwnerModel) {
        self.init(login: otherType.name, avatarUrl: otherType.avatarUrl)
    }

    var otherType: SearchItemOwnerModel {
        .init(from: self)
    }
}
