//
//  NetworkProtocol.swift
//  exchangeApp
//
//  Created by Beyza Paksin on 10.02.2022.
//

import Foundation

protocol NetworkProtocol {

    associatedtype EndPoint: NetworkRequestProtocol

    func request<P:Codable>(_ route: EndPoint, decoded: P.Type, onSuccess: @escaping (P) -> Void, onFailure: @escaping (NetworkError) -> Void)
    func wait()
    func cancel()
}

class NetworkRouter<T: NetworkRequestProtocol> : NetworkProtocol {
    typealias EndPoint = T
    // MARK:  Properties
    var sessionTask: URLSessionTask?
    var timeout = TimeInterval(exactly: 25.0)!
    var decoder = JSONDecoder()
    var encoder = JSONEncoder()

    // MARK:  Protocol Methods
    public func request<P: Codable>(_ endPoint: T, decoded: P.Type, onSuccess: @escaping (P) -> Void, onFailure: @escaping (NetworkError) -> Void) {
        let session = URLSession.shared
        do {
            let urlReq = try self.buildRequest(endPoint: endPoint)
            sessionTask = session.dataTask(with: urlReq, completionHandler: { (data, response, error) in
                if error != nil {
                    DispatchQueue.main.async {
                        onFailure(NetworkError.connectionFailed)
                    }
                }
                if let httpResponse = response as? HTTPURLResponse {

                    guard let responseData = data else {
                        DispatchQueue.main.async {
                            onFailure(NetworkError.noResponseData)
                        }
                        return
                    }
                    if  httpResponse.statusCode == 200 {
                        do {
                            let apiResponse = try self.decoder.decode(P.self, from: responseData)
                            DispatchQueue.main.async {
                                onSuccess(apiResponse)
                            }
                        } catch {
                            if let decodeError = error as? DecodingError {
                                DispatchQueue.main.async {
                                    onFailure(NetworkError.decodeError(error: decodeError))
                                }
                            } else {
                                DispatchQueue.main.async {
                                    onFailure(NetworkError.customError(message: error.localizedDescription))
                                }
                            }
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        onFailure(NetworkError.noResponseData)
                    }
                }
            })
        } catch {
            DispatchQueue.main.async {
                onFailure(NetworkError.customError(message: "Request decoding error"))
            }
        }
        sessionTask?.resume()
    }

    public func wait() {
        guard let task = sessionTask else {
            return
        }

        task.suspend()
    }

    public func cancel() {
        guard let task = sessionTask else {
            return
        }

        task.cancel()
    }
}
extension NetworkRouter {
    private func buildRequest(endPoint: EndPoint) throws -> URLRequest {
        guard let base = endPoint.baseURL else {
            throw NetworkError.missingURLError
        }

        let requestURL = base.appendingPathComponent(endPoint.path)
        var request = URLRequest(url: requestURL, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: timeout)

        request.httpMethod = endPoint.method.rawValue
        if let header = endPoint.header {
            for (k,v) in header {
                request.addValue(v, forHTTPHeaderField: k)
            }
        }
        // Only Plain request case of HTTP Task is implemented in this project.
        return request
    }
}
