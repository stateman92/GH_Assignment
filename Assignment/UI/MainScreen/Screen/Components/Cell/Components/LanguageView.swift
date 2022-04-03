//
//  LanguageView.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import UIKit

final class LanguageView: View {
    // MARK: Properties

    private let languageLabel = Label()

    // MARK: Initialization

    override init() {
        super.init()
        setupUI()
    }
}

// MARK: - Setups

extension LanguageView {
    private func setupUI() {
        layer.cornerRadius = 16
        backgroundColor = .systemPurple.withAlphaComponent(0.5)

        setupLanguageLabel()
    }

    private func setupLanguageLabel() {
        languageLabel.configure {
            $0.font = .systemFont(ofSize: 17)

            addSubview($0)

            $0.anchorToSuperview(top: 8, bottom: -8, leading: 16, trailing: -16)
        }
    }
}

// MARK: - Public methods

extension LanguageView {
    /// Setup the view with a language.
    /// - Parameter language: the language.
    func setup(language: String) {
        languageLabel.text = language
    }
}
