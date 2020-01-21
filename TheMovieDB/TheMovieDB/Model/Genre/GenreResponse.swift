//
//  GenreResponse.swift
//  TheMovieDB
//
//  Created by Renato Lopes on 20/01/20.
//  Copyright © 2020 renato. All rights reserved.
//

import Foundation

struct GenreResponse: Decodable{
    let id: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}
