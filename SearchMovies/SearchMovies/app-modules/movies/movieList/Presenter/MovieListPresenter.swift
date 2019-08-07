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
        
    }
    
    
}

extension MovieListPresenter: IteractorToMovieListPresenterProtocol {
    func returnMovies(movies: [MovieListData]) {
         
    }
    
    
}
