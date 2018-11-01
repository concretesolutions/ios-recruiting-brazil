//
//  MovieListPresenter.swift
//  Movs
//
//  Created by Ricardo Rachaus on 25/10/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Foundation
import Kingfisher

class MovieListPresenter: MovieListPresentationLogic {
    weak var viewController: MovieListDisplayLogic!
    
    func presentMovies(response: MovieList.Response) {
        let movies = response.movies.map { (movie) -> MovieList.ViewModel.Movie in
            let favoriteImageName = movie.isFavorite ? Constants.ImageName.favoriteFull : Constants.ImageName.favoriteGray
            return MovieList.ViewModel.Movie(title: movie.title, posterURL: movie.posterURL, favoriteImageName: favoriteImageName)
        }
        let viewModel = MovieList.ViewModel.Success(movies: movies)
        viewController.displayMovies(viewModel: viewModel)
    }
    
    func presentError(response: MovieList.Response) {
        if let error = response.error {
            let viewModel = MovieList.ViewModel.Error(error: error)
            viewController.displayError(viewModel: viewModel)
        }
    }
    
    func presentNotFind(response: MovieList.Response) {
        if let error = response.error {
            let viewModel = MovieList.ViewModel.Error(error: error)
            viewController.displayNotFind(viewModel: viewModel)
        }
    }
}
