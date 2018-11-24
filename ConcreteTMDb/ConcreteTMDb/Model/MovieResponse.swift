//
//  MovieResponse.swift
//  ConcreteTMDb
//
//  Created by Pedro Del Rio Ortiz on 22/11/18.
//  Copyright © 2018 Pedro Ortiz. All rights reserved.
//

import Foundation

struct MovieResponse: Codable {
    
    var movies: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case results
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(movies, forKey: .results)
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.movies = try values.decode([Movie].self, forKey: .results)
    }
}
