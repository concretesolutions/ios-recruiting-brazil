//
//  Movie.swift
//  Movies Concrete
//
//  Created by Taina Viriato on 22/08/19.
//  Copyright © 2019 tainavm. All rights reserved.
//

import Foundation
import ObjectMapper

class Movie: Mappable, Codable {
  var id: Int!
  var title: String!
  var posterPath: String?
  var overview: String?
  var releaseDate: String?
  var genreList: [Int]?
  var genresName: [String]!
  
  required init?(map: Map){
    
  }
  
  init(title: String, posterPath: String, overview: String, releaseDate: String, genreList: [Int], genresName: [String], id: Int) {
    self.id = id
    self.title = title
    self.posterPath = posterPath
    self.overview = overview
    self.releaseDate = releaseDate
    self.genreList = genreList
    self.genresName = genresName
  }
  
  func mapping(map: Map) {
    id <- map["id"]
    title <- map["title"]
    posterPath <- map["poster_path"]
    overview <- map["overview"]
    releaseDate <- map["release_date"]
    genreList <- map["genre_ids"]
  }
}
