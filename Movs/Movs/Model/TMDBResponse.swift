//
//  tmdbResponse.swift
//  Movs
//
//  Created by Julio Brazil on 21/11/18.
//  Copyright © 2018 Julio Brazil. All rights reserved.
//

import Foundation

struct TMDBResponse: Codable {
    var page: Int
    var results: [CodableMovie]
    var total_results: Int
    var total_pages: Int
}
