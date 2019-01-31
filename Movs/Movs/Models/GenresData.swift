//
//  GenresData.swift
//  Movs
//
//  Created by Brendoon Ryos on 30/01/19.
//  Copyright © 2019 Brendoon Ryos. All rights reserved.
//

import Foundation

struct GenresData {
  let genres: [Genre]
}

extension GenresData: Decodable {
  
  private enum CodingKeys: String, CodingKey {
    case genres
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    genres = try container.decode([Genre].self, forKey: .genres)
  }
}
