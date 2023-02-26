//
//  BaseViewModel.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import UIKit

class BaseViewModel {
    // MARK: Properties

    @LazyInjected(DependencyInjector.networkService) var networkService
    @LazyInjected(DependencyInjector.loadingService) var loadingService
    @LazyInjected(DependencyInjector.navigationController) var navigator
}
