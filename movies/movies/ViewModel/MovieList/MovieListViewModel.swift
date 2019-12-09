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
    private var movies: [Movie] = []
    
    private var searchMovies: [Movie] = [] {
        didSet {
            self.movieCount = self.searchMovies.count
        }
    }
    
    @Published private(set) var movieCount: Int = 0
    private var searching: Bool = false
    @Published private(set) var state: MovieListViewState = .movies
    
    init(query: AnyPublisher<String?, Never>) {
        fetchMovies()
        
        _ = query // Listen to changes in query and search movie
            .throttle(for: 1.0, scheduler: RunLoop.main, latest: false)
            .removeDuplicates()
            .sink { [weak self] queryString in
                self?.searchMovie(query: queryString)
            }
    }
    
    public func fetchMovies() {
        self.state = .loading
        if searching == false {
            DataProvider.shared.fetchMovies { movies in
                self.movies.append(contentsOf: movies)
                self.searchMovies = self.movies
                self.state = .movies
            }
        }
    }
    
    public func viewModelForMovie(at index: Int) -> MovieCellViewModel? {
        guard index < self.movieCount else { return nil } // Check if it is an valid index
        return MovieCellViewModel(of: self.searchMovies[index])
    }
    
    public func viewModelForMovieDetails(at index: Int) -> MovieDetailsViewModel? {
        guard index < self.movieCount else { return nil } // Check if it is an valid index
        return MovieDetailsViewModel(of: self.searchMovies[index])
    }
    
    public func toggleFavoriteMovie(at index: Int) {
        guard index < self.movieCount else { return } // Check if it is an valid index
        UserDefaults.standard.toggleFavorite(withId: self.searchMovies[index].id)
    }
    
    public func searchMovie(query: String?) {
        guard let query = query, !query.isEmpty else { // Check if there is a valid text on the query
            self.searchMovies = self.movies // If don't, show all movies
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
