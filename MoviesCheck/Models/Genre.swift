//
//  Genre.swift
//  MoviesCheck
//
//  Created by Daniel Lima on 03/11/18.
//  Copyright © 2018 Daniel Lima. All rights reserved.
//

import Foundation

struct Genre:Codable {
    
    let id: Int
    let name: String
    
    enum CodingKeys : String, CodingKey {
        case id
        case name
    }
    
}

struct GenreResult:Codable {
    let genres:Array<Genre>
    enum CodingKeys : String, CodingKey {
        case genres
    }
}
