//
//  CurrencyResult.swift
//  exchangeApp
//
//  Created by Beyza Paksin on 10.02.2022.
//

import Foundation
import RealmSwift

@objcMembers
class RateResponse: Object, Codable {
    dynamic var id: Int = 333
    dynamic var result: String = ""
    dynamic var documentation: String = ""
    dynamic var termsOfUse: String = ""
    dynamic var timeLastUpdateUnix: Int = -1
    dynamic var timeLastUpdateUtc: String = ""
    dynamic var timeNextUpdateUnix: Int = -1
    dynamic var timeNextUpdateUtc: String = ""
    dynamic var baseCode: String = ""
    dynamic var conversionRates: RateModel?
    dynamic var timeStamp: Date = .init()

    enum CodingKeys: String, CodingKey {
        case result
        case documentation
        case termsOfUse = "terms_of_use"
        case timeLastUpdateUnix = "time_last_update_unix"
        case timeLastUpdateUtc = "time_last_update_utc"
        case timeNextUpdateUnix = "time_next_update_unix"
        case timeNextUpdateUtc = "time_next_update_utc"
        case baseCode = "base_code"
        case conversionRates = "conversion_rates"
    }
    override class func primaryKey() -> String? {
        return "id"
    }
   
}


