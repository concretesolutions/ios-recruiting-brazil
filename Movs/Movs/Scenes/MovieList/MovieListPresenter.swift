//
//  MovieListPresenter.swift
//  Movs
//
//  Created by Ricardo Rachaus on 25/10/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Foundation

protocol MovieListPresentationLogic {
    func presentMovies(response: MovieListModel.Response)
    func presentError(response: MovieListModel.Response)
}

class MovieListPresenter: MovieListPresentationLogic {
    weak var viewController: MovieListDisplayLogic!
    
    func presentMovies(response: MovieListModel.Response) {
        let movies = response.movies.map { (movie) -> MovieListModel.ViewModel.Movie in
            return MovieListModel.ViewModel.Movie(title: movie.title, posterURL: movie.posterURL, isFavorite: movie.isFavorite)
        }
        let viewModel = MovieListModel.ViewModel.Success(movies: movies)
        viewController.displayMovies(viewModel: viewModel)
    }
    
    func presentError(response: MovieListModel.Response) {
        if let error = response.error {
            let viewModel = MovieListModel.ViewModel.Error(error: error)
            viewController.displayError(viewModel: viewModel)
        }
    }
}
