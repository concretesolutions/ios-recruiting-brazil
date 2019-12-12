//
//  FavoriteListViewModel.swift
//  movies
//
//  Created by Jacqueline Alves on 02/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import Foundation
import Combine

class FavoriteListViewModel: ObservableObject {
    private var movies: [Movie] = [] {
        willSet {
            if self.searching == false {
                // Set searchMovies to show all movies if it not searching
                self.searchMovies = newValue
            }
        }
    }
    
    private var searchMovies: [Movie] = [] {
        willSet {
            // Update movie count when search movies is updated
            self.movieCount = newValue.count
        }
    }
    
    private var searching: Bool = false {
        willSet {
            // Set searchMovies to show all movies when stop searching
            self.searchMovies = self.movies
        }
    }
    
    // Publishers
    @Published private(set) var movieCount: Int = 0
    @Published private(set) var state: MovieListViewState = .movies
    
    // Cancellables
    var querySubscriber: AnyCancellable?
    var favoriteMoviesSubscriber: AnyCancellable?
    
    init() {
        subscribeToFavoriteMovies()
    }
    
    public func bindQuery(_ query: AnyPublisher<String?, Never>) {
        querySubscriber = query // Listen to changes in query and search movie
            .throttle(for: 1.0, scheduler: RunLoop.main, latest: false)
            .removeDuplicates()
            .sink { [weak self] queryString in
                self?.searchMovie(query: queryString)
            }
    }
    
    /// Subscribe to list of favorite movies from the data provider
    private func subscribeToFavoriteMovies() {
        self.state = .loading
        favoriteMoviesSubscriber = DataProvider.shared.$favoriteMovies
            .receive(on: DispatchQueue.main)
            .sink { [weak self] movies in
                self?.movies = movies
                self?.state = .movies
            }
    }
    
    /// Returns the cell view model for a movie at an index
    /// - Parameter index: Index of the movie
    public func viewModelForMovie(at index: Int) -> FavoriteMovieCellViewModel? {
        guard index < self.movieCount else { return nil } // Check if it is an valid index
        return FavoriteMovieCellViewModel(of: self.searchMovies[index])
    }
    
    /// Return the details view model for a movie at an index
    /// - Parameter index: Index of the movie
    public func viewModelForMovieDetails(at index: Int) -> MovieDetailsViewModel? {
        guard index < self.movieCount else { return nil } // Check if it is an valid index
        return MovieDetailsViewModel(of: self.searchMovies[index])
    }
    
    /// Add movie id to favorite list if it is not there and removes it if it is
    /// - Parameter index: Index of the movie
    public func toggleFavoriteMovie(at index: Int) {
        guard index < self.movieCount else { return } // Check if it is an valid index
        UserDefaults.standard.toggleFavorite(withId: self.searchMovies[index].id)
    }
    
    /// Filter movies according to their names using the given query
    /// - Parameter query: Name of the movie being searched
    public func searchMovie(query: String?) {
        guard let query = query, !query.isEmpty else { // Check if there is a valid text on the query
            self.searching = false
            self.state = .movies
            return
        }
        
        self.searching = true
        self.state = .loading
        self.searchMovies = self.movies.filter { $0.title.lowercased().contains(query.lowercased()) } // Filter search list with text in query
        
        if searchMovies.isEmpty { // Check if found any movies with the given name
            self.state = .noDataError
        } else {
            self.state = .movies
        }
    }
}
