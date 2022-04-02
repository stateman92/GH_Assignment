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

extension AppLoader {
    /// Setup the necessary business logic-related things.
    func setup() {
        DependencyInjector.registerDependencies()
    }

    /// Setup the necessary UI-related things.
    func setupUI(in windowScene: UIWindowScene) -> UIWindow {
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = DependencyInjector.resolve() as UINavigationController
        window.makeKeyAndVisible()
        return window
    }
}
