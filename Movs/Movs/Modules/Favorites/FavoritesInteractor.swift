//
//  FavoritesInteractor.swift
//  Movs
//
//  Created by João Gabriel Borelli Padilha on 10/11/18.
//  Copyright © 2018 João Gabriel Borelli Padilha. All rights reserved.
//

import UIKit

class FavoritesInteractor {
    
    // MARK: - VIPER
    var presenter: FavoritesPresenter?
    
    // MARK: - Parameters
    var filter: MovieFilter = MovieFilter(year: [], genre:[]) {
        didSet {
            if filter.year == [] && filter.genre == [] {
                self.filterMoviesEnded()
            }else{
                self.filterMovies()
            }
        }
    }
    
    private var moviesVisible: [MovieLocal] = [] {
        didSet {
            self.presenter?.moviesFilterChanged()
        }
    }
    private var movies: [MovieLocal] = []
    
    // FROM PRESENTER
    
    func filterMovies(containing: String) {
        moviesVisible = []
        for movie in movies {
            if movie.title!.contains(containing) {
                self.moviesVisible.append(movie)
            }
        }
    }
    
    func filterMoviesEnded() {
        self.moviesVisible = self.movies
    }
    
    func getMovieID(index: Int) -> Int {
        return Int(self.moviesVisible[index].id)
    }
    
    func fetchFavoriteMovies() {
        self.movies = LocalManager.getMovies()
        self.moviesVisible = self.movies
    }
    
    func getTotalMovies() -> Int {
        return moviesVisible.count
    }
    
    func getMovie(at index: Int) -> MovieDetail {
        let storedMovie = moviesVisible[index]
        let movie = MovieDetail.init(adult: false, genres: nil, title: storedMovie.title!, release_date: storedMovie.year!, poster_path: storedMovie.image!, overview: storedMovie.overview!, homepage: nil, id: Int(storedMovie.id))
        return movie
    }
    
    func removeFavoriteMovie(at index: Int) {
        var movieIndex = index
        if hasFilter() {
            movieIndex -= 1
        }
        let movieID = Int(self.moviesVisible[movieIndex].id)
        LocalManager.remove(movieID: movieID)
        self.filtersEnded()
        self.fetchFavoriteMovies()
    }
    
    func addFilterGenre(with genre: String) {
        self.filter.genre?.append(genre)
    }
    func addFilterYear(with year: String) {
        self.filter.year?.append(year)
    }
    
    func removeFilterGenre(with genre: String) {
        self.filter.genre?.removeAll(where: { (string) -> Bool in
            return string == genre
        })
    }
    func removeFilterYear(with year: String) {
        self.filter.year?.removeAll(where: { (string) -> Bool in
            return string == year
        })
    }
    
    func hasFilter() -> Bool {
        if filter.year == [] && filter.genre == [] {
            return false
        }
        return true
    }
    
    func filtersEnded() {
        self.filter = MovieFilter(year: [], genre:[])
    }
    
    func reloadMovies() {
        self.fetchFavoriteMovies()
        self.filterMovies()
    }
    
    func filterMovies() {
        
        self.moviesVisible = []
        for movie in self.movies {
            
            var statusGenre = false
            if (self.filter.genre?.count)! > 0 {
                // Filter genre
                for genre in self.filter.genre! {
                    if (movie.genre?.contains(genre))! {
                        statusGenre = true
                    }
                }
            }else{
                statusGenre = true
            }
            
            var statusYear = false
            if (self.filter.year?.count)! > 0 {
                // Filter year
                for year in self.filter.year! {
                    if (movie.year?.contains(year))! {
                        statusYear = true
                    }
                }
            }else{
                statusYear = true
            }
            
            if statusYear && statusGenre {
                self.moviesVisible.append(movie)
            }
        }
        
    }
    
}
