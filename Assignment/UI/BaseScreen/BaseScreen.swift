//
//  BaseScreen.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import UIKit
import Combine

class BaseTableScreen<ViewModel: BaseViewModel>: UITableViewController {
    @LazyInjected var loadingService: LoadingServiceProtocol
    @LazyInjected var viewModel: ViewModel
    private let loadingOverlay = LoadingOverlay.shared
    var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadingService.state
            .sink { [unowned self] in loadingOverlay.set(isShowing: $0) }
            .store(in: &cancellables)
    }
}
