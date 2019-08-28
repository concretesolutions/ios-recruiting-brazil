//
//  SessionHelper.swift
//  Movies Concrete
//
//  Created by Taina Viriato on 26/08/19.
//  Copyright © 2019 tainavm. All rights reserved.
//

import Foundation

class SessionHelper: NSObject {

//  static func saveFavorite(movies: [Movie]) {
//    movie.isFavorite = true
//    let isFavorite = movie.isFavorite
//    movies.append(movie)
//    let favoriteData = try! JSONEncoder().encode(movies)
//    UserDefaults.standard.set(favoriteData, forKey: "favorites")
//    UserDefaults.standard.set(isFavorite, forKey: "isFavorite")
//  }

  static func saveFavorite(movies: [Movie]) {
    let favoriteData = try! JSONEncoder().encode(movies)
    UserDefaults.standard.set(favoriteData, forKey: "favorites")
  }
  
//  static func saveFavorite(movies: [Movie]) {
//    let placesData = NSKeyedArchiver.archivedData(withRootObject: movies)
//    UserDefaults.standard.set(placesData, forKey: "favorites")
//  }
  
  static func isFavorite() -> Bool {
    return UserDefaults.standard.bool(forKey: "isFavorite")

  }
//  public static func getFavorites()  {
//    let placesData = UserDefaults.standard.object(forKey: "favorites") as? NSData
//
//    if let placesData = placesData {
//      let placesArray = NSKeyedUnarchiver.unarchiveObject(with: placesData as Data) as? [Movie]
//
//      if let placesArray = placesArray {
//          print(placesArray)
//      }
//
//    }
//
//  }
  
   static func getFavorites() -> [Movie]? {
    let favoriteData = UserDefaults.standard.data(forKey: "favorites")
    let favoriteArray = try! JSONDecoder().decode([Movie].self, from: favoriteData!)
    return favoriteArray
  }
  
  static func saveGenres(genres: [Genre]) {
      let genre = try! JSONEncoder().encode(genres)
      UserDefaults.standard.set(genre, forKey: "genres")
  }
  
  static func getGenres() -> [Genre]? {
    let genreData = UserDefaults.standard.data(forKey: "genres")
    let genreArray = try! JSONDecoder().decode([Genre].self, from: genreData!)
    return genreArray
  }
  
}
