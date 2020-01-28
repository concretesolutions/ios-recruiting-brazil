//
//  ContentMovies.swift
//  Muv Concrete
//
//  Created by Mariaelena Silveira on 16/01/20.
//  Copyright © 2020 Mariaelena Silveira. All rights reserved.
//

import Foundation

class Content: Codable {
    let page: Int
    let totalResult: Int32
    let totalPages: Int32
    let results: [Movie]

    enum CodingKeys: String, CodingKey {
        case results, page
        case totalPages = "total_pages"
        case totalResult = "total_results"
        
    }
}
