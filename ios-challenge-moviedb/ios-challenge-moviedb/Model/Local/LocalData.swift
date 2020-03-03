//
//  LocalData.swift
//  ios-challenge-moviedb
//
//  Created by Giovanni Severo Barros on 26/02/20.
//  Copyright © 2020 Giovanni Severo Barros. All rights reserved.
//

import Foundation

/**
 *Singleton* Responsible for all *Local Information* stored by the App
 */
final class LocalData {
    // MARK: Singleton

    /**
     The single instance of *LocalData*
     */
    static let object = LocalData()
    /**
     Data format stored by the JSON
     */
    private var local: SaveData
    
    private init() {
        local = JSONDataAccess.object.loadSave()
        self.saveAllGenres()
    }
    
    func saveAllGenres() {
        MovieClient.getAllGenres { [weak self] (genres, error) in
            guard let `self` = self else { return }
            if let genres = genres {
                self.local.allGenres = genres
                JSONDataAccess.object.saveAllGenres(genres: genres)
            }
        }
    }
    
    /**
     Get all Favorite Genres Stored in the JSON
     
     - Return: The Genres of an Favorite Movie
     */
    func getAllGenres() -> [Genre] {
        return local.allGenres
    }
    
    /**
     Get all Favorite Movies Stored in the JSON
     
     - Return: All the Favorite Movies
     */
    func getAllFavoriteMovies() -> [Int:Movie] {
        return local.favoriteMovies
    }
    
    /**
     Make an Movie into a Favorite Movie
     
     - Parameters:
     - movie: Movie to set as Favorite
     */
    func makeMovieFavorite(movie: Movie) {
        JSONDataAccess.object.isFavorite(movie: movie)
        local = JSONDataAccess.object.loadSave()
    }
    
    /**
     Make an Movie into a not Favorite Movie
     
     - Parameters:
     - movie: Movie to set as not Favorite
     */
    func makeMovieNotFavorite(movie: Movie) {
        JSONDataAccess.object.isNotFavorite(movie: movie)
        local = JSONDataAccess.object.loadSave()
    }
}
