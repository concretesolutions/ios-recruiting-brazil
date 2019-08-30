//
//  SessionHelper.swift
//  Movies Concrete
//
//  Created by Taina Viriato on 26/08/19.
//  Copyright © 2019 tainavm. All rights reserved.
//

import Foundation

class SessionHelper: NSObject {
  
  static func addFavoriteMovie(movie: Movie) {
    var favorites = getFavorites()
    favorites.append(movie)
    saveFavorites(movies: favorites)
  }
  
  static func removeFavoriteMovie(id: Int) {
    var favorites = getFavorites()
    for (index, favoriteMovie) in favorites.enumerated() {
      if id == favoriteMovie.id {
        favorites.remove(at: index)
      }
    }
    saveFavorites(movies: favorites)
  }
  
  static func isFavorite(id: Int) -> Bool {
    let favorites = getFavorites()
    for movie in favorites {
      if id == movie.id {
        return true
      }
    }
    return false
  }
  
  static func saveFavorites(movies: [Movie]) {
    let favoriteData = try! JSONEncoder().encode(movies)
    UserDefaults.standard.set(favoriteData, forKey: "favorites")
  }
  
  static func getFavorites() -> [Movie] {
    var favoriteArray = [Movie]()
    if let favoriteData = UserDefaults.standard.data(forKey: "favorites") {
      favoriteArray = try! JSONDecoder().decode([Movie].self, from: favoriteData)
    }
    return favoriteArray
  }
  
  static func saveGenres(genres: [Genre]) {
    let genre = try! JSONEncoder().encode(genres)
    UserDefaults.standard.set(genre, forKey: "genres")
  }
  
  static func getGenres() -> [Genre] {
    var genreArray = [Genre]()
    if let genreData = UserDefaults.standard.data(forKey: "genres") {
      genreArray = try! JSONDecoder().decode([Genre].self, from: genreData)
    }
    return genreArray
  }
  
  static func clearUserData() {
    UserDefaults.standard.removeObject(forKey: "favorites")
    UserDefaults.standard.removeObject(forKey: "isFavorite")
  }
  
}
