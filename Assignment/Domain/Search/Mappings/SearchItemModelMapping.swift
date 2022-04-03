//
//  SearchItemModelMapping.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import Assignment_Swagger

extension SearchItemModel: Mappable {
    init(from mapped: SearchResponseItemDTO) {
        self.init(id: mapped._id,
                  name: mapped.name,
                  owner: mapped.owner.mapped,
                  description: mapped._description,
                  language: mapped.language,
                  stars: mapped.stargazersCount,
                  url: mapped.htmlUrl)
    }

    var mapped: SearchResponseItemDTO {
        .init(from: self)
    }
}

extension SearchResponseItemDTO: Mappable {
    init(from mapped: SearchItemModel) {
        self.init(_id: mapped.id,
                  name: mapped.name,
                  owner: mapped.owner.mapped,
                  _description: mapped.description,
                  language: mapped.language,
                  stargazersCount: mapped.stars,
                  htmlUrl: mapped.url)
    }

    var mapped: SearchItemModel {
        .init(from: self)
    }
}
