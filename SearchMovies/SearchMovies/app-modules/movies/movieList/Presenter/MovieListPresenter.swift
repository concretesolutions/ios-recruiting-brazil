//
//  MovieListPresenter.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 07/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation

class MovieListPresenter: ViewToMovieListPresenterProtocol {
    weak var view: PresenterToMovieListViewProtocol?
    
    var iteractor: PresenterToMovieListIteractorProtocol?
    
    var route: PresenterToMovieListRouterProtocol?
    
    func loadMovies(page: Int) {
        self.iteractor?.loadMovies(page: page)
    }
    
    func loadGenrers() {
        self.iteractor?.loadGenrers()
    }
}

extension MovieListPresenter: IteractorToMovieListPresenterProtocol {
    func returnMoviesError(message: String) {
        self.view?.returnMoviesError(message: message)
    }
    
    
    
    func returnMovies(movies: [MovieListData], moviesTotal: Int) {
        self.view?.returnMovies(movies: movies, moviesTotal: moviesTotal)
    }
    
    func returnLoadGenrers(genres: [GenreData]) {
        self.view?.returnLoadGenrers(genres: genres)
    }
    
    func returnLoadGenrersError(message: String) {
        self.view?.returnMoviesError(message: message)
    }
    
}
