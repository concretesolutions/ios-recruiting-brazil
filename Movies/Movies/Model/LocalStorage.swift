//
//  LocalStorage.swift
//  Movies
//
//  Created by Matheus Ribeiro D'Azevedo Lopes on 01/11/18.
//  Copyright © 2018 Matheus Ribeiro D'Azevedo Lopes. All rights reserved.
//

import Foundation

final class LocalStorage {
  
  // MARK: Types
  
  enum StorageKeys: String {
    case favoriteMovies
  }
  
  // MARK: Properties
  
  static let shared: LocalStorage = LocalStorage()
  
  var delegate: MovieFavoriteStateChangedDelegate?
  
  var favoriteMovies: [Movie]? {
    get {
      if let data = UserDefaults.standard.value(forKey: StorageKeys.favoriteMovies.rawValue) as? Data {
        return try? PropertyListDecoder().decode(Array<Movie>.self, from: data)
      }
      return nil
    }
    
    set {
      if let favoriteMovies = newValue {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(favoriteMovies), forKey: StorageKeys.favoriteMovies.rawValue)
      }
    }
  }
  
  // MARK: Add and delete
  
  func addFavorite(movie: Movie) {
    var favoriteMovie = movie
    favoriteMovie.isFavorite = true
    
    if var movies = favoriteMovies {
      movies.append(favoriteMovie)
      favoriteMovies = movies
    } else {
      favoriteMovies = [favoriteMovie]
    }
    
    delegate?.movie(movie, changedToFavorite: true)
  }
  
  func removeFavorite(movie: Movie) {
    if let movies = favoriteMovies {
      let newFavoriteMovies = movies.filter {$0.identificator != movie.identificator}
      favoriteMovies = newFavoriteMovies
      delegate?.movie(movie, changedToFavorite: false)
    }
  }
  
  func isFavoriteMovie(byId movieId: Int) -> Bool {
    if let movies = favoriteMovies {
      var favorite = false
      movies.forEach { (movie) in
        if movieId == movie.identificator {
          favorite = true
        }
      }
      
      return favorite
    } else {
      return false
    }
  }
  
}

protocol MovieFavoriteStateChangedDelegate: class {
  func movie(_ movie: Movie, changedToFavorite: Bool)
}
