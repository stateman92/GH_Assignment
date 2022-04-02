//
//  SearchItemModelMapping.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import Assignment_Swagger

extension SearchItemModel: Mappable {
    init(from otherType: SearchResponseItemDTO) {
        self.init(id: otherType._id,
                  name: otherType.name,
                  owner: otherType.owner.otherType,
                  description: otherType._description,
                  language: otherType.language,
                  stars: otherType.stargazersCount,
                  url: otherType.url)
    }

    var otherType: SearchResponseItemDTO {
        .init(from: self)
    }
}

extension SearchResponseItemDTO: Mappable {
    init(from otherType: SearchItemModel) {
        self.init(_id: otherType.id,
                  name: otherType.name,
                  owner: otherType.owner.otherType,
                  _description: otherType.description,
                  language: otherType.language,
                  stargazersCount: otherType.stars,
                  url: otherType.url)
    }

    var otherType: SearchItemModel {
        .init(from: self)
    }
}
