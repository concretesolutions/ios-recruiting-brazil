//
//  DetailMoviesPresenter.swift
//  Movs
//
//  Created by Maisa on 24/10/18.
//  Copyright © 2018 Maisa Milena. All rights reserved.
//

import UIKit

protocol DetailMoviesPresentationLogic {
    func presentMovieDetailed(response: DetailMovie.Response.Success)
    func presentError(error: DetailMovie.Response.Error)
}

class DetailMoviesPresenter: DetailMoviesPresentationLogic {
    
    var viewController: DetailsMoviesDisplayLogic!
    
    func presentMovieDetailed(response: DetailMovie.Response.Success) {
        let viewModel = DetailMovie.ViewModel.Success(title: response.movie.title, overview: response.movie.overview, genreNames: response.genreNames, year: "", posterPath: response.movie.posterPath, voteAverage: response.movie.voteAverage, isFavorite: response.movie.isFavorite)
        
        viewController.displayMovieDetailed(viewModel: viewModel)
    }
    
    func presentError(error: DetailMovie.Response.Error) {
        // TODO:  create a view controller to present Error
    }
    
}
