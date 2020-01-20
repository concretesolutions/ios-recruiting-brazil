//
//  MovieViewModel.swift
//  TheMovieDB
//
//  Created by Renato Lopes on 11/01/20.
//  Copyright © 2020 renato. All rights reserved.
//

import Foundation
import UIKit
import Combine

class MovieViewModel {
    public static let shared = MovieViewModel.init()
    
    public var movies: [Movie] = [] {
        didSet {
            NotificationCenter.default.post(name: .updatedMovies, object: nil)
        }
    }
    
    public var filteredMovies: [Movie] = []
    
    public var selectedMovie: Movie?
    
    public var movieService = MovieService.init()
    
    private init() {}
    
    public func selectMovie(index: Int, isFiltered: Bool = false) {
        guard index >= 0 else { return }
        if isFiltered {
            self.selectedMovie = filteredMovies[index]
        } else {
            self.selectedMovie = movies[index]
        }
    }
    
    public func favoriteMovie(at: Int) -> Movie? {
        guard at >= 0 else { return nil }
        return movies.filter({ $0.isFavorite })[at]
    }
    
    public func changeFavorite(at index: Int? = nil) {
        if let changeIndex = index {
            let movie = movies.filter({ $0.isFavorite })[changeIndex]
            movie.isFavorite = !movie.isFavorite
            movie.notification.send()
        } else {
            guard let movie = selectedMovie else { return }
            movie.isFavorite = !movie.isFavorite
            movie.notification.send()
        }
    }
    
    public func delete(at index: Int) {
        movies.remove(at: index)
    }
    
    public func filterMovies(withText text: String) {
        filteredMovies = movies.filter { (movie) -> Bool in
            return movie.title.lowercased().contains(text.lowercased())
        }
    }
    
    public func loadAllMovies() {
        movieService.fetchMovies { (movies, error) in
            if error != nil {
                NotificationCenter.default.post(name: .networkError,
                                                object: nil)
            } else {
                self.movies = movies
            }
        }
    }

}
