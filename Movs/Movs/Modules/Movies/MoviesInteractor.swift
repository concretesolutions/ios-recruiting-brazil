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
    
    private var moviePageSearch: Int = 1
    private var moviePage: Int = 1
    
    // FROM PRESENTER
    
    func fetchMovies() {
        ServerManager.getMovies(page: self.moviePage) { (popularMovies, status) in
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
        ServerManager.getMoviesSearch(page: self.moviePageSearch, searchText: containing) { (popularMovies, status) in
            switch status {
            case .error:
                print("-> Error")
                self.presenter?.loadingError()
            case .okay:
                print("-> Movies: \(popularMovies.count)")
                self.moviesFiltered = popularMovies
                self.presenter?.loadedMovies()
            }
        }
    }
    
    func filterMoviesEnded() {
        self.moviesFiltered = self.movies
    }
    
}
