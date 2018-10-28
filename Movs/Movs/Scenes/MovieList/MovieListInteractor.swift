//
//  MovieListInteractor.swift
//  Movs
//
//  Created by Ricardo Rachaus on 25/10/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Foundation

protocol MovieListBussinessLogic {
    func fetchMovies(request: MovieListModel.Request)
    func favoriteMovie(at index: Int)
}

class MovieListInteractor: MovieListBussinessLogic {
    var presenter: MovieListPresentationLogic!
    var movieListWorker: MovieListWorkingLogic!
    var coreDataWorker: CoreDataWorkingLogic!
    
    private var movies: [Movie]
    
    init() {
        movieListWorker = MovieListWorker()
        coreDataWorker = CoreDataWorker()
        movies = []
    }
    
    func fetchMovies(request: MovieListModel.Request) {
        movieListWorker.fetch(page: request.page) { (movieList, status, error) in
            switch status {
            case .success:
                self.movies = movieList.results
                self.presentMovies(movies: movieList.results)
                
            case .error:
                let response = MovieListModel.Response(movies: [], error: error?.localizedDescription)
                self.presenter.presentError(response: response)
            }
            
        }
    }
    
    func presentMovies(movies: [Movie]) {
        let moviesToBePresented = movies.map({ (movie) -> MovieListModel.Response.FetchResponse in
            let isFavorite = coreDataWorker.isFavorite(movie: movie)
            return MovieListModel.Response.FetchResponse(title: movie.title, posterURL: MovieService.baseImageURL + movie.posterPath, isFavorite: isFavorite)
        })
        let response = MovieListModel.Response(movies: moviesToBePresented, error: nil)
        self.presenter.presentMovies(response: response)
    }
    
    func favoriteMovie(at index: Int) {
        let movie = movies[index]
        if coreDataWorker.isFavorite(movie: movie) {
            coreDataWorker.delete(movie: movie)
        } else {
            coreDataWorker.create(movie: movie)
        }
        presentMovies(movies: movies)
    }
    
}
