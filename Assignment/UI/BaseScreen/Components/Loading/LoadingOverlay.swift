//
//  LoadingOverlay.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import UIKit

final class LoadingOverlay {
    /// Singleton object.
    static let shared = LoadingOverlay()
    private init() { }

    private let animationDuration = 0.25
    private let loadingOverlayView = LoadingOverlayView()
}

// MARK: - Public methods

extension LoadingOverlay {
    func set(isShowing: Bool) {
        if isShowing {
            show(on: UIApplication.shared.keyWindow)
        } else {
            hide()
        }
    }
}

// MARK: - Private methods

extension LoadingOverlay {
    private func show(on view: UIView?) {
        guard let view = view else { return }

        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        UIApplication.shared.isIdleTimerDisabled = true

        loadingOverlayView.configure {
            view.addSubview($0)
            $0.anchorToSuperview(top: .zero, bottom: .zero, leading: .zero, trailing: .zero)
        }

        loadingOverlayView.alpha = .zero
        UIView.animate(withDuration: animationDuration) { [self] in
            loadingOverlayView.alpha = 1
        }
    }

    private func hide() {
        UIApplication.shared.isIdleTimerDisabled = false

        UIView.animate(withDuration: animationDuration) { [self] in
            loadingOverlayView.alpha = .zero
        } completion: { [self] _ in
            loadingOverlayView.removeFromSuperview()
        }
    }
}
