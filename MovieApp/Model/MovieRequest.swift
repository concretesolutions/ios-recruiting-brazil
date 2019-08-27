//
//  MovieRequest.swift
//  MovieApp
//
//  Created by Mac Pro on 27/08/19.
//  Copyright © 2019 Mac Pro. All rights reserved.
//

import Foundation

class MovieRequest{
    
    var page: Int
    var totalResult: Int
    var totalPages: Int
    var results: [Movie]
    
    
    init(page: Int, totalResult: Int, totalPages: Int, results: [Movie]) {
        self.page = page
        self.totalResult = totalResult
        self.totalPages = totalPages
        self.results = results
    }
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResult = "total_results"
        case totalPages = "total_pages"
        case results
    }
    
}
