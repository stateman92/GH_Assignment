//
//  ContentView.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import UIKit

final class ContentView: View {
    // MARK: Properties

    private let cardView = View()
    private let starView = AttributeView(image: UIImage(systemSymbol: .starFill),
                                         tintColor: .systemYellow.withAlphaComponent(0.75))
    private let forkView = AttributeView(image: UIImage(systemSymbol: .tuningfork),
                                         tintColor: .systemGray.withAlphaComponent(0.75))
    private let nameView = NameView()
    private let imageView = LoadableImageView()
    private let descriptionLabel = Label()
    private let languageView = LanguageView()

    // MARK: Initialization

    override init() {
        super.init()
        setupUI()
    }
}

// MARK: - Setups

extension ContentView {
    private func setupUI() {
        setupCardView()
        setupStarView()
        setupForkView()
        setupNameView()
        setupImageView()
        setupDescriptionLabel()
        setupLanguageView()
    }

    private func setupCardView() {
        cardView.configure {
            $0.layer.cornerRadius = 24
            $0.backgroundColor = .systemGray6

            addSubview($0)

            $0.anchorToSuperview(top: 8, bottom: -8, leading: 16, trailing: -16)
        }
    }

    private func setupStarView() {
        starView.configure {
            cardView.addSubview($0)
            $0.anchorToSuperview(top: 16, trailing: -16)
        }
    }

    private func setupForkView() {
        forkView.configure {
            cardView.addSubview($0)

            $0.topAnchor.constraint(equalTo: starView.bottomAnchor, constant: 8).isActive = true
            $0.anchorToSuperview(trailing: -16)
        }
    }

    private func setupNameView() {
        nameView.configure {
            cardView.addSubview($0)

            $0.anchorToSuperview(top: 16, leading: 16)
            $0.trailingAnchor.constraint(lessThanOrEqualTo: starView.leadingAnchor, constant: -16).isActive = true
        }
    }

    private func setupImageView() {
        imageView.configure {
            $0.layer.cornerRadius = 24
            $0.layer.masksToBounds = true
            $0.contentMode = .scaleAspectFit
            $0.backgroundColor = .white.withAlphaComponent(0.5)

            cardView.addSubview($0)

            $0.setWidth(100)
            $0.setHeight(100)
            $0.anchorToLeading(constant: 16)
            $0.topAnchor.constraint(greaterThanOrEqualTo: nameView.bottomAnchor, constant: 8).isActive = true
            $0.topAnchor.constraint(greaterThanOrEqualTo: forkView.bottomAnchor, constant: 8).isActive = true
        }
    }

    private func setupDescriptionLabel() {
        descriptionLabel.configure {
            $0.numberOfLines = 0

            cardView.addSubview($0)

            $0.anchorToTrailing(constant: -16)
            $0.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 8).isActive = true
            $0.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16).isActive = true
        }
    }

    private func setupLanguageView() {
        languageView.configure {
            cardView.addSubview($0)

            $0.anchorToBottom(constant: -16)
            $0.anchorToTrailing(constant: -16)
            $0.topAnchor.constraint(greaterThanOrEqualTo: imageView.bottomAnchor, constant: 16).isActive = true
            $0.topAnchor.constraint(greaterThanOrEqualTo: descriptionLabel.bottomAnchor, constant: 16).isActive = true
        }
    }
}

// MARK: - Public methods

extension ContentView {
    /// Setup the view with a model.
    /// - Parameter model: the model.
    func setup(with model: SearchItemModel) {
        imageView.load(url: model.owner.avatarUrl)
        nameView.setup(owner: model.owner.name, repository: model.name)
        languageView.setup(language: model.language)
        starView.setup(text: String(model.stars))
        forkView.setup(text: String(model.forks))
        descriptionLabel.text = model.description
    }

    /// Call to cancel the image loading on the view.
    func cancelImageLoading() {
        imageView.cancelImageLoading()
    }
}
