//
//  Endpoint.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 17/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import Foundation
import Alamofire

typealias Parameters = [String: Any]

// MARK: Endpoint
final class Endpoint<Response> {
    let method: HTTPMethod
    let path: String
    let parameters: Parameters?
    let decode: (Data) throws -> Response

    init(method: HTTPMethod = .get,
         path: String,
         parameters: Parameters? = nil,
         decode: @escaping (Data) throws -> Response) {
        self.method = method
        self.path = path
        self.parameters = parameters
        self.decode = decode
    }

    var asDictionary: [String: Any] {
        return [
            "method": self.method.rawValue,
            "path": self.path,
            "parameters": self.parameters.debugDescription
        ]
    }
}

// MARK: Convenience
extension Endpoint where Response: Swift.Decodable {
    convenience init(method: HTTPMethod = .get,
                     path: String,
                     parameters: Parameters? = nil) {
        self.init(method: method, path: path, parameters: parameters) {
            try JSONDecoder().decode(Response.self, from: $0)
        }
    }
}

extension Endpoint where Response == Void {
    convenience init(method: HTTPMethod = .get,
                     path: String,
                     parameters: Parameters? = nil) {
        self.init(
            method: method,
            path: path,
            parameters: parameters,
            decode: { _ in () }
        )
    }
}
