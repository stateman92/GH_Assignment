//
//  NameView.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import UIKit

final class NameView: UIStackView {
    private let ownerLabel = Label()
    private let repositoryNameLabel = Label()

    init() {
        super.init(frame: .zero)
        setupUI()
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

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
            $0.lineBreakStrategy = []
            $0.font = .systemFont(ofSize: 20, weight: .bold)

            addArrangedSubview($0)
        }
    }

    private func setupRepositoryNameLabel() {
        repositoryNameLabel.configure {
            $0.numberOfLines = 0
            $0.lineBreakStrategy = []
            $0.font = .systemFont(ofSize: 15)

            addArrangedSubview($0)
        }
    }
}

extension NameView {
    func setup(owner: String, repository: String) {
        ownerLabel.text = owner
        repositoryNameLabel.text = repository
    }
}
