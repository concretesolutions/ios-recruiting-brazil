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
    
    private func fetchMovies() {
        self.movies = MockedDataProvider.shared.popularMovies
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
        self.movies[index].favorite.toggle()
    }
}
