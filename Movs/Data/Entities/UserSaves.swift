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
    static var favoriteMovies: [MovieEntity] = []
    static var posters: [PosterEntity] = []
    
    //MARK: - Functions
    
    /**
     Verifies if a movie is in user saves.
     
     - Parameter movie: An instance of a movie.
     
     - Returns: Value Bool indicating movie's existence in user saves.
     */
    static func isFavorite(movie: MovieEntity) -> Bool {
        return UserSaves.favoriteMovies.contains { (mov) -> Bool in
            movie.id == mov.id
        }
    }
    
}
