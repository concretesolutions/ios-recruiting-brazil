//
//  MovieListInteractor.swift
//  Movs
//
//  Created by Ricardo Rachaus on 25/10/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Foundation

protocol MovieListBussinessLogic {
    func fetchMovies(request: MovieListModel.Request.Page)
    func filterMovies(request: MovieListModel.Request.Movie)
    func favoriteMovie(at index: Int)
    func storeMovie(at index: Int)
}

protocol MovieListDataStore {
    var movie: Movie? { get set }
}

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
    
    func fetchMovies(request: MovieListModel.Request.Page) {
        movieListWorker.fetch(page: request.page) { (movieList, status, error) in
            switch status {
            case .success:
                self.movies.append(contentsOf: movieList.results)
                self.presentMovies(movies: self.movies)
                
            case .error:
                let response = MovieListModel.Response(movies: [], error: error?.localizedDescription)
                self.presenter.presentError(response: response)
            }
            
        }
    }
    
    func filterMovies(request: MovieListModel.Request.Movie) {
        if request.title == "" {
            presentMovies(movies: movies)
            return
        }
        
        let result = movies.filter { (movie) -> Bool in
            movie.title.lowercased().contains(request.title.lowercased())
        }
        
        if result.isEmpty {
            let response = MovieListModel.Response(movies: [], error: request.title)
            presenter.presentNotFind(response: response)
        } else {
            presentMovies(movies: result)
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
    
    func storeMovie(at index: Int) {
        movie = movies[index]
    }
    
}
