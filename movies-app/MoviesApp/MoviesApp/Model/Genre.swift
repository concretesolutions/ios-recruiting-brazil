//
//  Genre.swift
//  MoviesApp
//
//  Created by Gabriel Pereira on 04/06/19.
//  Copyright © 2019 Gabriel Pereira. All rights reserved.
//

import Foundation

struct Genre: Codable {
    let id: Int?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
}

struct GenreResponse: Codable {
    let genres: [Genre]?
    
    enum CodingKeys: String, CodingKey {
        case genres
    }
}
