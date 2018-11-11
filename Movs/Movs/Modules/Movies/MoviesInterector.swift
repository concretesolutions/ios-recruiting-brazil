//
//  File.swift
//  Movs
//
//  Created by João Gabriel Borelli Padilha on 10/11/18.
//  Copyright © 2018 João Gabriel Borelli Padilha. All rights reserved.
//

import UIKit

class MoviesInterector {
    
    // MARK: - VIPER
    var presenter: MoviesPresenter?
    
    // MARK: - Parameters
    var movies: [Movie] = []
    
    func fetchMovies() {
        ServerManager.call { (popularMovies) in
            print("-> Movies: \(popularMovies.count)")
            self.movies = popularMovies
            self.presenter?.loadedMovies()
        }
    }
    
}
