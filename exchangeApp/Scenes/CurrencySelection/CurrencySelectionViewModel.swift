//
//  CurrencySelectionViewModel.swift
//  exchangeApp
//
//  Created by Beyza Paksin on 10.02.2022.
//

import Foundation

protocol CurrencySelectionViewModelProtocol: AnyObject  {
    var viewModelCoordinationDelegate: CurrencySelectionViewModelCoordinationDelegate? { get set }
    var exchangeModel: ExchangeModel { get set }
    var currencyList: [Currency] { get set }
    func closeTapped(exchangeModel: ExchangeModel)

}

protocol CurrencySelectionViewModelCoordinationDelegate: AnyObject {
    func currencySelected(exchangeModel: ExchangeModel)

}

// MARK: - Class Bone
class CurrencySelectionViewModel: CurrencySelectionViewModelProtocol {
    // MARK: Attributes
    weak var viewModelCoordinationDelegate: CurrencySelectionViewModelCoordinationDelegate?
    var exchangeModel: ExchangeModel
    var currencyList: [Currency] = [.usd, .eur, .trl, .rub, .gel, .ggp, .kyd]

    init (exchangeModel: ExchangeModel) {
        self.exchangeModel = exchangeModel
        switch self.exchangeModel.selectionState {
        case .toCurrency:
            self.currencyList = self.currencyList.filter{$0 != exchangeModel.fromCurrency}
        default: break
        }
    }

    func closeTapped(exchangeModel: ExchangeModel) {
        self.viewModelCoordinationDelegate?.currencySelected(exchangeModel: exchangeModel)
    }

}
