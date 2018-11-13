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
    private var moviesFiltered: [Movie] = [] {
        didSet {
            self.presenter?.moviesFilterChanged()
        }
    }
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
                    self.moviesFiltered = popularMovies
                    self.presenter?.loadedMovies()
            }
        }
    }
    
    func getTotalMovies() -> Int {
        return moviesFiltered.count
    }
    
    func getMovie(at index: Int) -> Movie {
        return moviesFiltered[index]
    }
    
    func filterMovies(containing: String) {
        moviesFiltered = []
        for movie in movies {
            if movie.title.contains(containing) {
                self.moviesFiltered.append(movie)
            }
        }
    }
    
    func filterMoviesEnded() {
        self.moviesFiltered = self.movies
    }
    
}
