//
//  Mappable.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

protocol Mappable {
    associatedtype MappingType

    init(from mapped: MappingType)
    var mapped: MappingType { get }
}
