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
        let imdbVote = String(response.movie.voteAverage) + "/10"
        let genresFormatted = response.genreNames.joined(separator: ", ")
        let buttonImage = response.movie.isFavorite ? UIImage(named: "favorite_full_icon") : UIImage(named: "favorite_gray_icon")
        let posterURL = URL(string: response.movie.posterPath)!
        
        let viewModel = DetailMovie.ViewModel.Success(title: response.movie.title,
                                                      overview: response.movie.overview,
                                                      genreNames: genresFormatted,
                                                      year: "",
                                                      posterPath: posterURL,
                                                      imdbVote: imdbVote,
                                                      favoriteButtonImage: buttonImage!)
        
        viewController.displayMovieDetailed(viewModel: viewModel)
    }
    
    func presentError(error: DetailMovie.Response.Error) {
        // TODO:  create a view controller to present Error
    }
    
}
