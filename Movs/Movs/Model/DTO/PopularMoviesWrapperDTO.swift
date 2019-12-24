//
//  PopularMoviesWrapperDTO.swift
//  Movs
//
//  Created by Lucca Ferreira on 17/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import Foundation

struct PopularMoviesWrapperDTO: Decodable {
    private(set) var page: Int
    private(set) var results: [MovieDTO]
    private(set) var totalResults: Int
    private(set) var totalPages: Int

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }

}
