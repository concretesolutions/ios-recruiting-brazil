//
//  MoviesListPresenterProtocol.swift
//  TMDBMoviesSample
//
//  Created by Breno Rage Aboud on 03/10/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

protocol MoviesListPresenterProtocol {
    var moviesLists: MoviesPages? { get }
    func getMovies()
}
