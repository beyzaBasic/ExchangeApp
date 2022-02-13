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
    func getCurrencyRates(onSuccess: @escaping (RateModel?) -> Void, onFailure: @escaping (NetworkError?) -> Void)
    func setExchangeModelResultWithRateCalculation()
    func updateFromToCurrenciesWithRateData()
    func resetFromToCurrenciesWithRateData() 
    var viewModelCoordinationDelegate: HomeViewModelCoordinationDelegate? {get set}
    var exchangeModel: ExchangeModel { get set}
    var rateModel: RateModel? { get set}
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
    var rateModel:  RateModel?

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

    private func getRatesFromCloud(onSuccess: @escaping (RateModel?) -> Void, onFailure: @escaping (NetworkError?) -> Void) {
        NetWorkManager.shared.accessRouter(endpointType: CurrencyEndpoint.self).request(.rateConversion(currency: "USD"), decoded: RateResponse.self) { response in
            if DBManager.shared.getCurrencyResponse() == nil {
                DBManager.shared.addCurrencyResponse(model: response) { _ in
                    self.rateModel = response.conversionRates
                    self.updateFromToCurrenciesWithRateData()
                    onSuccess(self.rateModel)
                }
            } else {
                DBManager.shared.updateCurrencyResponse(model: response) { _ in
                    self.rateModel = response.conversionRates
                    self.updateFromToCurrenciesWithRateData()
                    onSuccess(self.rateModel)
                }
            }
        } onFailure: { error in
            onFailure(error)
        }
    }

    func getCurrencyRates(onSuccess: @escaping (RateModel?) -> Void, onFailure: @escaping (NetworkError?) -> Void) {
        var condition = false

        if DBManager.shared.getCurrencyResponse()?.timeStamp == nil {
            condition = true
        } else if let previousResponseModelDate = DBManager.shared.getCurrencyResponse()?.timeStamp,
           let nextAvailableDate = Calendar.current.date(byAdding: .hour, value: 24, to: previousResponseModelDate) {
                let currentDate = Date()
            condition = currentDate.timeIntervalSinceReferenceDate >= nextAvailableDate.timeIntervalSinceReferenceDate
        }

        if condition {
            self.getRatesFromCloud { rateModel in
              onSuccess(rateModel)
            } onFailure: { networkError in
              onFailure(networkError)
            }
        } else {
            self.rateModel = DBManager.shared.getCurrencyResponse()?.conversionRates
            self.updateFromToCurrenciesWithRateData()
            onSuccess(self.rateModel)
        }
    }

    func getRatesFromDB() -> RateModel? {
        return DBManager.shared.getCurrencyResponse()?.conversionRates
    }

    func setExchangeModelResultWithRateCalculation() {
        guard let value = self.exchangeModel.value else { return }
        self.exchangeModel.result = (value / self.exchangeModel.fromCurrency.rate) *  self.exchangeModel.toCurrency.rate
    }

    func updateCurrencyWithRateData(currency: Currency) -> Currency {
        guard let rateModel = self.rateModel else {
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

    func updateFromToCurrenciesWithRateData() {
        self.exchangeModel.fromCurrency = self.updateCurrencyWithRateData(currency: self.exchangeModel.fromCurrency)
        self.exchangeModel.toCurrency = self.updateCurrencyWithRateData(currency: self.exchangeModel.toCurrency)
    }

    func resetFromToCurrenciesWithRateData() {
        self.exchangeModel.fromCurrency = self.updateCurrencyWithRateData(currency: .usd(model: self.rateModel))
        self.exchangeModel.toCurrency = self.updateCurrencyWithRateData(currency: .eur(model: self.rateModel))
    }
}
