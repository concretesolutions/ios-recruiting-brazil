//
//  GenresListDTO.swift
//  Movs
//
//  Created by Gabriel D'Luca on 04/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import Foundation

class GenresListDTO: Decodable {
    
    // MARK: - Attributes
    
    let genres: [GenreDTO]

    // MARK: - Enums
    
    enum CodingKeys: String, CodingKey {
        case genres
    }
    
    // MARK: - Initializers and Deinitializers
    
    init(genres: [GenreDTO]) {
        self.genres = genres
    }
    
    required public convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: GenresListDTO.CodingKeys.self)
        
        let genres: [GenreDTO] = try container.decode([GenreDTO].self, forKey: .genres)
        self.init(genres: genres)
    }
}
