//
//  Genres.swift
//  movs
//
//  Created by Isaac Douglas on 23/01/20.
//  Copyright © 2020 Isaac Douglas. All rights reserved.
//

import Foundation

struct Genres: Codable {
    let genres: [Genre]
    
    static var shared: Genres?
}

struct Genre: Codable {
    let id: Int
    let name: String
}
