//
//  Mock+DI.swift
//  AssignmentTests
//
//  Created by Kristof Kalai on 2022. 04. 04..
//

@testable import Assignment

extension DependencyInjector {
    static let networkServiceMock = create { NetworkServiceMock() }
    static let loadingServiceMock = create { LoadingServiceMock() }
    static let navigationControllerMock = create { NavigatorMock() }
}
