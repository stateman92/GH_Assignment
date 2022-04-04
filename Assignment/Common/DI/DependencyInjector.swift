//
//  DependencyInjector.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import UIKit
import Resolver

/// A thin layer between the application and the DI library (Resolver).
struct DependencyInjector {
    static let resolver = Resolver()

    private init() { }
}

extension DependencyInjector {
    /// Register all the dependencies of the application.
    static func registerDependencies() {
        registerModules()
        registerServices()
    }

    /// Resolve a given type of dependency.
    static func resolve<Service>() -> Service {
        resolver.resolve()
    }
}

extension DependencyInjector {
    private static func registerModules() {
        registerMainModule()
    }

    private static func registerServices() {
        resolver.register { NetworkService() }.implements(NetworkServiceProtocol.self)
        resolver.register { LoadingService() }.implements(LoadingServiceProtocol.self).scope(.shared)

        resolver
            .register { UINavigationController(rootViewController: resolve() as MainScreen) }
            .implements(Navigator.self)
            .scope(.shared)
    }
}
