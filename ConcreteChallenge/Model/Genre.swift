//
//  Genre.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 07/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import Foundation

struct Genre: Codable {
    let id: Int
    let name: String
}

extension Genre {

    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}
