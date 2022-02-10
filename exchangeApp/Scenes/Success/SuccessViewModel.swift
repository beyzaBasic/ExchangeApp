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
}

protocol SuccessViewModelCoordinationDelegate: AnyObject {
    func backToHome()
}

// MARK: - Class Bone
class SuccessViewModel: SuccessViewModelProtocol {
    // MARK: Properties
    weak var viewModelCoordinationDelegate: SuccessViewModelCoordinationDelegate?

    func backToHomeTapped() {
        self.viewModelCoordinationDelegate?.backToHome()
    }

}
