//
//  MovieParser.swift
//  Movies
//
//  Created by Matheus Ribeiro D'Azevedo Lopes on 30/10/18.
//  Copyright © 2018 Matheus Ribeiro D'Azevedo Lopes. All rights reserved.
//

import SwiftyJSON

final class MovieParser {
  
  public static func convertJSONToMovie(_ json: JSON) -> Movie {
    guard let identificator = json["id"].int,
      let title = json["title"].string,
      let voteAverage = json["vote_average"].double,
      let releaseDateString = json["release_date"].string,
      let overview = json["overview"].string else {
        fatalError("Failed to parse a movie object")
    }
    
    var posterPath: String
    
    if let path = json["poster_path"].string {
      posterPath = path
    } else {
      posterPath = ""
    }
    
    var backdropPath: String
    
    if let path = json["backdrop_path"].string {
      backdropPath = path
    } else {
      backdropPath = ""
    }
    
    let formater = DateFormatter()
    formater.dateFormat = "yyyy-mm-dd"
    
    guard let releaseDate = formater.date(from: releaseDateString) else {
      fatalError("Failed to create the date from the formater")
    }
    
    return Movie(identificator: identificator, title: title, posterPath: posterPath, voteAverage: voteAverage, releaseDate: releaseDate, isFavorite: false, overview: overview, backdropPath: backdropPath)
  }
  
  public static func convertJSONResultsToMovies(_ results: [JSON]) -> [Movie] {
    let movies = results.map { (json) -> Movie in
      return convertJSONToMovie(json)
    }
    
    return movies
  }
  
}
