//
//  Genre.swift
//  Cineasta
//
//  Created by Tomaz Correa on 03/06/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import Foundation

class GenresResult: Codable {
    var genres: [Genre]?
}

class Genre: Codable {
    var genreId: Int?
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case genreId = "id"
        case name = "name"
    }
}
