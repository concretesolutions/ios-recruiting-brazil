//
//  Genre.swift
//  Movs
//
//  Created by Marcos Lacerda on 09/08/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import Foundation

struct Genres: Decodable {
  
  let id: Int
  let name: String
  
  fileprivate enum CodingKeys: String, CodingKey {
    case id
    case name
  }
  
}
