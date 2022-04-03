//
//  LoadableImageView.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import UIKit
import Kingfisher

final class LoadableImageView: ImageView {
    // MARK: Initialization

    override init() {
        super.init()
        setupUI()
    }
}

// MARK: - Setups

extension LoadableImageView {
    private func setupUI() {
        kf.indicatorType = .activity
    }
}

// MARK: - Public methods

extension LoadableImageView {
    func load(url: String) {
        guard let url = URL(string: url) else { return }
        kf.setImage(with: ImageResource(downloadURL: url),
                    options: [.transition(.fade(0.25)), .cacheMemoryOnly])
    }

    func cancelImageLoading() {
        kf.cancelDownloadTask()
    }
}
