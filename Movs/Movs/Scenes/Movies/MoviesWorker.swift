//
//  MoviesWorker.swift
//  Movs
//
//  Created by Brendoon Ryos on 24/01/19.
//  Copyright (c) 2019 Brendoon Ryos. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import CoreData

class MoviesWorker {
  private let networkManager: Networkable
  private let databaseManager: DatabaseManager<NSManagedObject>
  
  init(networkManager: Networkable = NetworkManager(), databaseManager: DatabaseManager<NSManagedObject> = DatabaseManager<NSManagedObject>()) {
    self.networkManager = networkManager
    self.databaseManager = databaseManager
  }
  
  func fetchMovies(request: Movies.Popular.Request, completion: @escaping (Result<MoviesData>) -> ()) {
    networkManager.fetchMovies(request: request) { result in
      completion(result)
    }
  }
  
  func fetchGenres(completion: @escaping (Result<GenresData>) -> ()) {
    networkManager.fetchGenres() { result in
      switch result {
      case .success(let data):
        self.save(genres: data.genres)
      case .error:
        break
      }
      completion(result)
    }
  }
  
  func save(genres: [Genre]) {
    genres.forEach{
      let genre = CDGenre(id: $0.id, name: $0.name, context: self.databaseManager.viewContext)
      databaseManager.insert(object: genre)
    }
  }
}
