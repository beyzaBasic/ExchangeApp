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
        case .selection( let exchangeModel):
            let viewModel = CurrencySelectionViewModel(exchangeModel: exchangeModel)
            viewModel.viewModelCoordinationDelegate = self
            let viewController = CurrencySelectionViewController(viewModel: viewModel)
            self.router.present(viewController, animated: true)
            
        case .confirmation( let exchangeModel):
            self.presentConfirmationAlert(exchangeModel: exchangeModel)
            
        case .success( let exchangeModel):
            let viewModel = SuccessViewModel(exchangeModel: exchangeModel)
            viewModel.viewModelCoordinationDelegate = self
            let viewController = SuccessViewController(viewModel: viewModel)
            self.router.present(viewController, animated: true)
        case .none:
            break
        }
    }

    init(router: Router) {
        self.router = router
    }

    private func presentConfirmationAlert(exchangeModel: ExchangeModel) {
        let title = NSLocalizedString("Confirm Operation", comment: "")
        var fromCurrencyMessage = ""
        var toCurrencyMessage = ""
        if let value = exchangeModel.value, let result = exchangeModel.result {
            fromCurrencyMessage = exchangeModel.fromCurrency.symbol+(Int(value.rounded())).description
            toCurrencyMessage = exchangeModel.toCurrency.symbol+(Int(result.rounded())).description
        }
        let message = NSLocalizedString("Are you to get \(toCurrencyMessage) for \(fromCurrencyMessage) ? Do you approve the transaction?", comment: "")
        UIAlertController.confirmkWithMessage(title: title, message: message, router: router) { action in
            self.dismiss(animated: true, completion: {
                self.start(.success(model: exchangeModel), animated: true, onDismissed: nil)
            })
        }
    }
}

extension ExchangeCoordinator: CurrencySelectionViewModelCoordinationDelegate {
    func closeScreen() {
        self.dismiss(animated: true)
    }
}

extension ExchangeCoordinator: SuccessViewModelCoordinationDelegate {
    func backToHome() {
        self.dismiss(animated: true)
    }
}

