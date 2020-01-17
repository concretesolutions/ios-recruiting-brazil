//
//  FavoriteMoviesManagerProtocol.swift
//  theMovie-app
//
//  Created by Adriel Alves on 16/01/20.
//  Copyright © 2020 adriel. All rights reserved.
//

import Foundation

protocol FavoriteMoviesManagerProtocol {
    
    func fetch(filtering: String) -> [FavoriteMovieData]?
    func fetchById(index: Int64) -> [FavoriteMovieData]?
    func delete(id: Int64)
    //func addFavoriteMovie(favoriteMovieData: FavoriteMovieData)
    func addFavoriteMovie(movieVM: MovieViewModel)
    
}
