//
//  GenresResponse.swift
//  MyMoviesCollection
//
//  Created by Filipe Merli on 14/03/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import Foundation

struct GenresResponse: Decodable {
    
    let genres: [Genres]
    
    enum CodingKeys: String, CodingKey {
        case genres
    }
}
