//
//  MainTableViewCell.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import UIKit

final class MainTableViewCell: UITableViewCell {
    private let cellContentView = ContentView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainTableViewCell {
    override func prepareForReuse() {
        super.prepareForReuse()
        cellContentView.prepareForReuse()
    }
}

extension MainTableViewCell {
    private func setupUI() {
        cellContentView.configure {
            contentView.addSubview($0)
            $0.anchorToSuperview(top: .zero, bottom: .zero, leading: .zero, trailing: .zero)
        }
    }
}

extension MainTableViewCell {
    func setup(with model: SearchItemModel) {
        cellContentView.setup(with: model)
    }
}
