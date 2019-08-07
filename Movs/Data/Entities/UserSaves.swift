//
//  UserSaves.swift
//  ConcreteChallenge_BrunoChagas
//
//  Created by Bruno Chagas on 29/07/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import Foundation

/**
 This class is responsable of saving user favorite movies while application is running
 */
class UserSaves {
    
    //MARK: - Properties
    var count: Int {
        return storage.count
    }
    
    let storage = LocalDataSaving()
    
    //MARK: - Functions
    
    /**
     Verifies if a movie is in user saves.
     
     - Parameter movie: An instance of a movie.
     
     - Returns: Value Bool indicating movie's existence in user saves.
     */
    func isFavorite(movie movieId: Int) -> Bool {
        return storage.isFavorite(movie: movieId)
    }
    
    func getAllFavoriteMovies() -> [MovieEntity] {
        return storage.retrieveAllMovies()!
    }
    
    func getAllPosters() -> [PosterEntity] {
        return storage.retrieveAllPosters()
    }
    
    func add(movie: MovieEntity) {
        storage.store(movie: movie)
    }
    
    func add(poster: PosterEntity) {
        storage.store(poster: poster)
    }
    
    func remove(movie movieId: Int, withPoster poster: Bool) {
        storage.delete(movie: movieId)
        storage.delete(poster: movieId)
    }
    
    func removeAll() {
        storage.deleteAllMovies()
        storage.deleteAllPosters()
    }
    
}
