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
    
    func loadMovies() {
        self.iteractor?.loadMovies()
    }
    
    
}

extension MovieListPresenter: IteractorToMovieListPresenterProtocol {
    func returnMoviesError(message: String) {
        self.view?.returnMoviesError(message: message)
    }
    
    func returnMovies(movies: [MovieListData]) {
         self.view?.returnMovies(movies: movies)
    }
    
    
}
