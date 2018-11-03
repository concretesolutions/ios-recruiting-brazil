//
//  FavoritesBussinessLogic.swift
//  Movs
//
//  Created by Ricardo Rachaus on 02/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Foundation

protocol FavoritesBussinessLogic {
    func fetchFavoritesMovies(request: Favorites.Request)
    func filterMovies(request: Favorites.Request.RequestMovie)
    func prepareFilteredMovies(request: Favorites.Request.Filtered)
    func unfavoriteMovie(at index: Int)
}
