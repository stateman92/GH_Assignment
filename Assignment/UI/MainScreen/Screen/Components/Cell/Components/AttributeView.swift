//
//  AttributeView.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import UIKit
import SFSafeSymbols

final class AttributeView: View {
    // MARK: Properties

    private let label = Label()
    private let imageView: ImageView

    // MARK: Initialization

    init(image: UIImage, tintColor: UIColor) {
        imageView = ImageView().configure {
            $0.image = image
            $0.tintColor = tintColor
        }
        super.init()
        setupUI()
    }
}

// MARK: - Setups

extension AttributeView {
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
            addSubview($0)

            $0.anchorToCenterY()
            $0.anchorToTrailing(constant: -16)
            $0.widthAnchor.constraint(equalTo: $0.heightAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 4).isActive = true
        }
    }
}

// MARK: - Public methods

extension AttributeView {
    /// Setup the view with a text.
    /// - Parameter text: the text.
    func setup(text: String) {
        label.text = text
    }
}
