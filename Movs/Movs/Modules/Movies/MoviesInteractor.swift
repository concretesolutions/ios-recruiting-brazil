//
//  File.swift
//  Movs
//
//  Created by João Gabriel Borelli Padilha on 10/11/18.
//  Copyright © 2018 João Gabriel Borelli Padilha. All rights reserved.
//

import UIKit

class MoviesInteractor {
    
    // MARK: - VIPER
    var presenter: MoviesPresenter?
    
    // MARK: - Parameters
    private var movies: [Movie] = []
    
    // FROM PRESENTER
    
    func fetchMovies() {
        ServerManager.call { (popularMovies, status) in
            switch status {
                case .error:
                    print("-> Error")
                    self.presenter?.loadingError()
                case .okay:
                    print("-> Movies: \(popularMovies.count)")
                    self.movies = popularMovies
                    self.presenter?.loadedMovies()
            }
        }
    }
    
    func getTotalMovies() -> Int {
        return movies.count
    }
    
    func getMovie(at index: Int) -> Movie {
        return movies[index]
    }
    
}
