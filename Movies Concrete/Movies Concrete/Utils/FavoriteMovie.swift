//
//  FavoriteMovie.swift
//  Movies Concrete
//
//  Created by Taina Viriato on 27/08/19.
//  Copyright © 2019 tainavm. All rights reserved.
//

import Foundation

class FavoriteMovie {
  
  static let shared = FavoriteMovie()
  
  var favorites: [Movie] = []
  var index: Int = 0
  var nextIndex: Int?
  
//  private init() {
//    favorites = UserDefaults.standard.object(forKey: "favorites") as? [Movie] ?? []
//  }
  
  func addFavorite(movie: Movie) {
    favorites.insert(movie, at: index)
    movie.isFavorite = true
    index = index + 1
    saveFavorite(movies: favorites)
  }
  
  func removeFavorite(movie: Movie) {
    let index = favorites.firstIndex{$0 === movie}
    movie.isFavorite = false
    favorites.remove(at: index!)
  }
  
  func saveFavorite(movies: [Movie]) {
    SessionHelper.saveFavorite(movies: movies)
  }
  
//  func isFavorite(movie: Movie) -> Bool {
//    return movie.isFavorite
//  }
  
  func getFavorites() -> [Movie] {
    let result = SessionHelper.getFavorites()
    return result!
  }
  
}
