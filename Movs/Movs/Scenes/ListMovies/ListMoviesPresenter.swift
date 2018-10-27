//
//  ListMoviesPresenter.swift
//  Movs
//
//  Created by Maisa on 23/10/18.
//  Copyright (c) 2018 Maisa Milena. All rights reserved.


import UIKit

protocol ListMoviesPresentationLogic {
    func presentMovies(response: ListMovies.Response.Success)
    func presentError(error: ListMovies.Response.Error)
}

class ListMoviesPresenter: ListMoviesPresentationLogic {
    
    weak var viewController: ListMoviesDisplayLogic?
    
    
    // MARK: Response from Interactor
    func presentMovies(response: ListMovies.Response.Success) {
        let viewModel = ListMovies.ViewModel.Success(movies: response.movies)
        viewController?.displayMovies(viewModel: viewModel)
    }
    
    func presentError(error: ListMovies.Response.Error) {
        
    }
    
}
