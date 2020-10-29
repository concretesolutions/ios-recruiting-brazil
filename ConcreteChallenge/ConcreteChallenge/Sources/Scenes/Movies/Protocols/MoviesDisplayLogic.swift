//
//  MoviesDisplayLogic.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import Foundation

protocol MoviesDisplayLogic: AnyObject {
    func displayMoviesItems(viewModel: Movies.FetchMovies.ViewModel)
    func displayMoviesError()
    func onSaveFavoriteSuccess(viewModel: Movies.SaveMovie.ViewModel)
    func displaySearchError(searchText: String)
}
