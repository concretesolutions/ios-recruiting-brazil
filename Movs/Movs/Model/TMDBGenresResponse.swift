//
//  TMDBGenresResponse.swift
//  Movs
//
//  Created by Julio Brazil on 21/11/18.
//  Copyright © 2018 Julio Brazil. All rights reserved.
//

import Foundation

struct TMDBGenresResponse: Codable {
    var genres: [Genre]
}

struct Genre: Codable {
    var id: Int
    var name: String
}
