//
//  Codable+Helpers.swift
//  NetworkLayer
//
//  Created by Marcos Santos on 20/12/19.
//  Copyright © 2019 Marcos Santos. All rights reserved.
//

import Foundation

extension Encodable {
    func encoded() throws -> Data {
        return try JSONEncoder().encode(self)
    }
}

extension Data {
    func decoded<T: Decodable>() throws -> T {
        return try JSONDecoder().decode(T.self, from: self)
    }
}
