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
    let imageBasePath = "http://image.tmdb.org/t/p/w185"
    
    // MARK: Do request
    func fetchPopularMovies(request: ListMovies.Request) {
        // Default request, no data to be presented
        if request.page == 0 {
            let responseError = ListMovies.Response.Error(image: UIImage(named: "alert_search"), description: self.formatListError(error: .noFilteredResults), errorType: .noFilteredResults)
            self.presenter.presentError(error: responseError)
        } else {
            worker.fetchPopularMovies(request: request,
                                      success: { (movieList) in
                                        let moviesFormatted = self.formatMoviesData(movieList.movies)
                                        let response = ListMovies.Response.Success(movies: moviesFormatted)
                                        self.presenter.presentMovies(response: response)
            }, error: { (error) in
                let responseError = ListMovies.Response.Error(image: UIImage(named: "alert_search"), description: self.formatListError(error: error), errorType: .serverError)
                self.presenter.presentError(error: responseError)
            }) { (errorNetwork) in
                let responseError = ListMovies.Response.Error(image: UIImage(named: "alert_error"), description: self.formatListError(error: errorNetwork), errorType: .networkFailToConnect)
                self.presenter.presentError(error: responseError)
            }
        }
    }
    
    private func formatMoviesData(_ movies: [PopularMovie]) -> [PopularMovie] {
        var moviesFormatted = [PopularMovie]()
        
        for movie in movies {
            var movieFormatted = movie
            movieFormatted.posterPath = imageBasePath + movie.posterPath
            movieFormatted.isFavorite = checkIfIsFavorite(movieId: movie.id)
            moviesFormatted.append(movieFormatted)
        }
   
        return moviesFormatted
    }

    /// Check if the movie to be presented is also an user's favorite movie
    private func checkIfIsFavorite(movieId: Int) -> Bool {
        return FavoriteMoviesWorker.shared.findMovieWith(id: movieId)
    }
    
    private func formatListError(error: FetchError) -> String {
        return "\(error.getTitle()). \(error.getDescription())"
    }
    
}
