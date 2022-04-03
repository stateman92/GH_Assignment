//
//  UIApplication+Extensions.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import UIKit

extension UIApplication {
    /// The key window (if exists).
    var keyWindow: UIWindow? {
        windows.first { $0.isKeyWindow }
    }
}
