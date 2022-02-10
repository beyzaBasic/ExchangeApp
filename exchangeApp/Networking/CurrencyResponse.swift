//
//  CurrencyResult.swift
//  exchangeApp
//
//  Created by Beyza Paksin on 10.02.2022.
//

import Foundation

class CurrencyResponse: Codable {

    var result: String
    var documentation: String
    var termsOfUse: String
    var timeLastUpdateUnix: Double
    var timeLastUpdateUtc: String
    var timeNextUpdateUnix: Double
    var timeNextUpdateUtc: String
    var baseCode: String
    var conversionRates: CurrencyModel

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
}
