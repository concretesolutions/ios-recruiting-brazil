//
//  FavoriteListViewModel.swift
//  movies
//
//  Created by Jacqueline Alves on 02/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import Foundation

class FavoriteListViewModel: ObservableObject {
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
        self.movies = MockedDataProvider.shared.favoriteMovies
    }
    
    public func viewModelForMovie(at index: Int) -> FavoriteMovieCellViewModel? {
        guard index < self.movieCount else { return nil } // Check if it is an valid index
        return FavoriteMovieCellViewModel(of: self.movies[index])
    }
    
    public func viewModelForMovieDetails(at index: Int) -> MovieDetailsViewModel? {
        guard index < self.movieCount else { return nil } // Check if it is an valid index
        return MovieDetailsViewModel(of: self.movies[index])
    }
    
    public func toggleFavoriteMovie(at index: Int) {
        guard index < self.movieCount else { return } // Check if it is an valid index
        self.movies[index].favorite.toggle()
        self.movies.remove(at: index)
    }
}
