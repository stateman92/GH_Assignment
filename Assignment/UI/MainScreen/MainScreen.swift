//
//  MainScreen.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import UIKit
import Resolver

final class MainScreen: BaseScreen<MainViewModel> { }

// MARK: - Lifecycle

extension MainScreen {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
}
