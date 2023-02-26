//
//  UILabel+Extensions.swift
//  Assignment
//
//  Created by Kristóf Kálai on 2023. 02. 26..
//

import UIKit

extension UILabel {
    func set(lineBreakStrategy: NSParagraphStyle.LineBreakStrategy) {
        if #available(iOS 14.0, *) {
            self.lineBreakStrategy = lineBreakStrategy
        }
    }
}
