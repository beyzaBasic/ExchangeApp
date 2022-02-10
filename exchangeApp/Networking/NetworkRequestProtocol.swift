//
//  NetworkRequest.swift
//  exchangeApp
//
//  Created by Beyza Paksin on 10.02.2022.
//

import Foundation

protocol NetworkRequestProtocol {

    var task: HTTPTask { get }
    var baseURL: URL? { get }
    var path: String { get }
    var header: HTTPHeader? { get }
    var method: HTTPMethods { get }
}
