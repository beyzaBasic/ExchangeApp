//
//  ConfirmationViewModel.swift
//  exchangeApp
//
//  Created by Beyza Paksin on 10.02.2022.
//

import Foundation

protocol ConfirmationViewModelProtocol: AnyObject  {
    var viewModelCoordinationDelegate: ConfirmationViewModelCoordinationDelegate? {get set}
    func cancelTapped()
    func confirmTapped()
}

protocol ConfirmationViewModelCoordinationDelegate: AnyObject{
    func cancel()
    func confirm()
}

// MARK: - Class Bone
class ConfirmationViewModel: ConfirmationViewModelProtocol {
    // MARK: Properties
    weak var viewModelCoordinationDelegate: ConfirmationViewModelCoordinationDelegate?

    func cancelTapped() {
        self.viewModelCoordinationDelegate?.cancel()
    }
    func confirmTapped() {
        self.viewModelCoordinationDelegate?.confirm()
    }
}
