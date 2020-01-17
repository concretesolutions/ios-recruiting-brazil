//
//  PopularMoviePage.swift
//  Movs Challenge Project
//
//  Created by Jezreel Barbosa on 15/01/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit

class PopularMoviePage: Decodable {
    // Static Properties
    // Static Methods
    // Public Types
    // Public Properties
    
    let page: Int
    let totalResults: Int
    let totalPages: Int
    
    let movies: [Movie]
    
    // Public Methods
    // Initialisation/Lifecycle Methods
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        page = try container.decode(Int.self, forKey: .page)
        totalResults = try container.decode(Int.self, forKey: .totalResults)
        totalPages = try container.decode(Int.self, forKey: .totalPages)
        movies = try container.decode([Movie].self, forKey: .movies)
    }
    
    // Override Methods
    // Private Types
    
    private enum CodingKeys: String, CodingKey {
        case page = "page"
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case movies = "results"
    }
    
    // Private Properties
    // Private Methods
}
