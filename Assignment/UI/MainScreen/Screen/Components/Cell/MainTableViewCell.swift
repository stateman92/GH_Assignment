//
//  MainTableViewCell.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import UIKit

final class MainTableViewCell: UITableViewCell {
    // MARK: Properties

    private let cellContentView = ContentView()

    // MARK: Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Overridden methods

extension MainTableViewCell {
    override func prepareForReuse() {
        super.prepareForReuse()
        cellContentView.cancelImageLoading()
    }
}

// MARK: - Setups

extension MainTableViewCell {
    private func setupUI() {
        cellContentView.configure {
            contentView.addSubview($0)
            $0.anchorToSuperview(top: .zero, bottom: .zero, leading: .zero, trailing: .zero)
        }
    }
}

// MARK: - Public methods

extension MainTableViewCell {
    /// Setup the view with a model.
    /// - Parameter model: the model.
    func setup(with model: SearchItemModel) {
        cellContentView.setup(with: model)
    }
}
