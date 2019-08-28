//
//  Genre.swift
//  Movies Concrete
//
//  Created by Taina Viriato on 23/08/19.
//  Copyright © 2019 tainavm. All rights reserved.
//

import Foundation
import ObjectMapper

class Genre: Mappable, Codable {
  
  var id: Int?
  var name: String?
  
  required init?(map: Map){
    
  }
  
  init(id: Int, name: String ) {
    self.id = id
    self.name = name
  }
  
  func mapping(map: Map) {
    
    id <- map["id"]
    name <- map["name"]
  }
  
}
