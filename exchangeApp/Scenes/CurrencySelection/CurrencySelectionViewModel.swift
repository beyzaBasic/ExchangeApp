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
    func screenClosed(index: Int)
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
    var rateModel: RateModel

    init (exchangeModel: ExchangeModel) {
        print(exchangeModel.fromCurrency)
        print(exchangeModel.toCurrency)
        self.exchangeModel = exchangeModel
        self.rateModel = DBManager.shared.getCurrencyResponse()?.conversionRates ?? RateModel()
        let tempList: [Currency] = [.usd(model: self.rateModel),
                       .eur(model: self.rateModel),
                       .trl(model: self.rateModel),
                       .rub(model: self.rateModel),
                       .gel(model: self.rateModel),
                       .ggp(model: self.rateModel),
                       .kyd(model: self.rateModel)]
        switch self.exchangeModel.selectionState {
        case .toCurrency:
            self.currencyList = tempList.filter{$0.title != exchangeModel.fromCurrency.title && $0.title != exchangeModel.toCurrency.title }
        case .fromCurrency:
            self.currencyList = tempList.filter{$0.title != exchangeModel.fromCurrency.title && $0.title != exchangeModel.toCurrency.title }
        case .none:
            self.currencyList = tempList
        }
    }

    private func updateExchangeModel(index: Int) {
        let currency = self.currencyList[index]
        switch self.exchangeModel.selectionState {
        case .fromCurrency:
            self.exchangeModel.fromCurrency = currency
        case .toCurrency:
            self.exchangeModel.toCurrency = currency
        case .none:
            break
        }
    }

    func screenClosed(index: Int) {
        self.updateExchangeModel(index: index)
        self.viewModelViewDelegate?.currencySelected(exchangeModel: self.exchangeModel)
        self.viewModelCoordinationDelegate?.closeScreen()
    }
}
