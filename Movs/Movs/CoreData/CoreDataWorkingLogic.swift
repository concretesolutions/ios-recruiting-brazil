//
//  CoreDataWorkingLogic.swift
//  Movs
//
//  Created by Ricardo Rachaus on 01/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Foundation

/**
 Interface to handle Core Data actions.
 */
protocol CoreDataWorkingLogic {
    /**
     Save the movie in the database.
     
     - parameters:
     - movie: Movie to be saved.
     */
    func save(movie: Movie)
    
    /**
     Fetch all movies favorite.
     
     - Returns: movies : [Movie]
     */
    func fetchFavoriteMovies() -> [Movie]
    
    /**
     Delete a movie in the database.
     
     - parameters:
     - movie: Movie to be deleted.
     */
    func delete(movie: Movie)
    
    /**
     Delete all movies in the database.
     */
    func deleteAll()
    
    /**
     If the movie is alreay favorite, delete from the database. Else, save it.
     
     - parameters:
     - movie: Movie to be favorited.
     */
    func favoriteMovie(movie: Movie)
    
    /**
     Check if a movie is already favorite.
     
     - parameters:
     - id: Movie id.
     
     - Returns: isFavorite : Bool
     */
    func isFavorite(id: Int) -> Bool
    
    /**
     Fetch movies filtered by genre.
     
     - parameters:
         - filter: Genre id to filter.
     
     - Returns: movies : [Movies]
     */
    func fetchFilteredGenre(_ filter: String) -> [Movie]
    
    /**
     Fetch movies filtered by year.
     
     - parameters:
     - filter: Year to filter.
     
     - Returns: movies : [Movies]
     */
    func fetchFilteredYear(_ filter: String) -> [Movie]
    
    /**
     Fetch movies with filter by year and genre.
     
     - parameters:
         - year: Year to filter.
         - genre: Genre to filter
     
     - Returns: movies : [Movie]
     */
    func fetchMoviesFiltered(by year: String, by genre: String) -> [Movie]
}
