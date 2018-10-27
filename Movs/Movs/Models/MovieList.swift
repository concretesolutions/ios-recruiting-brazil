//
//  MovieList.swift
//  Movs
//
//  Created by Maisa on 24/10/18.
//  Copyright © 2018 Maisa Milena. All rights reserved.
//

import Foundation

struct MovieList {
    var movies: [PopularMovie]
}

extension MovieList: Decodable {
    
    private enum ListCodingKeys: String, CodingKey {
        case results = "results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ListCodingKeys.self)
        movies = try container.decode([PopularMovie].self, forKey: .results)
    }
}
