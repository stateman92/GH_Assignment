//
//  BaseScreen.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 02..
//

import UIKit
import Resolver

class BaseScreen<ViewModel: BaseViewModel>: UIViewController {
    @LazyInjected var viewModel: ViewModel
}
