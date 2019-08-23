//
//  MoviesList.swift
//  Movies Concrete
//
//  Created by Taina Viriato on 22/08/19.
//  Copyright © 2019 tainavm. All rights reserved.
//

import Foundation
import ObjectMapper

class MoviesList: Mappable {
  
  var results: [Movie]!
  var total_results: Int!
  var total_pages: Int!
  
  required init?(map: Map){
  }
  
  init() {
    
  }
  
  func mapping(map: Map) {
    results <- map["results"]
    total_results <- map["total_results"]
    total_pages <- map["total_pages"]
  }
  
}


