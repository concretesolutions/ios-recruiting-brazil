//
//  Encodable+Encoded.swift
//  ConcreteChallenge
//
//  Created by Matheus Oliveira Costa on 14/12/19.
//  Copyright © 2019 mathocosta. All rights reserved.
//

import Foundation

extension Encodable {
    func encoded() -> Data? {
        let encoder = JSONEncoder()
        let data = try? encoder.encode(self)

        return data
    }
}
