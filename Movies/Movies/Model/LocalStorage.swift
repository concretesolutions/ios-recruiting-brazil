//
//  LocalStorage.swift
//  Movies
//
//  Created by Matheus Ribeiro D'Azevedo Lopes on 01/11/18.
//  Copyright © 2018 Matheus Ribeiro D'Azevedo Lopes. All rights reserved.
//

import Foundation

final class LocalStorage {
  
  static let shared: LocalStorage = LocalStorage()
  
  var delegate: MovieFavoriteStateChangedDelegate?
  
  enum StorageKeys: String {
    case favoriteMoviesIds
  }
  
  var favoriteMoviesIds: [Int]? {
    get {
      return UserDefaults.standard.array(forKey: StorageKeys.favoriteMoviesIds.rawValue) as? [Int]
    }
    
    set {
      if let ids = newValue {
        UserDefaults.standard.set(ids, forKey: StorageKeys.favoriteMoviesIds.rawValue)
      }
    }
  }
  
  func addFavorite(movie: Movie) {
    if var ids = favoriteMoviesIds {
      ids.append(movie.identificator)
      favoriteMoviesIds = ids
    } else {
      favoriteMoviesIds = [movie.identificator]
    }
    
    delegate?.movie(movie, changedToFavorite: true)
  }
  
  func removeFavorite(movie: Movie) {
    if let ids = favoriteMoviesIds {
      let newIds = ids.filter {$0 != movie.identificator}
      favoriteMoviesIds = newIds
      delegate?.movie(movie, changedToFavorite: false)
    }
  }
  
  func isFavoriteMovie(byId movieId: Int) -> Bool {
    if let ids = favoriteMoviesIds {
      return ids.contains(movieId)
    } else {
      return false
    }
  }
  
}

protocol MovieFavoriteStateChangedDelegate: class {
  func movie(_ movie: Movie, changedToFavorite: Bool)
}
