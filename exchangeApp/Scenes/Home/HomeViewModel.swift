//
//  HomeViewModel.swift
//  exchangeApp
//
//  Created by Beyza Paksin on 10.02.2022.
//

import UIKit

protocol HomeViewModelProtocol: AnyObject {
    func confirmationTriggered(exchangeModel: ExchangeModel,_ viewController: HomeViewController)
    func toggleFromToCurrencies()
    func updateExchangeValue(value: Double?)
    func updateSelectionState(selectionState: SelectionState, _ viewController: HomeViewController)
    func getRatesFromCloudIfNeeded(onSuccess: @escaping (RateModel?) -> Void, onFailure: @escaping (NetworkError?) -> Void)
    func setExchangeModelResultWithRateCalculation()
    var viewModelCoordinationDelegate: HomeViewModelCoordinationDelegate? {get set}
    var exchangeModel: ExchangeModel { get set}
}

protocol HomeViewModelCoordinationDelegate: AnyObject {
    func presentConfirmationScreen(_ viewController: HomeViewController, exchangeModel: ExchangeModel)
    func presentCurrencySelectionScreen(_ viewController: HomeViewController, exchangeModel: ExchangeModel)
}

protocol HomeViewModelViewDelegate: AnyObject {

}

class ExchangeModel {
    var selectionState: SelectionState?
    var fromCurrency: Currency
    var toCurrency: Currency
    var value: Double?
    var result: Double?

    init(fromCurrency: Currency, toCurrency: Currency) {
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
    case confirmation (model: ExchangeModel)
    case success (model: ExchangeModel)
}

// MARK: - Class Bone
class HomeViewModel: HomeViewModelProtocol {
    // MARK: Attributes
    weak var viewModelCoordinationDelegate: HomeViewModelCoordinationDelegate?
    var exchangeModel: ExchangeModel = .init(fromCurrency: .eur(model: RateModel()),
                                             toCurrency: .usd(model: RateModel()))

    func toggleFromToCurrencies() {
        let  tempFromVal = self.exchangeModel.fromCurrency
        self.exchangeModel.fromCurrency = self.exchangeModel.toCurrency
        self.exchangeModel.toCurrency = tempFromVal
    }

    func confirmationTriggered(exchangeModel: ExchangeModel,_ viewController: HomeViewController) {
        self.viewModelCoordinationDelegate?.presentConfirmationScreen(viewController, exchangeModel: exchangeModel)
    }

    func updateExchangeValue(value: Double?) {
        self.exchangeModel.value = value
    }

    func updateSelectionState(selectionState: SelectionState, _ viewController: HomeViewController) {
        self.exchangeModel.selectionState = selectionState

        self.viewModelCoordinationDelegate?.presentCurrencySelectionScreen(viewController, exchangeModel: exchangeModel)
    }

    func getRatesFromCloudIfNeeded(onSuccess: @escaping (RateModel?) -> Void, onFailure: @escaping (NetworkError?) -> Void) {
        NetWorkManager.shared.accessRouter(endpointType: CurrencyEndpoint.self).request(.rateConversion(currency: "USD"), decoded: RateResponse.self) { response in
            if DBManager.shared.getCurrencyResponse() == nil {
                DBManager.shared.addCurrencyResponse(model: response) { _ in
                    self.updateFromToCurrenciesWithRateData(rateModel: response.conversionRates)
                    onSuccess(response.conversionRates)
                }
            } else {
                DBManager.shared.updateCurrencyResponse(model: response) { _ in
                    self.updateFromToCurrenciesWithRateData(rateModel: response.conversionRates)
                    onSuccess(response.conversionRates)
                }
            }
        } onFailure: { error in
            onFailure(error)
        }
    }

    func getRatesFromDB() -> RateModel? {
        return DBManager.shared.getCurrencyResponse()?.conversionRates
    }

    func setExchangeModelResultWithRateCalculation() {
        guard let value = self.exchangeModel.value else { return }

        self.exchangeModel.result = (value / self.exchangeModel.fromCurrency.rate) *  self.exchangeModel.toCurrency.rate
    }

    private func updateCurrencyWithRateData(currency: Currency, rateModel: RateModel?) -> Currency {
        guard let rateModel = rateModel else {
            return currency }

        switch currency {
        case .usd:
            return .usd(model: rateModel)
        case .trl:
            return .trl(model: rateModel)
        case .eur:
            return .eur(model: rateModel)
        case .rub:
            return .rub(model: rateModel)
        case .gel:
            return .gel(model: rateModel)
        case .ggp:
            return .ggp(model: rateModel)
        case .kyd:
            return.kyd(model: rateModel)
        }
    }

    private func updateFromToCurrenciesWithRateData(rateModel: RateModel?) {
        self.exchangeModel.fromCurrency = self.updateCurrencyWithRateData(currency: self.exchangeModel.fromCurrency, rateModel: rateModel)

        self.exchangeModel.toCurrency = self.updateCurrencyWithRateData(currency: self.exchangeModel.toCurrency, rateModel: rateModel)
    }
}
