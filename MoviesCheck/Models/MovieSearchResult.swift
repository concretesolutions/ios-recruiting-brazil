//
//  MovieSearchResult.swift
//  MoviesCheck
//
//  Created by Daniel Lima on 26/10/18.
//  Copyright © 2018 Daniel Lima. All rights reserved.
//

import Foundation

struct MovieSearchResult:Codable {
    
    var page:Int
    var totalResults:Int
    var totalPages:Int
    var items:Array<MovieMediaItem>
    
    enum CodingKeys : String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case items = "results"
    }
    
}
