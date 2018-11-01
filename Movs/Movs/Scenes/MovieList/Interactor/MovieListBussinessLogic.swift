//
//  MovieListBussinessLogic.swift
//  Movs
//
//  Created by Ricardo Rachaus on 01/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Foundation

protocol MovieListBussinessLogic {
    func fetchMovies(request: MovieList.Request.Page)
    func filterMovies(request: MovieList.Request.Movie)
    func favoriteMovie(at index: Int)
    func storeMovie(at index: Int)
}
