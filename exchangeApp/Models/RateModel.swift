//
//  CurrencyModel.swift
//  exchangeApp
//
//  Created by Beyza Paksin on 10.02.2022.
//

import Foundation
import RealmSwift

@objcMembers
class RateModel: Object, Codable {
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

enum Currency: Equatable {
    case usd(model: RateModel?)
    case trl(model: RateModel?)
    case eur(model: RateModel?)
    case rub(model: RateModel?)
    case gel(model: RateModel?)
    case ggp(model: RateModel?)
    case kyd(model: RateModel?)

    var rate: Double {
        switch self {
        case .usd(let rate):
            return rate?.usd ?? 1
        case .trl(let rate):
            return rate?.trl ?? 1
        case .eur(let rate):
            return rate?.eur ?? 1
        case .rub(let rate):
            return rate?.rub ?? 1
        case .gel(let rate):
            return rate?.gel ?? 1
        case .ggp(let rate):
            return rate?.ggp ?? 1
        case .kyd(let rate):
            return rate?.kyd ?? 1
        }
    }

    var symbol: String {
        switch self {
        case .usd:
            return "$"
        case .trl:
            return "₺"
        case .eur:
            return "€"
        case .rub:
            return "₽"
        case .gel:
            return "ლ"
        case .ggp:
            return "£"
        case .kyd:
            return "$"
        }
    }

    var title: String {
        switch self {
        case .usd:
            return "USD"
        case .trl:
            return "TRY"
        case .eur:
            return "EUR"
        case .rub:
            return "RUB"
        case .gel:
            return "GEL"
        case .ggp:
            return "GGP"
        case .kyd:
            return "KYD"
        }
    }

    static func == (lhs: Currency, rhs: Currency) -> Bool {
        return lhs.title == rhs.title
    }
}
