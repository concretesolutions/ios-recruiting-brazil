//
//  Genre.swift
//  ConcreteChallenge
//
//  Created by Matheus Oliveira Costa on 16/12/19.
//  Copyright © 2019 mathocosta. All rights reserved.
//

import Foundation

struct GenreListRoot: Decodable {
    var genres: [Genre]
}

struct Genre: Decodable {
    var id: Int
    var name: String
}
