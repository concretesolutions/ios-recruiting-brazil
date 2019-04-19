//
//  Response.swift
//  movs
//
//  Created by Lorien on 16/04/19.
//  Copyright © 2019 Lorien. All rights reserved.
//

import Foundation

struct Response<T: Codable> : Codable {
    
    let page: Int
    let totalPages: Int
    let totalResults: Int
    let results: [T]
    
    private enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case results
    }
    
}
