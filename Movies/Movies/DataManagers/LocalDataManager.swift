//
//  LocalDataManager.swift
//  Movies
//
//  Created by Renan Germano on 12/11/2018.
//  Copyright © 2018 Renan Germano. All rights reserved.
//

import Foundation

class LocalDatamanager {
    
    // MARK: - Functions
    
    // MARK: Genres
    
    static func readGenres() -> [Genre] {
        
        return []
    }
    
    static func readGenresByIds(_ ids: [Int]) -> [Genre] {
        
        return []
    }
    
    static func updateGenres(_ genres: [Genre]) {
        
    }
    
    // MARK: Favorite Movies
    
    static func createFavoriteMovie(_ movie: Movie) {
        
    }
    
    static func readFavoriteMovies() -> [Movie] {
        
        return []
    }
    
    static func deleteFavoriteMovie(_ movie: Movie) {
        
    }
    
}
