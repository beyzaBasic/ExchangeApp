//
//  HomeViewModel.swift
//  exchangeApp
//
//  Created by Beyza Paksin on 10.02.2022.
//

import UIKit

protocol HomeViewModelProtocol: AnyObject {
    func confirmationTriggered(_ viewController: HomeViewController)
    func selectCurrency(exchangeModel: ExchangeModel, _ viewController: HomeViewController)
     var viewModelCoordinationDelegate: HomeViewModelCoordinationDelegate? {get set}
     var exchangeModel: ExchangeModel { get set }
}

protocol HomeViewModelCoordinationDelegate: AnyObject {
    func presentConfirmationScreen(_ viewController: HomeViewController)
    func presentCurrencySelectionScreen(_ viewController: HomeViewController, exchangeModel: ExchangeModel)
}

protocol HomeViewModelViewDelegate: AnyObject {

}

class ExchangeModel {
    var selectionState: SelectionState?
    var fromCurrency: Currency = .eur
    var toCurrency: Currency = .usd
    var value: Double?

    init() {
    }

    init(fromCurrency: Currency, toCurrency: Currency, exchangeState: SelectionState? = nil) {
        self.selectionState = exchangeState
        self.fromCurrency = fromCurrency
        self.toCurrency = toCurrency
    }
}

enum SelectionState {
    case fromCurrency
    case toCurrency
}

enum ExchangeActionType {
    case selection (model: ExchangeModel)
    case confirmation
    case success
}

// MARK: - Class Bone
class HomeViewModel: HomeViewModelProtocol {
    // MARK: Attributes
    weak var viewModelCoordinationDelegate: HomeViewModelCoordinationDelegate?
    var exchangeModel: ExchangeModel = .init()

    func confirmationTriggered(_ viewController: HomeViewController) {
        self.viewModelCoordinationDelegate?.presentConfirmationScreen(viewController)
    }

    func selectCurrency(exchangeModel: ExchangeModel, _ viewController: HomeViewController) {

//        NetWorkManager.shared.accessRouter(endpointType: CurrencyEndpoint.self).request(.rateConversion(currency: "USD"), decoded: RateResponse.self) { response in
//            if DBManager.shared.getCurrencyResponse() == nil {
//            DBManager.shared.addCurrencyResponse(model: response) { _ in
//                print(DBManager.shared.getCurrencyResponse()?.baseCode)
//                print(DBManager.shared.getCurrencyResponse()?.id)
//                print(DBManager.shared.getCurrencyResponse()?.conversionRates?.trl)
//                print(DBManager.shared.getCurrencyResponse()?.timeLastUpdateUtc)
//            }
//            } else {
//                DBManager.shared.updateCurrencyResponse(model: response) { _ in
//                    print(DBManager.shared.getCurrencyResponse()?.baseCode)
//                    print(DBManager.shared.getCurrencyResponse()?.id)
//                    print(DBManager.shared.getCurrencyResponse()?.conversionRates?.trl)
//                    print(DBManager.shared.getCurrencyResponse()?.timeLastUpdateUtc)
//                    print(DBManager.shared.getCurrencyResponse()?.timeNextUpdateUtc)
//                }
//            }
//        } onFailure: { error in
//            print(error.description)
//        }
        self.viewModelCoordinationDelegate?.presentCurrencySelectionScreen(viewController, exchangeModel: exchangeModel)
    }
}
