//
//  ImageView.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import UIKit

class ImageView: UIImageView {
    // MARK: Initialization

    init() {
        super.init(frame: .zero)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setups

extension ImageView {
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}
