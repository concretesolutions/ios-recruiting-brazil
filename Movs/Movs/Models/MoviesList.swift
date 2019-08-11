//
//  MoviesList.swift
//  Movs
//
//  Created by Marcos Lacerda on 09/08/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import Foundation

struct MoviesList: Decodable {
  
  let actualPage: Int
  let totalPages: Int
  let movies: [Movies]
  
  fileprivate enum CodingKeys: String, CodingKey {
    case actualPage = "page"
    case totalPages = "total_pages"
    case movies = "results"
  }
  
}
