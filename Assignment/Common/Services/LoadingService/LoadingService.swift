//
//  LoadingService.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import Combine

/// Service for showing loading indicator during network calls.
final class LoadingService {
    private let isShowing = CurrentValueSubject<Bool, Never>(false)
}

extension LoadingService: LoadingServiceProtocol {
    /// Set the loading state of the application.
    /// - Parameter showing: whether the loading should be shown.
    func setState(isShowing showing: Bool) {
        isShowing.send(showing)
    }

    func loading(during closure: (@escaping () -> Void) -> Void) {
        setState(isShowing: true)
        closure { [weak self] in
            self?.setState(isShowing: false)
        }
    }

    /// A publisher which emits values when the application's loading state changes.
    var state: AnyPublisher<Bool, Never> {
        isShowing.eraseToAnyPublisher()
    }
}
