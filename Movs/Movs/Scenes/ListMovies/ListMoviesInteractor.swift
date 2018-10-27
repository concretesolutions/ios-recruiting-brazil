//
//  ListMoviesInteractor.swift
//  Movs
//
//  Created by Maisa on 23/10/18.
//  Copyright (c) 2018 Maisa Milena. All rights reserved.
//


import UIKit

protocol ListMoviesBusinessLogic {
    func fetchPopularMovies(request: ListMovies.Request)
}

class ListMoviesInteractor: ListMoviesBusinessLogic {
  
    var presenter: ListMoviesPresentationLogic!
    var worker: ListMoviesWorker = ListMoviesWorker()
    // w185 is a nice size for mobile app
    private let imageBasePath = "http://image.tmdb.org/t/p/w185"
    
    // MARK: Do request
    func fetchPopularMovies(request: ListMovies.Request) {
//        var movies = [Movie]()
        
       worker.fetchPopularMovies(request: request,
                                 success: { (movieList) in
                                    let moviesFormatted = self.formatMoviesData(movieList.movies)
                                    let response = ListMovies.Response.Success(movies: moviesFormatted)
                                    self.presenter.presentMovies(response: response)
       }, error: { (error) in
            let responseError = ListMovies.Response.Error(image: UIImage(named: "alert_search"), description: self.formatListError(error: error))
            self.presenter.presentError(error: responseError)
       }) { (errorNetwork) in
            let responseError = ListMovies.Response.Error(image: UIImage(named: "alert_error"), description: self.formatListError(error: errorNetwork))
            self.presenter.presentError(error: responseError)
        }
    }
    
    private func formatMoviesData(_ movies: [PopularMovie]) -> [PopularMovie] {
        var moviesFormatted = [PopularMovie]()
        
        for movie in movies {
            var movieFormatted = movie
            movieFormatted.posterPath = imageBasePath + movie.posterPath
            moviesFormatted.append(movieFormatted)
        }
        
        return moviesFormatted
    }
    // TODO: check locally the movies id
    /// Check if the movie to be presented is also an user's favorite movie
    private func getFavoriteMovies() {
        
    }
    
    private func formatListError(error: FetchError) -> String {
        return "\(error.getTitle()). \(error.getDescription())"
    }
    
}
