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
        
    }
    
    // Format the data to be presented
    private func formatData(movies: [PopularMovie]) -> [PopularMovie] {
        let formattedMovies =  movies.map { (movie) -> PopularMovie in
            var formattedMovie = movie
            formattedMovie.releaseDate = String.getYearRelease(fullDate: formattedMovie.releaseDate)
            return formattedMovie
        }
        return formattedMovies
    }
    
}
