//
//  NetworkManager.swift
//  exchangeApp
//
//  Created by Beyza Paksin on 10.02.2022.
//

import Foundation

class NetWorkManager {
    static let shared = NetWorkManager()

    private init() {}

    func accessRouter<T: NetworkRequestProtocol>(endpointType: T.Type) -> NetworkRouter<T> {
        let router = NetworkRouter<T>()
        return router
    }
}
