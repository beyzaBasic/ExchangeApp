//
//  HomeViewModel.swift
//  exchangeApp
//
//  Created by Beyza Paksin on 10.02.2022.
//

import UIKit

protocol HomeViewModelProtocol: AnyObject {
    func confirmationTriggered(_ viewController: HomeViewController)
    func selectCurrency(exchangeState: ExchangeState, _ viewController: HomeViewController)
     var viewModelCoordinationDelegate: HomeViewModelCoordinationDelegate? {get set}
}

protocol HomeViewModelCoordinationDelegate: AnyObject {
    func presentConfirmationScreen(_ viewController: HomeViewController)
    func presentCurrencySelectionScreen(_ viewController: HomeViewController)
}

protocol HomeViewModelViewDelegate: AnyObject {

}

enum ExchangeState {
    case fromCurrency
    case toCurrency
}

enum ExchangeActionType {
    case selection
    case confirmation
    case success
}

// MARK: - Class Bone
class HomeViewModel: HomeViewModelProtocol {
    // MARK: Properties
    weak var viewModelCoordinationDelegate: HomeViewModelCoordinationDelegate?

    func confirmationTriggered(_ viewController: HomeViewController) {
        self.viewModelCoordinationDelegate?.presentConfirmationScreen(viewController)
    }
    func selectCurrency(exchangeState: ExchangeState, _ viewController: HomeViewController) {

        NetWorkManager.shared.accessRouter(endpointType: CurrencyEndpoint.self).request(.rateConversion(currency: "USD"), decoded: CurrencyResponse.self) { response in
            print(response.baseCode)
            print(response.conversionRates.eur)
        } onFailure: { error in
            print(error.description)
        }


        self.viewModelCoordinationDelegate?.presentCurrencySelectionScreen(viewController)
    }
}
