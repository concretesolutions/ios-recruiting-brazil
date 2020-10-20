//
//  APIResponse.swift
//  app
//
//  Created by rfl3 on 19/10/20.
//  Copyright © 2020 renacio. All rights reserved.
//

import Foundation

struct APIResponse: Codable {

    var page: Int
    var totalPages: Int
    var results: [Movie]

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
    }
}
