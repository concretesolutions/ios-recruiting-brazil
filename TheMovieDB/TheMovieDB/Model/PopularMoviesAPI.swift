//
//  PopularMoviesAPI.swift
//  TheMovieDB
//
//  Created by Renato Lopes on 11/01/20.
//  Copyright © 2020 renato. All rights reserved.
//

import Foundation
import UIKit

struct PopularMoviesAPI: Decodable {
    let page, totalResults, totalPages: Int
    let movies: [Movie]

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case movies = "results"
    }
    
    public func nextPage() -> Int {
        if existNextPages() {
            return page + 1
        } else {
            return page
        }
    }
    
    public func existNextPages() -> Bool{
        return page < totalPages
    }
}
