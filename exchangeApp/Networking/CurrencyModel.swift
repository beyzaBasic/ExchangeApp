//
//  CurrencyModel.swift
//  exchangeApp
//
//  Created by Beyza Paksin on 10.02.2022.
//

import Foundation
import Realm

@objcMembers
class CurrencyModel: Codable {

    dynamic var usd: Double = -1
    dynamic var trl: Double = -1
    dynamic var eur: Double = -1
    dynamic var rub: Double = -1
    dynamic var gel: Double = -1
    dynamic var ggp: Double = -1

    enum CodingKeys: String, CodingKey {
        case usd = "USD"
        case trl = "TRY"
        case eur = "EUR"
        case rub = "RUB"
        case gel = "GEL"
        case ggp = "GGP"
    }
}
