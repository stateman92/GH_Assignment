//
//  BaseViewModel.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import UIKit

class BaseViewModel {
    // MARK: Properties

    @LazyInjected var networkService: NetworkServiceProtocol
    @LazyInjected var loadingService: LoadingServiceProtocol
    @LazyInjected var navigator: Navigator
}
