//
//  ApiResponse.swift
//  ConcreteRecruiting
//
//  Created by Alysson Moreira on 23/12/19.
//  Copyright © 2019 Alysson Moreira. All rights reserved.
//

import Foundation

struct MovieApiResponse: Decodable {
    
    let page: Int
    let numberOfResults: Int
    let numberOfPages: Int
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case page
        case numberOfResults = "total_results"
        case numberOfPages = "total_pages"
        case movies = "results"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        page = try values.decode(Int.self, forKey: .page)
        numberOfResults = try values.decode(Int.self, forKey: .numberOfResults)
        numberOfPages = try values.decode(Int.self, forKey: .numberOfPages)
        movies = try values.decode([Movie].self, forKey: .movies)
        
    }
    
}
