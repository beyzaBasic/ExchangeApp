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

enum Currency {
    case usd
    case trl
    case eur
    case rub
    case gel
    case ggp
    case kyd

    var rate: Double? {
        switch self {
        case .usd:
            return DBManager.shared.getCurrencyResponse()?.conversionRates?.usd
        case .trl:
            return DBManager.shared.getCurrencyResponse()?.conversionRates?.trl
        case .eur:
            return DBManager.shared.getCurrencyResponse()?.conversionRates?.eur
        case .rub:
            return DBManager.shared.getCurrencyResponse()?.conversionRates?.rub
        case .gel:
            return DBManager.shared.getCurrencyResponse()?.conversionRates?.gel
        case .ggp:
            return DBManager.shared.getCurrencyResponse()?.conversionRates?.ggp
        case .kyd:
            return DBManager.shared.getCurrencyResponse()?.conversionRates?.kyd
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
}
