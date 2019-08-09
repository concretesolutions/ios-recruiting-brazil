//
//  BookMarkListPresenter.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 09/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation

class FavoritesListPresenter: ViewToFavoritesListPresenterProtocol {
    weak var view: PresenterToFavoritesListViewProtocol?
    
    var iteractor: PresenterToFavoritesListIteractorProtocol?
    
    var route: PresenterToFavoritesListRouterProtocol?
    
    func loadMovies(page: Int) {
        
    }
    
    func loadGenrers() {
        
    }
    
    
}

extension FavoritesListPresenter : IteractorToFavoritesListPresenterProtocol {
    func returnMovies(movies: [MovieListData], moviesTotal: Int) {
        
    }
    
    func returnMoviesError(message: String) {
        
    }
    
    func returnLoadGenrers(genres: [GenreData]) {
        
    }
    
    func returnLoadGenrersError(message: String) {
         
    }
    
    
}
