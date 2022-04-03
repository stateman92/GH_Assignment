//
//  EmptyStateView.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import Lottie

final class EmptyStateView: View {
    // MARK: Properties

    private let lottie = AnimationView(name: "searching")

    // MARK: Initialization

    override init() {
        super.init()
        setupUI()
    }
}

// MARK: - Setups

extension EmptyStateView {
    private func setupUI() {
        setupLottie()
    }

    private func setupLottie() {
        lottie.configure {
            $0.play()
            $0.loopMode = .loop

            addSubview($0)

            $0.widthAnchor.constraint(equalTo: $0.heightAnchor).isActive = true
            $0.anchorToSuperview(top: .zero, bottom: .zero, leading: .zero, trailing: .zero)
        }
    }
}

// MARK: - Public methods

extension EmptyStateView {
    /// Play the animation.
    func play() {
        lottie.play()
    }

    /// Pause the animation.
    func pause() {
        lottie.pause()
    }
}
