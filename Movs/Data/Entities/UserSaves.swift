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
    //fileprivate static var favoriteMovies: [MovieEntity] = []
    //fileprivate static var posters: [PosterEntity] = []
    
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
//        return UserSaves.favoriteMovies.contains { (mov) -> Bool in
//            movie.id == mov.id
//        }
        return storage.isFavorite(movie: movieId)
    }
    
    func getAllFavoriteMovies() -> [MovieEntity] {
        //return UserSaves.favoriteMovies
        return storage.retrieveAllMovies()!
    }
    
    func getAllPosters() -> [PosterEntity] {
        //return UserSaves.posters
        return storage.retrieveAllPosters()
    }
    
    func add(movie: MovieEntity) {
        //UserSaves.favoriteMovies.append(movie)
        storage.store(movie: movie)
    }
    
    func add(poster: PosterEntity) {
        //UserSaves.posters.append(poster)
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
