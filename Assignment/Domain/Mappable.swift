//
//  Mappable.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

/// General protocol for mapping.
protocol Mappable {
    associatedtype MappingType

    /// Create an object from its mapped counterpart.
    init(from mapped: MappingType)

    /// Get the mapped object.
    var mapped: MappingType { get }
}
