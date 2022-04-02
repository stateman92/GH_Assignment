//
//  Mappable.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

protocol Mappable {
    associatedtype OtherType

    init(from otherType: OtherType)
    var otherType: OtherType { get }
}
