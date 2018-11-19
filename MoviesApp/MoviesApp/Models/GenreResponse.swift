//
//  GenreResponse.swift
//  MoviesApp
//
//  Created by Nicholas Babo on 18/11/18.
//  Copyright © 2018 Nicholas Babo. All rights reserved.
//

import Foundation

struct GenreResponse: Codable  {
    var genres: [Genre]
    
    private enum CodingKeys: String, CodingKey {
        case genres
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(genres, forKey: .genres)
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        genres = try values.decode([Genre].self, forKey: .genres)
    }
}
