//
//  MovieListViewModel.swift
//  movies
//
//  Created by Jacqueline Alves on 01/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import Foundation

class MovieListViewModel: ObservableObject {
    private var movies: [Movie] = [] {
        didSet {
            self.movieCount = self.movies.count
        }
    }
    
    @Published var movieCount: Int = 0
    
    init() {
        fetchMovies()
    }
    
    public func fetchMovies() {
        DataProvider.shared.fetchMovies { movies in
            self.movies.append(contentsOf: movies)
        }
    }
    
    public func viewModelForMovie(at index: Int) -> MovieCellViewModel? {
        guard index < self.movieCount else { return nil } // Check if it is an valid index
        return MovieCellViewModel(of: self.movies[index])
    }
    
    public func viewModelForMovieDetails(at index: Int) -> MovieDetailsViewModel? {
        guard index < self.movieCount else { return nil } // Check if it is an valid index
        return MovieDetailsViewModel(of: self.movies[index])
    }
    
    public func toggleFavoriteMovie(at index: Int) {
        guard index < self.movieCount else { return } // Check if it is an valid index
        UserDefaults.standard.toggleFavorite(withId: self.movies[index].id)
    }
}
