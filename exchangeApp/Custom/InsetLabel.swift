//
//  PaddingLabel.swift
//  exchangeApp
//
//  Created by Beyza Paksin on 13.02.2022.
//

import UIKit
class InsetLabel: UILabel {

    override func drawText(in rect: CGRect) {
        let inset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        super.drawText(in: rect.inset(by: inset))
    }

}
