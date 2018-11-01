//
//  Genre.swift
//  ConcreteChallenge
//
//  Created by Thiago  Wlasenko Nicolau on 01/11/18.
//  Copyright © 2018 Thiago  Wlasenko Nicolau. All rights reserved.
//

import Foundation

struct GenreJSON: Decodable {
    var genres: [Genre]?
}

struct Genre: Decodable {
    var id: Int?
    var name: String?
}
