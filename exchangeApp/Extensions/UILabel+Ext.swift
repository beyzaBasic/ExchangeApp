//
//  UILabel+Ext.swift
//  exchangeApp
//
//  Created by Beyza Paksin on 13.02.2022.
//

import UIKit

struct TextAttributeModel {
    var text: String
    var attributes: [NSAttributedString.Key: Any]

    init(text:String? = nil) {
        self.text = text ?? ""
        self.attributes = [:]
    }
    init(text: String? = nil, attributes: [NSAttributedString.Key : Any]? = nil) {
        self.text = text ?? ""
        self.attributes = attributes ?? [:]
    }
}

extension UILabel {
    func setAttributedText(texts: [TextAttributeModel]) {
       let mutableText = NSMutableAttributedString()
        for txt in texts {
            let temp = NSAttributedString(string: txt.text, attributes: txt.attributes)
            mutableText.append(temp)
        }
        self.attributedText = mutableText.attributedSubstring(from: .init(0..<mutableText.length))
    }
}
