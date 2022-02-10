//
//  ExchangeRouter.swift
//  exchangeApp
//
//  Created by Beyza Paksin on 10.02.2022.
//

import UIKit

class ExchangeRouter: NSObject {
    // MARK: Properties
    unowned let parentViewController: UIViewController

    // MARK: Object Lifecycle
    public init(parentViewController: UIViewController) {
        self.parentViewController = parentViewController
        super.init()
    }
}
// MARK: - Router
extension ExchangeRouter: Router {
    func present(_ viewController: UIViewController, animated: Bool, onDismissed: (() -> Void)?) {
        viewController.modalPresentationStyle = .overFullScreen
        self.parentViewController.present(viewController, animated: true, completion: nil)
    }

    func dismiss(animated: Bool, completion: (() -> Void)?) {
        self.parentViewController.dismiss(animated: animated, completion: completion)
    }
}
