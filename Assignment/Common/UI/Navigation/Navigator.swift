//
//  Navigator.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import UIKit

/// Navigation protocol for in-app navigation.
protocol Navigator: AnyObject {
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?)
}

extension UINavigationController: Navigator { }
