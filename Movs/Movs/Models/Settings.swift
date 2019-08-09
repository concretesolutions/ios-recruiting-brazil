//
//  Settings.swift
//  Movs
//
//  Created by Marcos Lacerda on 08/08/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import Foundation

struct Settings: Decodable {
  
  let imageURL: String
  let avaliablePosterSizes: [String]
  
  fileprivate enum CodingKeys: String, CodingKey {
    case imageURL = "secure_base_url"
    case avaliablePosterSizes = "poster_sizes"
  }
  
}
