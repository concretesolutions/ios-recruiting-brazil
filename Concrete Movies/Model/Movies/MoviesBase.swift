//
//  Movies.swift
//  Concrete Movies
//
//  Created by Lucas Daniel on 24/08/19.
//  Copyright © 2019 Lucas. All rights reserved.
//

import Foundation

struct MoviesBase : Codable {
    
    let page : Int?
    let total_results : Int?
    let total_pages : Int?
    let results : [MoviesResult]?
    
    enum CodingKeys: String, CodingKey {        
        case page          = "page"
        case total_results = "total_results"
        case total_pages   = "total_pages"
        case results       = "results"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        page = try values.decodeIfPresent(Int.self, forKey: .page)
        total_results = try values.decodeIfPresent(Int.self, forKey: .total_results)
        total_pages = try values.decodeIfPresent(Int.self, forKey: .total_pages)
        results = try values.decodeIfPresent([MoviesResult].self, forKey: .results)
    }
    
}
