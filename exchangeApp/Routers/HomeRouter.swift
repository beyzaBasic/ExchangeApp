//
//  AppDelegateRouter.swift
//  exchangeApp
//
//  Created by Beyza Paksin on 10.02.2022.
//

import UIKit

class HomeRouter {
    // MARK: Attributes
    let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }
}
// MARK: - Router
extension HomeRouter: Router {
    func present(_ viewController: UIViewController, animated: Bool, onDismissed: (() -> Void)?) {
        window.makeKeyAndVisible()
        window.rootViewController = viewController
    }

    func dismiss(animated: Bool, completion: (() -> Void)?) {
        // nothing happens
    }
}
