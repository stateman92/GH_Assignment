//
//  NameView.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import UIKit

final class NameView: UIStackView {
    // MARK: Properties

    private let ownerLabel = Label()
    private let repositoryNameLabel = Label()

    // MARK: Initialization

    init() {
        super.init(frame: .zero)
        setupUI()
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setups

extension NameView {
    private func setupUI() {
        spacing = 4
        axis = .vertical
        translatesAutoresizingMaskIntoConstraints = false

        setupOwnerName()
        setupRepositoryNameLabel()
    }

    private func setupOwnerName() {
        ownerLabel.configure {
            $0.numberOfLines = 0
            $0.set(lineBreakStrategy: [])
            $0.font = .systemFont(ofSize: 21, weight: .bold)

            addArrangedSubview($0)
        }
    }

    private func setupRepositoryNameLabel() {
        repositoryNameLabel.configure {
            $0.numberOfLines = 0
            $0.set(lineBreakStrategy: [])
            $0.font = .systemFont(ofSize: 17)

            addArrangedSubview($0)
        }
    }
}

// MARK: - Public methods

extension NameView {
    /// Setup the view with an owner and a repository name..
    /// - Parameter owner: the name of the owner.
    /// - Parameter repository: the name of the repository.
    func setup(owner: String, repository: String) {
        ownerLabel.text = owner
        repositoryNameLabel.text = repository
    }
}
