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
  
  // Attribute to control if the movie is faved on local database
  var faved: Bool = false
  
  // Attribute to list genres of movie
  var genresList: String {
    let movieGenres = MovsSingleton.shared.genres.filter { genre in
      return genres.contains(genre.id)
    }.map( { $0.name } )

    return movieGenres.joined(separator: ", ")
  }
  
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
