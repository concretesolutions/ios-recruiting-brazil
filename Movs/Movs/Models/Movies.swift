//
//  Movies.swift
//  Movs
//
//  Created by Marcos Lacerda on 09/08/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import Foundation

struct Movies: Decodable {
  
  let id: Int
  let title: String
  let poster: String
  let genres: [Int]
  let cover: String
  let overview: String
  let releaseAt: String
  
  fileprivate enum CodingKeys: String, CodingKey {
    case id
    case title
    case poster = "poster_path"
    case genres = "genre_ids"
    case cover = "backdrop_path"
    case overview
    case releaseAt = "release_date"
  }
  
}
