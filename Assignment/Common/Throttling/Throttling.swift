//
//  Throttling.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import Foundation

/// A property wrapper for a value that should be throttled.
@propertyWrapper final class Throttling<T> {
    // MARK: Properties

    private var value: T
    private var callback: (T) -> Void = { _ in }
    private var timer: Timer?
    private let timeInterval: TimeInterval

    /// The actual value (without throttling).
    var wrappedValue: T {
        get {
            value
        }
        set {
            value = newValue
            throttling(timeInterval: timeInterval)
        }
    }

    /// The property wrapper.
    var projectedValue: Throttling<T> {
        self
    }

    // MARK: Initialization

    init(wrappedValue: T, seconds: TimeInterval) {
        value = wrappedValue
        timeInterval = seconds
    }
}

// MARK: - Public methods

extension Throttling {
    /// Call the receive a callback if a value should be processed.
    /// - Parameter throttled: in this closure the value has already throttled.
    func on(throttled: @escaping (T) -> Void) {
        callback = throttled
    }

    /// Force a value to be processed. Be careful, it can put some weight on your code (and performance).
    /// - Parameter value: the new value.
    func force(value: T) {
        timer?.invalidate()
        wrappedValue = value
        throttling(timeInterval: .zero)
    }
}

// MARK: - Private methods

extension Throttling {
    private func throttling(timeInterval: TimeInterval) {
        timer?.invalidate()
        timer = .scheduledTimer(withTimeInterval: timeInterval, repeats: false) { [weak self] _ in
            guard let self = self else { return }
            self.callback(self.value)
        }
    }
}
