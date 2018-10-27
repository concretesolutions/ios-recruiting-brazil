//
//  FavoriteMoviesInteractor.swift
//  Movs
//
//  Created by Maisa on 27/10/18.
//  Copyright © 2018 Maisa Milena. All rights reserved.
//

import Foundation

protocol FavoriteMoviesBusinessLogic {
    func getMovies()
    func removeMovie(request: FavoriteMoviesModel.Request.Remove)
}

class FavoriteMoviesInteractor: FavoriteMoviesBusinessLogic {
    
    var presenter: FavoriteMoviesPresentationLogic!
    let worker = FavoriteMoviesWorker()
    
    func removeMovie(request: FavoriteMoviesModel.Request.Remove) {
        
    }
    
    func getMovies() {
        
    }
    
}
