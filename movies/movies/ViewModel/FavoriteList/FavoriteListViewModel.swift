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
    
    private var searchMovies: [Movie] = [] {
        willSet {
            // Update movie count when search movies is updated
            self.movieCount = newValue.count
        }
    }
    
    private var searching: Bool = false {
        willSet {
            // Set searchMovies to show all movies when stop searching
            self.searchMovies = self.dataProvider.favoriteMovies
        }
    }
    
    // Publishers
    @Published private(set) var movieCount: Int = 0
    @Published private(set) var state: MovieListViewState = .movies
    
    // Cancellables
    var querySubscriber: AnyCancellable?
    var favoriteMoviesSubscriber: AnyCancellable?
    
    // Data provider
    let dataProvider: DataProvidable
    
    init(dataProvider: DataProvidable) {
        self.dataProvider = dataProvider
        
        self.subscribeToFavoriteMovies(dataProvider.favoriteMoviesPublisher.eraseToAnyPublisher())
    }
    
    // MARK: - Subscribers
    
    public func bindQuery(_ query: AnyPublisher<String?, Never>) {
        querySubscriber = query // Listen to changes in query and search movie
            .throttle(for: 1.0, scheduler: RunLoop.main, latest: false)
            .removeDuplicates()
            .sink { [weak self] queryString in
                self?.searchMovie(query: queryString)
        }
    }
    
    /// Subscribe to list of favorite movies from the data provider
    private func subscribeToFavoriteMovies(_ publisher: AnyPublisher<([Movie], Error?), Never>) {
        self.state = .loading
        favoriteMoviesSubscriber = publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] (movies, error) in
                if error != nil {
                    self?.searchMovies = []
                    self?.state = .error
                } else {
                    guard self?.searching == false else { return }
                    self?.searchMovies = movies
                    self?.state = .movies
                }
            })
    }
    
    // MARK: - Data convertion
    
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
        dataProvider.toggleFavorite(withId: self.searchMovies[index].id)
    }
    
    // MARK: - Search
    public func refreshMovies(completion: @escaping () -> Void) {
        // TODO: Get from any data provider
        DataProvider.shared.fetchFavorites(withIDs: UserDefaults.standard.favorites, completion: completion)
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
        self.searchMovies = self.filterArray(self.dataProvider.favoriteMovies, with: query) // Filter search list with text in query
        
        if searchMovies.isEmpty { // Check if found any movies with the given name
            self.state = .noDataError
        } else {
            self.state = .movies
        }
    }
    
    internal func filterArray(_ array: [Movie], with query: String) -> [Movie] {
        let regex = "^\(query.lowercased())(\\s?\\w*)*" // Create regular expression to catch only strings starting with query text
        
        return array.filter { $0.title.lowercased().range(of: regex, options: .regularExpression) != nil } // Filter movies with title starting with query text
    }
}
