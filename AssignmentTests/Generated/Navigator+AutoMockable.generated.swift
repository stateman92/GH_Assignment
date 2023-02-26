// Generated using Sourcery 2.0.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import Assignment_Swagger
import Combine
import UIKit
@testable import Assignment

class NavigatorMock: Navigator {

    //MARK: - present

    var presentAnimatedCompletionCallsCount = 0
    var presentAnimatedCompletionCalled: Bool {
        return presentAnimatedCompletionCallsCount > 0
    }
    var presentAnimatedCompletionReceivedArguments: (viewControllerToPresent: UIViewController, flag: Bool, completion: (() -> Void)?)?
    var presentAnimatedCompletionReceivedInvocations: [(viewControllerToPresent: UIViewController, flag: Bool, completion: (() -> Void)?)] = []
    var presentAnimatedCompletionClosure: ((UIViewController, Bool, (() -> Void)?) -> Void)?

    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
        presentAnimatedCompletionCallsCount += 1
        presentAnimatedCompletionReceivedArguments = (viewControllerToPresent: viewControllerToPresent, flag: flag, completion: completion)
        presentAnimatedCompletionReceivedInvocations.append((viewControllerToPresent: viewControllerToPresent, flag: flag, completion: completion))
        presentAnimatedCompletionClosure?(viewControllerToPresent, flag, completion)
    }

}
