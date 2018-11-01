//
//  MovieListDisplayLogic.swift
//  Movs
//
//  Created by Ricardo Rachaus on 01/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Foundation

protocol MovieListDisplayLogic: class {
    func displayMovies(viewModel: MovieList.ViewModel.Success)
    func displayError(viewModel: MovieList.ViewModel.Error)
    func displayNotFind(viewModel: MovieList.ViewModel.Error)
}
