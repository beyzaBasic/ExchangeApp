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
    private var exchangeModel: ExchangeModel?

    func start(_ actionType: ExchangeActionType?, animated: Bool, onDismissed: (() -> Void)?) {
        switch actionType {
        case .selection( let exchangeModel):
            let viewModel = CurrencySelectionViewModel(exchangeModel: exchangeModel)
            viewModel.viewModelCoordinationDelegate = self
            let viewController = CurrencySelectionViewController(viewModel: viewModel)
            viewController.view.backgroundColor = .gray
            self.router.present(viewController, animated: true)
        case .confirmation:
            //            let viewModel = ConfirmationViewModel()
            //            viewModel.viewModelCoordinationDelegate = self
            //            let viewController = ConfirmationViewController(viewModel: viewModel)
            //            viewController.view.backgroundColor = .cyan
            //            self.router.present(viewController, animated: true)
            self.presentConfirmationAlert()
        case .success:
            let viewModel = SuccessViewModel(exchangeModel: exchangeModel)
            viewModel.viewModelCoordinationDelegate = self
            let viewController = SuccessViewController(viewModel: viewModel)
            self.router.present(viewController, animated: true)
        case .none:
            break
        }
    }

    required init(router: Router) {
        self.router = router
    }

    private func presentConfirmationAlert() {
        let title = NSLocalizedString("Confirm Operation", comment: "")
        var fromCurrencyMessage = ""
        var toCurrencyMessage = ""
        if let exchangeModel = self.exchangeModel, let value = exchangeModel.value {
            fromCurrencyMessage = exchangeModel.fromCurrency.symbol+(Int(value)).description
            toCurrencyMessage = exchangeModel.toCurrency.symbol+(Int(value)).description
        }
        let message = NSLocalizedString("Are you to get \(toCurrencyMessage) for \(fromCurrencyMessage) ? Do you approve the transaction?", comment: "")
        UIAlertController.confirmkWithMessage(title: title, message: message, router: router) { action in
            self.dismiss(animated: true, completion: {
                self.start(.success, animated: true, onDismissed: nil)
            })
        }
    }
}

extension ExchangeCoordinator: CurrencySelectionViewModelCoordinationDelegate {
    func currencySelected(exchangeModel: ExchangeModel) {
        self.dismiss(animated: true)
    }
}

//extension ExchangeCoordinator: ConfirmationViewModelCoordinationDelegate {
//    func cancel() {
//        self.dismiss(animated: true)
//    }
//    func confirm() {
//
//    }
//}

extension ExchangeCoordinator: SuccessViewModelCoordinationDelegate {
    func backToHome() {
        self.dismiss(animated: true)
    }
}

