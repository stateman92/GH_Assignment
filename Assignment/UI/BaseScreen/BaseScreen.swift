//
//  BaseScreen.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import UIKit
import Combine

class BaseTableScreen<ViewModel: BaseViewModel>: UITableViewController {
    // MARK: Properties

    @LazyInjected(DependencyInjector.loadingService) private var loadingService
    var cancellables = Set<AnyCancellable>()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        loadingService.state
            .sink { LoadingOverlay.shared.set(isShowing: $0) }
            .store(in: &cancellables)
    }
}
