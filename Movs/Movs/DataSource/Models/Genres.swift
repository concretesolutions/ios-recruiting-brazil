//
//  Genres.swift
//  Movs
//
//  Created by Dielson Sales on 07/10/18.
//  Copyright © 2018 Dielson Sales. All rights reserved.
//

import UIKit

class Genre: Decodable {
    var genreId = -1
    var name = ""

    enum CodingKeys: String, CodingKey {
        case genreId = "id"
        case name
    }
}

class Genres: Decodable {
    var genres = [Genre]()

    enum CodingKeys: String, CodingKey {
        case genres
    }
}
