//
//  PopularMoviesWrapperDTO.swift
//  Movs
//
//  Created by Lucca Ferreira on 17/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import Foundation

struct PopularMoviesWrapperDTO: Decodable {
    var page: Int
    var results: [MovieDTO]
    var totalResults: Int
    var totalPages: Int

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }

}
