//
//  MovieListInteractor.swift
//  Movs
//
//  Created by Ricardo Rachaus on 25/10/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Foundation

class MovieListInteractor: MovieListBussinessLogic, MovieListDataStore {
    var presenter: MovieListPresentationLogic!
    var movieListWorker: MovieListWorkingLogic!
    var coreDataWorker: CoreDataWorkingLogic!
    
    var movie: Movie?
    
    private var movies: [Movie]
    
    init() {
        movieListWorker = MovieListWorker()
        coreDataWorker = CoreDataWorker()
        movies = []
    }
    
    func fetchMovies(request: MovieList.Request.Page) {
        movieListWorker.fetch(page: request.page) { (movieList, status, error) in
            switch status {
            case .success:
                self.movies.append(contentsOf: movieList.results)
                self.presentMovies(movies: self.movies)
                
            case .error:
                let response = MovieList.Response(movies: [], error: error?.localizedDescription)
                self.presenter.presentError(response: response)
            }
            
        }
    }
    
    func filterMovies(request: MovieList.Request.Movie) {
        if request.title == "" {
            presentMovies(movies: movies)
            return
        }
        
        let result = movies.filter { (movie) -> Bool in
            movie.title.lowercased().contains(request.title.lowercased())
        }
        
        if result.isEmpty {
            let response = MovieList.Response(movies: [], error: request.title)
            presenter.presentNotFind(response: response)
        } else {
            presentMovies(movies: result)
        }
    }
    
    func presentMovies(movies: [Movie]) {
        let moviesToBePresented = movies.map({ (movie) -> MovieList.Response.FetchResponse in
            let isFavorite = coreDataWorker.isFavorite(id: movie.id)
            return MovieList.Response.FetchResponse(title: movie.title, posterURL: MovieService.baseImageURL + movie.posterPath, isFavorite: isFavorite)
        })
        let response = MovieList.Response(movies: moviesToBePresented, error: nil)
        self.presenter.presentMovies(response: response)
    }
    
    func favoriteMovie(at index: Int) {
        let movie = movies[index]
        coreDataWorker.favoriteMovie(movie: movie)
        presentMovies(movies: movies)
    }
    
    func storeMovie(at index: Int) {
        movie = movies[index]
    }
    
}
