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
    
    func fetchMovieDetailed(request: DetailMovie.Request) {
        print("Fetch movie interactor")
        worker.getMovieDetails(request: request,
                               success: { (movie) in
                                print(">>> success respose")
                                // Get only the genre names
                                let genres: [String] = movie.genres.map({ (genre) -> String in
                                    return genre.name
                                })
                                // TODO: check if the movie is in Favorite list
                                let response = DetailMovie.Response.Success(movie: movie, genreNames: genres)
                                self.presenter.presentMovieDetailed(response: response)
        }, error: { (error) in
            let responseError = DetailMovie.Response.Error(image: UIImage(named: "alert_search"), error: error)
            self.presenter.presentError(error: responseError)
        }) { (errorNetwork) in
            let responseError = DetailMovie.Response.Error(image: UIImage(named: "alert_error"), error: errorNetwork)
            self.presenter.presentError(error: responseError)
        }
    }
    
    
}
