//
//  CurrencyModel.swift
//  exchangeApp
//
//  Created by Beyza Paksin on 10.02.2022.
//

import Foundation
import RealmSwift

@objcMembers
class CurrencyModel: Object, Codable {
    dynamic var id: Int = 555
    dynamic var usd: Double = -1
    dynamic var trl: Double = -1
    dynamic var eur: Double = -1
    dynamic var rub: Double = -1
    dynamic var gel: Double = -1
    dynamic var ggp: Double = -1
    dynamic var kyd: Double = -1
    
    enum CodingKeys: String, CodingKey {
        case usd = "USD"
        case trl = "TRY"
        case eur = "EUR"
        case rub = "RUB"
        case gel = "GEL"
        case ggp = "GGP"
        case kyd = "KYD"
    }
    override class func primaryKey() -> String? {
        return "id"
    }
}

enum Currency {
    case usd
    case trl
    case eur
    case rub
    case gel
    case ggp
    case kyd
}
