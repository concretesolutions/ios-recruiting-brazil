//
//  MoviesAPI.swift
//  Movies
//
//  Created by Matheus Ribeiro D'Azevedo Lopes on 30/10/18.
//  Copyright © 2018 Matheus Ribeiro D'Azevedo Lopes. All rights reserved.
//

import Foundation

struct MoviesAPI {
  
  private static let apiKey = "941592b5f6cb41b1ced69ede6bc6f5be"
  
  private static let baseURL: URL = {
    guard let url = URL(string: "https://api.themoviedb.org/3") else {
      fatalError("Incorrect base url")
    }
    
    return url
  }()
  
  private static let imagesURL: URL = {
    guard let url = URL(string: "https://image.tmdb.org/t/p") else {
      fatalError("Incorrect images url")
    }
    
    return url
  }()
  
  public static var popularMoviesURL: URL {
    guard let url = URL(string: "\(baseURL.absoluteString)/discover/movie?sort_by=popularity.desc&api_key=\(apiKey)") else {
      fatalError("Incorrect popularMoviesURL url")
    }
    
    return url
  }
  
}
