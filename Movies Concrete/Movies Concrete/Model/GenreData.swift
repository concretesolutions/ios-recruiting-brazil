//
//  GenreData.swift
//  Movies Concrete
//
//  Created by Taina Viriato on 24/08/19.
//  Copyright © 2019 tainavm. All rights reserved.
//

import Foundation
import ObjectMapper

class GenreData: Mappable {
  
  var genres: [Genre]!
  
  required init?(map: Map){
  }
  
  init() {
    
  }
  
  func mapping(map: Map) {
    genres <- map["genres"]
  }
  
}
