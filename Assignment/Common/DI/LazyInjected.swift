//
//  LazyInjected.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import Factory

/// A thin layer between the application and the DI library (Factory).
/// The dependency will be resolver lazily (at the first time you want to use).
@propertyWrapper struct LazyInjected<T> {
    private var factory: Factory<T>
    private var dependency: T!
    private var initialize = true

    init(_ factory: Factory<T>) {
        self.factory = factory
    }

    /// The injected object.
    var wrappedValue: T {
        mutating get {
            if initialize {
                initialize = false
                dependency = factory()
            }
            return dependency
        }
        mutating set {
            initialize = false
            dependency = newValue
        }
    }

    /// The property wrapper.
    var projectedValue: Self {
        get { self }
        mutating set { self = newValue }
    }
}
