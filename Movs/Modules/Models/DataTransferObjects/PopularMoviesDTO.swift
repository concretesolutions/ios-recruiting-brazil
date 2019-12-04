//
//  PopularMoviesDTO.swift
//  Movs
//
//  Created by Gabriel D'Luca on 03/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import Foundation

class PopularMoviesDTO: Decodable {
    
    // MARK: - Attributes
    
    let page: Int
    let movies: [MovieDTO]
    
    // MARK: - Enums
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
    }
    
    // MARK: - Initializers and Deinitializers
    
    init(page: Int, movies: [MovieDTO]) {
        self.page = page
        self.movies = movies
    }
    
    required public convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PopularMoviesDTO.CodingKeys.self)
        
        let page: Int = try container.decode(Int.self, forKey: .page)
        let movies: [MovieDTO] = try container.decode([MovieDTO].self, forKey: .results)
                
        self.init(page: page, movies: movies)
    }
}
