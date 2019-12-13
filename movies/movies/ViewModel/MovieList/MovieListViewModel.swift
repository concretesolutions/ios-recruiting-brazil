//
//  MovieListViewModel.swift
//  movies
//
//  Created by Jacqueline Alves on 01/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import Foundation
import Combine

enum MovieListViewState {
    case movies
    case noDataError
    case error
    case loading
}

class MovieListViewModel: ObservableObject {
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
    var popularMoviesSubscriber: AnyCancellable?
    
    init() {
        subscribeToPopularMovies()
    }
    
    public func bindQuery(_ query: AnyPublisher<String?, Never>) {
        querySubscriber = query // Listen to changes in query and search movie
            .throttle(for: 1.0, scheduler: RunLoop.main, latest: false)
            .removeDuplicates()
            .sink { [weak self] queryString in
                self?.searchMovie(query: queryString)
            }
    }
    
    public func subscribeToPopularMovies() {
        self.state = .loading
        popularMoviesSubscriber = DataProvider.shared.$popularMovies
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] movies in
                self?.movies.append(contentsOf: movies)
                self?.state = .movies
            })
    }
    
    /// Returns the cell view model for a movie at an index
    /// - Parameter index: Index of the movie
    public func viewModelForMovie(at index: Int) -> MovieCellViewModel? {
        guard index < self.movieCount else { return nil } // Check if it is an valid index
        return MovieCellViewModel(of: self.searchMovies[index])
    }
    
    /// Return the details view model for a movie at an index
    /// - Parameter index: Index of the movie
    public func viewModelForMovieDetails(at index: Int) -> MovieDetailsViewModel? {
        guard index < self.movieCount else { return nil } // Check if it is an valid index
        return MovieDetailsViewModel(of: self.searchMovies[index])
    }
    
    /// Search movies according to their names using the given query
    /// - Parameter query: Name of the movie being searched
    public func searchMovie(query: String?) {
        guard let query = query, !query.isEmpty else { // Check if there is a valid text on the query
            self.searching = false
            self.state = .movies
            return
        }
        
        self.searching = true
        self.state = .loading
        MovieService.searchMovie(query: query) { [weak self] result in
            switch result {
            case .failure(let error):
                if let error = error as? MovieError, error == .noData {
                    self?.state = .noDataError
                } else {
                    self?.state = .error
                }
                
                self?.searchMovies = []
            case .success(let movies):
                self?.state = .movies
                self?.searchMovies = Array(movies.prefix(12)) // Set movies array to the first five results
            }
        }
    }
}
