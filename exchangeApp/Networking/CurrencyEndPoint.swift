//
//  CurrencyEndPoint.swift
//  exchangeApp
//
//  Created by Beyza Paksin on 10.02.2022.
//

import Foundation
enum CurrencyEndpoint {
    case rateConversion(currency: String)
}

extension CurrencyEndpoint: NetworkRequestProtocol {

    var task: HTTPTask {
        return .request
    }

    var baseURL: URL? {
        switch self {
        case .rateConversion:
            return URL(string: ExchangeServerUrl.rate)
        }
    }

    var path: String {
        switch self {
        case .rateConversion(let currency):
            return ExchangeServerPath.latest + "/" + currency
        }
    }

    var header: HTTPHeader? {
        var header = HTTPHeader()
        header.updateValue("application/json", forKey: "Content-Type")
        return header
    }

    var method: HTTPMethods {
        return .get
    }
}
