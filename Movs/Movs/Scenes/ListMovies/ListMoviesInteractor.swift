//
//  ListMoviesInteractor.swift
//  Movs
//
//  Created by Maisa on 23/10/18.
//  Copyright (c) 2018 Maisa Milena. All rights reserved.
//


import UIKit

protocol ListMoviesBusinessLogic {
    func fetchPopularMovies(request: ListMovies.Fetch.Request)
}

class ListMoviesInteractor: ListMoviesBusinessLogic {
  
    var presenter: ListMoviesPresentationLogic?
    var worker: ListMoviesWorker = ListMoviesWorker()
  
    // MARK: Do request
    func fetchPopularMovies(request: ListMovies.Fetch.Request) {
//        var movies = [Movie]()
        
        worker.fetchPopularMovies(page: 1) { (response) in
            if let movies = response.movies {
                let moviesFormatted = self.getFavoriteMovies(moviesResponse: movies)
                self.presenter?.presentMovies(movies: moviesFormatted)
            }
            // TODO: treat error
        }
    }
    
    // TODO: check locally the movies id
    /// Check if the movie to be presented is also an user's favorite movie
    private func getFavoriteMovies(moviesResponse: [PopularMovie]) -> [PopularMovie] {
        
        return moviesResponse
    }
    
}
