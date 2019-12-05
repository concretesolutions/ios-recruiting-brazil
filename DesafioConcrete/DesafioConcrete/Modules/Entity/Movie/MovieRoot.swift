//
//  MovieRoot.swift
//  DesafioConcrete
//
//  Created by Gustavo Garcia Leite on 04/12/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.
//

import Foundation

struct MovieRoot: Decodable {
    
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let results: [Movie]

    private enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}
