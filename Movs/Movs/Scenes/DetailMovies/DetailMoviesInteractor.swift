//
//  DetailMoviesInteractor.swift
//  Movs
//
//  Created by Maisa on 24/10/18.
//  Copyright © 2018 Maisa Milena. All rights reserved.
//

import UIKit

protocol DetailMoviesBusinessLogic {
    func fetchMovieDetailed(request: DetailMovie.Request)
}

class DetailMoviesInteractor: DetailMoviesBusinessLogic {
    
    var presenter: DetailMoviesPresentationLogic!
    var worker = DetailMovieWorker()
    // w185 is a nice size for mobile app
    private let basePath = "http://image.tmdb.org/t/p/w185"
    
    func fetchMovieDetailed(request: DetailMovie.Request) {
        worker.getMovieDetails(request: request,
                               success: { (movie) in
                                // Get only the genre names
                                let genres: [String] = movie.genres.map({ (genre) -> String in
                                    return genre.name
                                })
                                let movieFormatted = self.formatMovieData(movie)
                                // TODO: check if the movie is in Favorite list
                                let response = DetailMovie.Response.Success(movie: movieFormatted, genreNames: genres)
                                self.presenter.presentMovieDetailed(response: response)
        }, error: { (error) in
            let responseError = DetailMovie.Response.Error(image: UIImage(named: "alert_search"), error: error)
            self.presenter.presentError(error: responseError)
        }) { (errorNetwork) in
            let responseError = DetailMovie.Response.Error(image: UIImage(named: "alert_error"), error: errorNetwork)
            self.presenter.presentError(error: responseError)
        }
    }
    
    private func formatMovieData(_ movie: MovieDetailed) -> MovieDetailed {
        var movieFormatted = movie
        movieFormatted.posterPath = basePath + movie.posterPath
        return movieFormatted
    }
    
}
