//
//  MoviesResponse.swift
//  MoviesApp
//
//  Created by Nicholas Babo on 11/11/18.
//  Copyright © 2018 Nicholas Babo. All rights reserved.
//

import Foundation

struct MovieResponse: Codable  {
    var results: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case results
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(results, forKey: .results)
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        results = try values.decode([Movie].self, forKey: .results)
    }
}
