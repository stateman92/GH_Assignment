//
//  AppLoader.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import UIKit

/// A struct that does all the initial tasks.
struct AppLoader {
    /// Singleton object.
    static let shared = AppLoader()
    private init() { }
}

// MARK: - Public methods

extension AppLoader {
    /// Setup the necessary business logic-related things.
    func setup() {
        DependencyInjector.registerDependencies()
    }

    /// Setup the necessary UI-related things.
    /// - Parameter windowScene: the window scene in which the app runs.
    /// - Returns: the window which is made key and visible.
    func setupUI(in windowScene: UIWindowScene) -> UIWindow? {
        let navigator: Navigator = DependencyInjector.resolve()
        guard let navigationController = navigator as? UINavigationController else { return nil }

        navigationController.navigationBar.prefersLargeTitles = true

        return UIWindow(windowScene: windowScene).configure {
            $0.rootViewController = navigationController
            $0.makeKeyAndVisible()
        }
    }
}
