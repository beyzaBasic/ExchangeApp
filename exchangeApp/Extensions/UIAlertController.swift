//
//  UIAlertController.swift
//  exchangeApp
//
//  Created by Beyza Paksin on 12.02.2022.
//

import UIKit


typealias AlertAction = (UIAlertAction) -> Void
typealias Completion = () -> Void

extension UIAlertController {
    class func confirmkWithMessage (title : String?, message : String, router : Router?,  handler : AlertAction? = nil, completion : Completion? = nil )  {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addOkButton( handler: handler)
            alert.addCancelButton()
            router?.present(alert, animated: true)
    }

    class func cancelWithMessage (message : String, router : Router?, completion : Completion? = nil )  {
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            alert.addCancelButton()
            router?.present(alert, animated: true)
    }

    private func addOkButton (handler:AlertAction? = nil) {
        let defaultString = NSLocalizedString("Confirm", comment: "Ok Button")
        let action = UIAlertAction(title: defaultString, style: .default, handler: handler)
        addAction(action)
    }

    private func addCancelButton () {
        let cancelString = NSLocalizedString("Cancel", comment: "Cancel Button")
        let action = UIAlertAction(title: cancelString, style: .cancel, handler: nil)
        addAction(action)
    }
}
