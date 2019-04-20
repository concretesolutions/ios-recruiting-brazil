//
//  Response.swift
//  movs
//
//  Created by Lorien on 16/04/19.
//  Copyright © 2019 Lorien. All rights reserved.
//

import Foundation

struct ResponseMovies<T: Codable> : Codable {
    
    let results: [T]
    
    private enum CodingKeys: String, CodingKey {
        case results
    }
    
}

struct ResponseGenres<T: Codable> : Codable {
    
    let genres: [T]
    
    private enum CodingKeys: String, CodingKey {
        case genres
    }
    
}
