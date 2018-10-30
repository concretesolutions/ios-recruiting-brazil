//
//  DetailMoviesPresenter.swift
//  Movs
//
//  Created by Maisa on 24/10/18.
//  Copyright © 2018 Maisa Milena. All rights reserved.
//

import UIKit

protocol DetailMoviesPresentationLogic {
    func presentMovieDetailed(response: DetailMovieModel.Response.Success)
    func presentError(error: DetailMovieModel.Response.Error)
    /// This message describes a respose is was added successfuly or not
    
}

protocol DetailsMoviesPresentFavoriteAction {
    func addMovieToFavorite(result: Bool)
}

class DetailMoviesPresenter: DetailMoviesPresentationLogic {
    
    var viewController: (DetailsMoviesDisplayLogic & DetailMoviesFavoriteMovie)?
    
    func presentMovieDetailed(response: DetailMovieModel.Response.Success) {
        let imdbVote = String(response.movie.voteAverage) + "/10"
        let genresFormatted = response.movie.genresNames.joined(separator: ", ")
        let buttonImage = response.movie.isFavorite ? UIImage(named: "favorite_full_icon") : UIImage(named: "favorite_gray_icon")
        let posterURL = URL(string: response.movie.posterPath)!
        let viewModel = DetailMovieModel.ViewModel.Success(title: response.movie.title,
                                                      overview: response.movie.overview,
                                                      genreNames: genresFormatted,
                                                      year: String.getYearRelease(fullDate: response.movie.releaseDate),
                                                      posterPath: posterURL,
                                                      imdbVote: imdbVote,
                                                      favoriteButtonImage: buttonImage!)
        viewController!.setRawDetailedMovie(movie: response.movie)
        viewController!.displayMovieDetailed(viewModel: viewModel)
    }
    
    func presentError(error: DetailMovieModel.Response.Error) {
        let viewModel = DetailMovieModel.ViewModel.Error(image: error.image, message: error.message)
        viewController?.displayError(viewModel: viewModel)
    }
    
}

// MAARK: Favorite action
extension DetailMoviesPresenter: FavoriteActionsPresentationLogic {

    func favoriteActionResponse(message: String, isFavorite: Bool) {
        let imageFavorite = isFavorite ? UIImage(named: "favorite_full_icon") : UIImage(named: "favorite_gray_icon")
        let viewModel = DetailMovieModel.ViewModel.MovieAddedToFavorite(message: message, isFavorite: isFavorite, favoriteIcon: imageFavorite!)
        viewController?.movieAddedToFavorite(viewModel: viewModel)
    }
    
}
