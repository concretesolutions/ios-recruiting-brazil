//
//  Genre.swift
//  Movs
//
//  Created by Brendoon Ryos on 30/01/19.
//  Copyright © 2019 Brendoon Ryos. All rights reserved.
//

import Foundation

struct Genre {
  let id: Int
  let name: String
}

extension Genre: Decodable {
  private enum CodingKeys: String, CodingKey {
    case id
    case name
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decode(Int.self, forKey: .id)
    name = try container.decode(String.self, forKey: .name)
  }
}
