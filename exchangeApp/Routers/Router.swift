//
//  Router.swift
//  exchangeApp
//
//  Created by Beyza Paksin on 10.02.2022.
//

import UIKit

public protocol Router: AnyObject {
    func present(_ viewController: UIViewController, animated: Bool)
    func present(_ viewController: UIViewController,
                 animated: Bool,
                 onDismissed: (()->Void)?)
    func dismiss(animated: Bool, completion: (() -> Void)?)
}

extension Router {
    func present(_ viewController: UIViewController,
                        animated: Bool) {
        present(viewController, animated: animated, onDismissed: nil)
    }

    func dismiss(animated: Bool, completion: (() -> Void)? = nil) {
        // implement in Classes
    }
}
