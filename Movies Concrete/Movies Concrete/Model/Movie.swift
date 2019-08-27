//
//  Movie.swift
//  Movies Concrete
//
//  Created by Taina Viriato on 22/08/19.
//  Copyright © 2019 tainavm. All rights reserved.
//

import Foundation
import ObjectMapper

class Movie: Mappable {
  
  var title: String?
  var posterPath: String?
  var overview: String?
  var releaseDate: String?
  var genreList: [Int]!
  
  required init?(map: Map){
    
  }
  
  init(title: String, posterPath: String, overview: String, releaseDate: String ) {
    self.title = title
    self.posterPath = posterPath
    self.overview = overview
    self.releaseDate = releaseDate
  }
  
  func mapping(map: Map) {
    
    title <- map["title"]
    posterPath <- map["poster_path"]
    overview <- map["overview"]
    releaseDate <- map["release_date"]
    genreList <- map["genre_ids"]
  }
  
}
