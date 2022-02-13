//
//  Coordinator.swift
//  exchangeApp
//
//  Created by Beyza Paksin on 10.02.2022.
//

import UIKit

protocol Coordinator: AnyObject {

    var children: [Coordinator] { get set }
    var router: Router { get }
    func start (_ actionType: ExchangeActionType?, animated: Bool, onDismissed: (() -> Void)?)
    func dismiss(animated: Bool, completion:(() -> Void)?)
    func startChild(_ actionType: ExchangeActionType?, _ child: Coordinator, animated: Bool, onDismissed: (() -> Void)?)
}

extension Coordinator {

    func dismiss(animated: Bool, completion:(() -> Void)? = nil) {
        self.router.dismiss(animated: animated, completion: completion)
    }

    func startChild(_ actionType: ExchangeActionType?, _ child: Coordinator, animated: Bool, onDismissed: (() -> Void)? = nil) {
        self.children.append(child)
        child.start(actionType, animated: animated) { [weak self] in
            guard let self = self else { return }
            self.removeChild(child)
            onDismissed?()
        }
    }

    private func removeChild(_ child: Coordinator) {
        guard let index = children.firstIndex(where: { coordinator in
            coordinator === child
        }) else { return}
        self.children.remove(at: index)

    }
}

