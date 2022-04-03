//
//  EmptyStateView.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import Lottie

final class EmptyStateView: View {
    private let lottie = AnimationView(name: "searching")

    override init() {
        super.init()
        setupUI()
    }
}

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

extension EmptyStateView {
    func play() {
        lottie.play()
    }

    func pause() {
        lottie.pause()
    }
}
