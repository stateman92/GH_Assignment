//
//  NSObjectProtocol+Extensions.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import Foundation

extension NSObjectProtocol {
    /// A configure block.
    /// - Parameter block: the configuration block.
    /// - Returns: The configured `Self`.
    @discardableResult func configure(block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
}
