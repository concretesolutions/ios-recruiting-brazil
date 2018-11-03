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
    var worker: DetailMovieWorkerProtocol = DetailMovieWorker()
    // w185 is a nice size for mobile app
    let basePath = "http://image.tmdb.org/t/p/w185"
    
    func fetchMovieDetailed(request: DetailMovieModel.Request) {
        worker.getMovieDetails(request: request,
                               success: { (movie) in
                                let movieFormatted = self.formatMovieData(movie)
                                let response = DetailMovieModel.Response.Success(movie: movieFormatted)
                                self.presenter.presentMovieDetailed(response: response)
        }, error: { (error) in
            let responseError = DetailMovieModel.Response.Error(image: UIImage(named: "alert_search"), message: self.formatListError(error: error))
            self.presenter.presentError(error: responseError)
        }) { (errorNetwork) in
            let responseError = DetailMovieModel.Response.Error(image: UIImage(named: "alert_error"), message: self.formatListError(error: errorNetwork))
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
        return FavoriteMoviesWorker.shared.findMovieWith(id: movie.id)
    }
    
    private func formatListError(error: FetchError) -> String {
        return "\(error.getTitle()). \(error.getDescription())"
    }
    
}

extension DetailMoviesInteractor: FavoriteActionBusinessLogic {
    
    func removeFavorite(movie: MovieDetailed) {
        if FavoriteMoviesWorker.shared.removeFavoriteMovie(id: movie.id) {
            self.presenter.favoriteRemove(message: "Filme desfavoritado")
        }
    }

    func addFavorite(movie: MovieDetailed) {
        // If the movie was added
        if FavoriteMoviesWorker.shared.addFavoriteMovie(movie: movie) {
            self.presenter.favoriteActionSuccess(message: "Filme adicionado à lista de favoritos ✨")
        } else {
            self.presenter.favoriteActionError(message: "Problemas ao adicionar filme à lista de favoritos")
        }
    }
    
}
