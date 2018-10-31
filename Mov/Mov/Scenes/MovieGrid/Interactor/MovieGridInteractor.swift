//
//  MovieListInteractor.swift
//  ShitMov
//
//  Created by Miguel Nery on 22/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation

protocol MovieGridInteractor {
    func fetchMovieList(page: Int)
    
    func toggleFavoriteMovie(at index: Int)
    
    func filterMoviesBy( string: String)
}
