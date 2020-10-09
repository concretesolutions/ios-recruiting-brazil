//
//  HTTPClientProtocol.swift
//  Movs
//
//  Created by Joao Lucas on 08/10/20.
//

import Foundation

protocol HTTPClientProtocol {

    func request<T: Decodable>(_ request: URLRequest, decode: ((T) -> T)?, completion: @escaping (Result<T, HTTPError>) -> Void)

    func cancelAllRequests()
}

extension HTTPClientProtocol {

    func request<T: Decodable>(_ request: URLRequest, decode: ((T) -> T)? = nil, completion: @escaping (Result<T, HTTPError>) -> Void) {
        self.request(request, decode: decode, completion: completion)
    }
}
