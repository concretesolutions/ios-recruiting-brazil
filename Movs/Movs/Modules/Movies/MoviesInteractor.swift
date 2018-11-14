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
    private var moviesVisible: [Movie] = [] {
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
                    self.moviesVisible = popularMovies
                    self.presenter?.loadedMovies()
            }
        }
    }
    
    func getMovie(index: Int) -> Movie {
        return self.moviesVisible[index]
    }
    
    func getMovieID(index: Int) -> Int {
        return self.moviesVisible[index].id
    }
    
    func getTotalMovies() -> Int {
        return moviesVisible.count
    }
    
    func getMovie(at index: Int) -> Movie {
        return moviesVisible[index]
    }
    
    func filterMovies(containing: String) {
        moviesVisible = []
        ServerManager.getMoviesSearch(page: self.moviePageSearch, searchText: containing) { (popularMovies, status) in
            switch status {
            case .error:
                print("-> Error")
                self.presenter?.loadingError()
            case .okay:
                print("-> Movies: \(popularMovies.count)")
                self.moviesVisible = popularMovies
                if popularMovies.count > 0 {
                    self.presenter?.loadedMovies()
                }else{
                    self.presenter?.noResults()
                }
            }
        }
    }
    
    func filterMoviesEnded() {
        self.moviesVisible = self.movies
    }
    
}
