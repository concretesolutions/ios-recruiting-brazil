//
//  DetailMoviesInteractor.swift
//  Movs
//
//  Created by Maisa on 24/10/18.
//  Copyright © 2018 Maisa Milena. All rights reserved.
//

import UIKit

protocol DetailMoviesBusinessLogic {
    func fetchMovieDetailed(request: DetailMovieModel.Request)
}

class DetailMoviesInteractor: DetailMoviesBusinessLogic {
    
    var presenter: (DetailMoviesPresentationLogic & FavoriteActionsPresentationLogic)!
    var worker = DetailMovieWorker()
    // w185 is a nice size for mobile app
    private let basePath = "http://image.tmdb.org/t/p/w185"
    
    func fetchMovieDetailed(request: DetailMovieModel.Request) {
        worker.getMovieDetails(request: request,
                               success: { (movie) in
                                let movieFormatted = self.formatMovieData(movie)
                                // TODO: check if the movie is in Favorite list
                                let response = DetailMovieModel.Response.Success(movie: movieFormatted)
                                self.presenter.presentMovieDetailed(response: response)
        }, error: { (error) in
            let responseError = DetailMovieModel.Response.Error(image: UIImage(named: "alert_search"), error: error)
            self.presenter.presentError(error: responseError)
        }) { (errorNetwork) in
            let responseError = DetailMovieModel.Response.Error(image: UIImage(named: "alert_error"), error: errorNetwork)
            self.presenter.presentError(error: responseError)
        }
    }
    
    private func formatMovieData(_ movie: MovieDetailed) -> MovieDetailed {
        var movieFormatted = movie
        movieFormatted.posterPath = basePath + movie.posterPath
        // Get only the genre names
        let genresNames: [String] = movie.genres.map({ (genre) -> String in
            return genre.name
        })
        movieFormatted.genresNames = genresNames
        movieFormatted.isFavorite = checkIfIsFavorite(movie: movie)
        return movieFormatted
    }
    
    private func checkIfIsFavorite(movie: MovieDetailed) -> Bool {
        let favoriteWorker = FavoriteMoviesWorker()
        return favoriteWorker.findMovieWith(id: movie.id)
    }
    
}

extension DetailMoviesInteractor: FavoriteActionBusinessLogic {
    
    func removeFavorite(movie: MovieDetailed) {
        let favoriteWorker = FavoriteMoviesWorker()
        if favoriteWorker.removeFavoriteMovie(id: movie.id) {
            self.presenter.favoriteActionResponse(message: "Filme desfavoritado", isFavorite: false)
        }
    }

    func addFavorite(movie: MovieDetailed) {
        let favoriteWorker = FavoriteMoviesWorker()
        // If the movie was added
        if favoriteWorker.addFavoriteMovie(movie: movie) {
            self.presenter.favoriteActionResponse(message: "Filme adicionado à lista de favoritos ✨", isFavorite: true)
        } else {
            self.presenter.favoriteActionResponse(message: "Problemas ao adicionar filme à lista de favoritos", isFavorite: false)
        }
    }
    
}
