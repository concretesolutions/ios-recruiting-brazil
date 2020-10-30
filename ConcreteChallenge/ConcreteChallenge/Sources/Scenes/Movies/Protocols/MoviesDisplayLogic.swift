//
//  MoviesDisplayLogic.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import Foundation

protocol MoviesDisplayLogic: AnyObject {
    func onFetchGenresSuccess(viewModel: Movies.FetchGenres.ViewModel)
    func displayMoviesItems(viewModel: Movies.FetchMovies.ViewModel)
    func displayMoviesError()
    func displaySearchError(searchText: String)
}
