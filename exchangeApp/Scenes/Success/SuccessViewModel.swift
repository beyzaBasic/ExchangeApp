//
//  SuccessViewModel.swift
//  exchangeApp
//
//  Created by Beyza Paksin on 10.02.2022.
//

import UIKit

protocol SuccessViewModelProtocol: AnyObject   {
    var viewModelCoordinationDelegate: SuccessViewModelCoordinationDelegate? {get set}
    func backToHomeTapped()
    var exchangeModel: ExchangeModel? {get set}
}

protocol SuccessViewModelCoordinationDelegate: AnyObject {
    func backToHome()
}

protocol SuccessViewModelViewDelegate: AnyObject {
    func resetUI()
}
// MARK: - Class Bone
class SuccessViewModel: SuccessViewModelProtocol {
    // MARK: Attributes
    weak var viewModelCoordinationDelegate: SuccessViewModelCoordinationDelegate?
    weak var viewModelViewDelegate: SuccessViewModelViewDelegate?
    var exchangeModel: ExchangeModel?

    init(exchangeModel: ExchangeModel?) {
        self.exchangeModel = exchangeModel
    }
    func backToHomeTapped() {
        self.viewModelViewDelegate?.resetUI()
        self.viewModelCoordinationDelegate?.backToHome()
    }
}
