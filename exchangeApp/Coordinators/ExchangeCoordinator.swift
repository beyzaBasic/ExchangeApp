//
//  ExchangeCoordinator.swift
//  exchangeApp
//
//  Created by Beyza Paksin on 10.02.2022.
//

import UIKit

// MARK: - Class Bone
class ExchangeCoordinator: Coordinator {
    // MARK: Attributes
    var children: [Coordinator] = []
    let router: Router

    func start(_ actionType: ExchangeActionType?, animated: Bool, onDismissed: (() -> Void)?) {
        switch actionType {
        case .selection:
            let viewModel = CurrencySelectionViewModel()
            viewModel.viewModelCoordinationDelegate = self
            let viewController = CurrencySelectionViewController(viewModel: viewModel)
            viewController.view.backgroundColor = .gray
            self.router.present(viewController, animated: true)
        case .confirmation:
            let viewModel = ConfirmationViewModel()
            viewModel.viewModelCoordinationDelegate = self
            let viewController = ConfirmationViewController(viewModel: viewModel)
            viewController.view.backgroundColor = .cyan
            self.router.present(viewController, animated: true)
        case .success:
            let viewModel = SuccessViewModel()
            viewModel.viewModelCoordinationDelegate = self
            let viewController = SuccessViewController(viewModel: viewModel)
            viewController.view.backgroundColor = .yellow
            self.router.present(viewController, animated: true)
        case .none:
            break
        }
    }

    required init(router: Router) {
        self.router = router
    }
}

extension ExchangeCoordinator: CurrencySelectionViewModelCoordinationDelegate {
    func currencySelected(exchangeState: ExchangeState, selectedCurrency: String) {
        self.dismiss(animated: true)
    }
}

extension ExchangeCoordinator: ConfirmationViewModelCoordinationDelegate {
    func cancel() {
        self.dismiss(animated: true)
    }
    func confirm() {
        self.dismiss(animated: true, completion: {
            self.start(.success, animated: true, onDismissed: nil)
        })
    }
}

extension ExchangeCoordinator: SuccessViewModelCoordinationDelegate {
    func backToHome() {
        self.dismiss(animated: true)
    }

}

