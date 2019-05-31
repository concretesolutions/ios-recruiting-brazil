//
//  MoviesList.swift
//  MoviesApp
//
//  Created by Gabriel Pereira on 31/05/19.
//  Copyright © 2019 Gabriel Pereira. All rights reserved.
//

import Foundation

struct MoviesList: Codable {
    let page: Int?
    let numberOfResults: Int?
    let numberOfPages: Int?
    let movies: [Movie]?
    
    enum CodingKeys: String, CodingKey {
        case page
        case numberOfResults = "total_results"
        case numberOfPages = "total_pages"
        case movies = "results"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        page = try values.decodeIfPresent(Int.self, forKey: .page)
        numberOfResults = try values.decodeIfPresent(Int.self, forKey: .numberOfResults)
        numberOfPages = try values.decodeIfPresent(Int.self, forKey: .numberOfPages)
        movies = try values.decodeIfPresent([Movie].self, forKey: .movies)
    }
}
