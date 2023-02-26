//
//  DependencyInjector.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import UIKit
import Factory

/// A thin layer between the application and the DI library (Resolver).
struct DependencyInjector {
    static let networkService = create { NetworkServiceImpl() as NetworkService }
    static let loadingService = create(scope: .shared) { LoadingServiceImpl() as LoadingService }
    static let navigationController = create(scope: .shared) {
        UINavigationController(rootViewController: DependencyInjector.mainScreen()) as Navigator
    }
}

extension DependencyInjector {
    static func create<T>(scope: SharedContainer.Scope? = .none, factory: @escaping () -> T) -> Factory<T> {
        Factory(scope: scope, factory: factory)
    }
}
