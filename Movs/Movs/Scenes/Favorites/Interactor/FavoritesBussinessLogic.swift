//
//  FavoritesBussinessLogic.swift
//  Movs
//
//  Created by Ricardo Rachaus on 02/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Foundation

protocol FavoritesBussinessLogic {
    /**
     Fetch favorite movies.
     
     - parameters:
         - request: Movies requested.
     */
    func fetchFavoritesMovies(request: Favorites.Request)
    
    /**
     Filter movies requested.
     
     - parameters:
         - request: Filters requested.
     */
    func filterMovies(request: Favorites.Request.RequestMovie)
    
    /**
     Prepare filtered movies present.
     
     - parameters:
         - request: Filtered movies requested.
     */
    func prepareFilteredMovies(request: Favorites.Request.Filtered)
    
    /**
     Unfavorite movie at index.
     
     - parameters:
         - index: Index of the movie to be unfavorite.
     */
    func unfavoriteMovie(at index: Int)
}
