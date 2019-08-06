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
    fileprivate static var favoriteMovies: [MovieEntity] = []
    fileprivate static var posters: [PosterEntity] = []
    
    var count: Int {
        return UserSaves.favoriteMovies.count
    }
    
    //MARK: - Functions
    
    /**
     Verifies if a movie is in user saves.
     
     - Parameter movie: An instance of a movie.
     
     - Returns: Value Bool indicating movie's existence in user saves.
     */
    func isFavorite(movie: MovieEntity) -> Bool {
        return UserSaves.favoriteMovies.contains { (mov) -> Bool in
            movie.id == mov.id
        }
    }
    
    func getAllFavoriteMovies() -> [MovieEntity] {
        return UserSaves.favoriteMovies
    }
    
    func getAllPosters() -> [PosterEntity] {
        return UserSaves.posters
    }
    
    func add(movie: MovieEntity) {
        UserSaves.favoriteMovies.append(movie)
    }
    
    func add(poster: PosterEntity) {
        UserSaves.posters.append(poster)
    }
    
    func remove(movie: MovieEntity, withPoster poster: Bool) {
        UserSaves.favoriteMovies.removeAll { (mov) -> Bool in
            mov.id == movie.id
        }
        
        if poster {
            UserSaves.posters.removeAll { (post) -> Bool in
                post.movieId == movie.id
            }
        }
    }
    
}
