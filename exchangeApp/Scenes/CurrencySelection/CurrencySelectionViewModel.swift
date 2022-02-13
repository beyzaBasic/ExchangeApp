//
//  CurrencySelectionViewModel.swift
//  exchangeApp
//
//  Created by Beyza Paksin on 10.02.2022.
//

import Foundation

protocol CurrencySelectionViewModelProtocol: AnyObject  {
    var viewModelCoordinationDelegate: CurrencySelectionViewModelCoordinationDelegate? { get set }
    var viewModelViewDelegate: CurrencySelectionViewModelViewDelegate? { get set }
    var exchangeModel: ExchangeModel { get set }
    var currencyList: [Currency] { get set }
    func screenClosed()
    func selectedCondition(currency: Currency) -> Bool
    func updateExchangeModelWithSelectedCurrency(currency: Currency)
}

protocol CurrencySelectionViewModelCoordinationDelegate: AnyObject {
    func closeScreen()

}

protocol CurrencySelectionViewModelViewDelegate: AnyObject {
    func currencySelected(exchangeModel: ExchangeModel)

}

// MARK: - Class Bone
class CurrencySelectionViewModel: CurrencySelectionViewModelProtocol {
    // MARK: Attributes
    weak var viewModelCoordinationDelegate: CurrencySelectionViewModelCoordinationDelegate?
    weak var viewModelViewDelegate: CurrencySelectionViewModelViewDelegate?
    var exchangeModel: ExchangeModel
    var currencyList: [Currency]

    init (exchangeModel: ExchangeModel) {
        self.exchangeModel = exchangeModel
        let tempList: [Currency] = [.usd(model: RateModel()),
                       .eur(model: nil),
                       .trl(model: nil),
                       .rub(model: nil),
                       .gel(model: nil),
                       .ggp(model: nil),
                       .kyd(model: nil)]
        switch self.exchangeModel.selectionState {
        case .toCurrency:
            self.currencyList = tempList.filter{$0 != exchangeModel.fromCurrency }
        case .fromCurrency:
            self.currencyList = tempList.filter{$0 != exchangeModel.toCurrency }
        case .none:
            self.currencyList = tempList
        }
    }

    func updateExchangeModelWithSelectedCurrency(currency: Currency) {
        switch self.exchangeModel.selectionState {
        case .fromCurrency:
            self.exchangeModel.fromCurrency = currency
        case .toCurrency:
            self.exchangeModel.toCurrency = currency
        case .none:
            break
        }
    }

    func screenClosed() {
        self.viewModelViewDelegate?.currencySelected(exchangeModel: self.exchangeModel)
        self.viewModelCoordinationDelegate?.closeScreen()
    }

    func selectedCondition(currency: Currency) -> Bool {
        switch self.exchangeModel.selectionState {
        case .fromCurrency:
            return currency == self.exchangeModel.fromCurrency
        case .toCurrency:
            return currency == self.exchangeModel.toCurrency
        case .none:
            return false
        }
    }
}


