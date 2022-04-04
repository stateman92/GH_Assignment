//
//  Mock+DI.swift
//  AssignmentTests
//
//  Created by Kristof Kalai on 2022. 04. 04..
//

@testable import Assignment

extension DependencyInjector {
    /// Register all the dependencies of the application for tests.
    static func registerDependenciesForTests() {
        registerServicesForTests()
    }
}

extension DependencyInjector {
    private static func registerServicesForTests() {
        resolver.register { NetworkServiceProtocolMock() }.implements(NetworkServiceProtocol.self).scope(.unique)
        resolver.register { LoadingServiceProtocolMock() }.implements(LoadingServiceProtocol.self).scope(.unique)
        resolver.register { NavigatorMock() }.implements(Navigator.self).scope(.unique)
    }
}
