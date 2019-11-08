//
//  Result.swift
//  MovieApp
//
//  Created by Giuliano Accorsi on 07/11/19.
//  Copyright © 2019 Giuliano Accorsi. All rights reserved.
//

import Foundation
struct Result: Codable {
    let page, totalMovies, totalPages: Int
    let movieList: [Movie]

    enum CodingKeys: String, CodingKey {
        case page
        case totalMovies = "total_results"
        case totalPages = "total_pages"
        case movieList = "results"
    }
}
