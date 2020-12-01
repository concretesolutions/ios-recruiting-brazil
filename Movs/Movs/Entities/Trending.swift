//
//  Tendencia.swift
//  Movs
//
//  Created by Gabriel Coutinho on 30/11/20.
//

import Foundation

struct Trending: Codable {
    let page: Int
    let results: [Media]
    let totalPages: Int
    let totalResults: Int
    
    private enum CodingKeys: String, CodingKey {
        case page,
             results,
             totalPages = "total_pages",
             totalResults = "total_results"
    }

}
