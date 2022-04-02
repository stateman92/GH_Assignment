//
//  DependencyInjector.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import UIKit
import Resolver

/// A thin layer between the application and the DI library (Resolver).
public struct DependencyInjector {
    static let resolver = Resolver()

    private init() { }
}

extension DependencyInjector {
    /// Register all the dependencies of the application.
    static func registerDependencies() {
        registerScreens()

        resolver.register { UINavigationController(rootViewController: resolve() as MainScreen) }.scope(.shared)
    }

    /// Resolve a given type of dependency.
    static func resolve<Service>() -> Service {
        resolver.resolve()
    }
}

extension DependencyInjector {
    private static func registerScreens() {
        resolver.register { MainScreen() }
    }
}
