//
//  StarView.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import UIKit
import SFSafeSymbols

final class StarView: View {
    private let label = Label()
    private let imageView = ImageView()

    override init() {
        super.init()
        setupUI()
    }
}

// MARK: - Setups

extension StarView {
    private func setupUI() {
        layer.cornerRadius = 16
        backgroundColor = .systemBackground.withAlphaComponent(0.5)

        setupLabel()
        setupImageView()
    }

    private func setupLabel() {
        label.configure {
            $0.font = .systemFont(ofSize: 14)

            addSubview($0)

            $0.anchorToSuperview(top: 8, bottom: -8, leading: 16)
        }
    }

    private func setupImageView() {
        imageView.configure {
            $0.image = UIImage(systemSymbol: .starFill)
            $0.tintColor = .systemYellow.withAlphaComponent(0.75)

            addSubview($0)

            $0.anchorToCenterY()
            $0.anchorToTrailing(constant: -16)
            $0.widthAnchor.constraint(equalTo: $0.heightAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 4).isActive = true
        }
    }
}

extension StarView {
    func setup(number: Int) {
        label.text = String(number)
    }
}
