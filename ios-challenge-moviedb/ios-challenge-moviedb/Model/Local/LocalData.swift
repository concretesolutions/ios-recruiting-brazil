//
//  LocalData.swift
//  ios-challenge-moviedb
//
//  Created by Giovanni Severo Barros on 26/02/20.
//  Copyright © 2020 Giovanni Severo Barros. All rights reserved.
//

import Foundation

final class LocalData {
    
    
    // MARK: Singleton
    
    /// The single instance of `LocalData`
    static let object = LocalData()

    private var local: SaveData
    
    private init() {
        local = JSONDataAccess.object.loadSave()
    }
    
    func getAllGenres() -> [Int:String] {
        return local.favoriteGenres
    }
    
    func getAllFavoriteMovies() -> [Int:Movie] {
        return local.favoriteMovies
    }
    
    func makeMovieFavorite(movie: Movie) {
        JSONDataAccess.object.isFavorite(movie: movie)
    }
    
    func makeMovieNotFavorite(movie: Movie) {
        JSONDataAccess.object.isNotFavorite(movie: movie)
    }
}
