//
//  MoviesData.swift
//  Movs
//
//  Created by Brendoon Ryos on 26/01/19.
//  Copyright © 2019 Brendoon Ryos. All rights reserved.
//

import Foundation

struct MoviesData {
  let page: Int
  let totalResults: Int
  let totalPages: Int
  let results: [Movie]
}


extension MoviesData: Decodable {
  private enum CodingKeys: String, CodingKey {
    case page
    case totalResults = "total_results"
    case totalPages = "total_pages"
    case results
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    page = try container.decode(Int.self, forKey: .page)
    totalResults = try container.decode(Int.self, forKey: .totalResults)
    totalPages = try container.decode(Int.self, forKey: .totalPages)
    results = try container.decode([Movie].self, forKey: .results)
  }
}
