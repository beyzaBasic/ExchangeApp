//
//  CurrencySelectionViewModel.swift
//  exchangeApp
//
//  Created by Beyza Paksin on 10.02.2022.
//

import Foundation

protocol CurrencySelectionViewModelProtocol: AnyObject  {
    var viewModelCoordinationDelegate: CurrencySelectionViewModelCoordinationDelegate? {get set}
    func closeTapped(exchangeState: ExchangeState, selectedCurrency: String)
}

protocol CurrencySelectionViewModelCoordinationDelegate: AnyObject {
    func currencySelected(exchangeState: ExchangeState, selectedCurrency: String)

}

// MARK: - Class Bone
class CurrencySelectionViewModel: CurrencySelectionViewModelProtocol {
    // MARK: Properties
    weak var viewModelCoordinationDelegate: CurrencySelectionViewModelCoordinationDelegate?

    func closeTapped(exchangeState: ExchangeState, selectedCurrency: String) {
        self.viewModelCoordinationDelegate?.currencySelected(exchangeState: exchangeState, selectedCurrency: selectedCurrency)
    }

}
