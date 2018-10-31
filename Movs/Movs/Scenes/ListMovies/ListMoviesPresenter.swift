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
        let formattedMovies = formatData(movies: response.movies)
        let viewModel = ListMovies.ViewModel.Success(movies: formattedMovies)
        viewController?.displayMovies(viewModel: viewModel)
    }
    
    func presentError(error: ListMovies.Response.Error) {
        let viewModel = ListMovies.ViewModel.Error(image: error.image, message: error.description, errorType: error.errorType)
        viewController?.displayError(viewModel: viewModel)
    }
    
    // Format the data to be presented
    private func formatData(movies: [PopularMovie]) -> [ListMovies.ViewModel.PopularMoviesFormatted] {
        let formattedMovies =  movies.map { (movie) -> ListMovies.ViewModel.PopularMoviesFormatted in
            let id = movie.id
            let title = movie.title
            let overview = movie.overview
            let favoriteIcon = movie.isFavorite ? UIImage(named: "favorite_full_icon") : UIImage(named: "favorite_gray_icon")
            let posterPath = URL(string: movie.posterPath)
            let isFavorite = movie.isFavorite
            
            return ListMovies.ViewModel.PopularMoviesFormatted(id: id, title: title, overview: overview, posterPath: posterPath!, favoriteIcon: favoriteIcon!, isFavorite: isFavorite)
        }
        return formattedMovies
    }
    
}
