//
//  ListMoviesPresenter.swift
//  Movs
//
//  Created by Maisa on 23/10/18.
//  Copyright (c) 2018 Maisa Milena. All rights reserved.


import UIKit

protocol ListMoviesPresentationLogic {
    func presentMovies(movies: [PopularMovie])
    func presentError(type: ListMovies.ErrorType)
}

class ListMoviesPresenter: ListMoviesPresentationLogic {
    
    weak var viewController: ListMoviesDisplayLogic?
    
    
    // MARK: Response from Interactor
    func presentMovies(movies: [PopularMovie]) {
        let viewModel = ListMovies.Fetch.ViewModel.Success(movies: movies)
        viewController?.displayMovies(viewModel: viewModel)
    }
    
    func presentError(type: ListMovies.ErrorType) {
        
    }
    
}
