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
        didSet {
            self.movieCount = self.movies.count
        }
    }
    
    private var searchMovies: [Movie] = [] {
        didSet {
            self.movieCount = self.searchMovies.count
        }
    }
    
    @Published private(set) var movieCount: Int = 0
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
    
    private func fetchMovies() {
        _ = DataProvider.shared.$favoriteMovies
            .receive(on: DispatchQueue.main)
            .sink { [weak self] movies in
                self?.movies = movies
        }
    }
    
    public func viewModelForMovie(at index: Int) -> FavoriteMovieCellViewModel? {
        guard index < self.movieCount else { return nil } // Check if it is an valid index
        return FavoriteMovieCellViewModel(of: self.searchMovies[index])
    }
    
    public func viewModelForMovieDetails(at index: Int) -> MovieDetailsViewModel? {
        guard index < self.movieCount else { return nil } // Check if it is an valid index
        return MovieDetailsViewModel(of: self.searchMovies[index])
    }
    
    public func toggleFavoriteMovie(at index: Int) {
        guard index < self.movieCount else { return } // Check if it is an valid index
        UserDefaults.standard.toggleFavorite(withId: self.searchMovies[index].id)
        self.movies.remove(at: index)
    }
    
    public func searchMovie(query: String?) {
        guard let query = query, !query.isEmpty else { // Check if there is a valid text on the query
            self.searchMovies = self.movies // If don't, show all movies
            self.state = .movies
            return
        }
        
        self.state = .loading
        self.searchMovies = self.movies.filter { $0.title.lowercased().contains(query.lowercased()) }
        if searchMovies.isEmpty {
            self.state = .noDataError
        } else {
            self.state = .movies
        }
    }
}
