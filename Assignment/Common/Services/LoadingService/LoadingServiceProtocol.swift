//
//  LoadingServiceProtocol.swift
//  Assignment
//
//  Created by Kristof Kalai on 2022. 04. 03..
//

import Combine

protocol LoadingServiceProtocol {
    var state: AnyPublisher<Bool, Never> { get }

    func setState(isShowing showing: Bool)
    func loading(during closure: (@escaping () -> Void) -> Void)
}
