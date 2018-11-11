//
//  MoviesPresenter.swift
//  Movs
//
//  Created by João Gabriel Borelli Padilha on 10/11/18.
//  Copyright © 2018 João Gabriel Borelli Padilha. All rights reserved.
//

import Foundation

class MoviesPresenter {
    
    // MARK: - VIPER
    var view: MoviesView
    var interector: MoviesInterector
    var router: MoviesRouter
    
    init(router: MoviesRouter, interactor: MoviesInterector, view: MoviesView) {
        self.router = router
        self.interector = interactor
        self.view = view
        
        self.interector.presenter = self
        self.view.presenter = self
    }
    
    func didLoad() {
        self.interector.fetchMovies()
    }
    
    func totalMovies() -> Int {
        return self.interector.movies.count
    }
    
    func loadedMovies() {
        self.view.showPopularMovies()
    }
    
}
