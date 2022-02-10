//
//  NetworkConstants.swift
//  exchangeApp
//
//  Created by Beyza Paksin on 10.02.2022.
//

import Foundation

typealias Parameters = [String: Any]
typealias HTTPHeader = [String: String]

// MARK: - HTTP Methods
enum HTTPMethods: String {
    // other methods are not implemented in this project
    case get    = "GET"

}

// MARK: - HTTP Task
enum HTTPTask {
    // other cases are not implemented in this project
    case request
}

// MARK: - Server URL
enum ExchangeServerUrl {
    static let rate = "https://v6.exchangerate-api.com"
}

enum ExchangeServerPath {
    static let latest = "v6/9c11924b3c90c89cbaba1593/latest"
}
// MARK: - HTTP Header Keys
enum HTTPHeaderKeys {
    case contentType
    case authorization
}

// MARK: - HTTP Header Key
extension HTTPHeaderKeys {

    var key: String {
        switch self {
        case .contentType:
            return "Content-Type"
        case .authorization:
            return "Authorization"
        }
    }
}

// MARK: - Error Types
enum NetworkError: Error {

    case environmentError
    case missingParametersError
    case codingError
    case missingURLError
    case connectionFailed
    case noResponseData
    case decodeError(error: DecodingError)
    case customError(message: String)
}

// MARK: - Error messages
extension NetworkError {

    /// User-friendly description of the errors
    public var description: String {
        switch self {
        case .environmentError:
            return "Environment error"
        case .missingParametersError:
            return "Some of the required parameters are not given"
        case .codingError:
            return "Data converting error"
        case .missingURLError:
            return "Could not access to the given URL"
        case .connectionFailed:
            return "Check your Network Connection"
        case .noResponseData:
            return "Response does not contain any data"
        case .decodeError(let error):
            return error.errorDescription ?? "Decoding error"
        case .customError( let message):
            return message
        }
    }
}
