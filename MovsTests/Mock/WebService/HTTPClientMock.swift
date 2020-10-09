//
//  HTTPClientMock.swift
//  MovsTests
//
//  Created by Joao Lucas on 08/10/20.
//

import Foundation
@testable import Movs

class HTTPClientMock: HTTPClientProtocol {

    var fileName = String()
    var failure: Bool = false
    var isCancelled = false

    func request<T>(_ request: URLRequest, decode: ((T) -> T)?, completion: @escaping (Result<T, HTTPError>) -> Void) where T: Decodable {

        guard !failure else {
            return completion(.failure(.jsonParsingFailure))
        }

        let decodable: T = JSONHelper.load(withFile: fileName)!
        if let value = decode?(decodable) {
            return completion(.success(value))
        }
        return completion(.success(decodable))
    }

    func cancelAllRequests() {
        self.isCancelled = true
    }
}
