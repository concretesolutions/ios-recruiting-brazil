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
    case filter
}

class MovieListViewModel: ObservableObject {
    
    private var searchMovies: [Movie] = [] {
        willSet {
            // Update movie count when search movies is updated
            self.movieCount = newValue.count
        }
    }
    
    private var searching: Bool = false {
        willSet {
            if newValue == false {
                // Set searchMovies to show all movies when stop searching
                self.searchMovies = self.dataProvider.popularMovies
            }
        }
    }
    
    private var page: Int = 0
    
    // Publishers
    @Published private(set) var movieCount: Int = 0
    @Published private(set) var state: MovieListViewState = .movies
    
    // Cancellables
    var querySubscriber: AnyCancellable?
    var popularMoviesSubscriber: AnyCancellable?
    
    // Data provider
    let dataProvider: DataProvidable
       
    init(dataProvider: DataProvidable) {
        self.dataProvider = dataProvider
        
        self.subscribeToPopularMovies(dataProvider.popularMoviesPublisher.eraseToAnyPublisher())
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
    
    public func subscribeToPopularMovies(_ publisher: AnyPublisher<([Movie], Error?), Never>) {
        self.state = .loading
        self.popularMoviesSubscriber = publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] (movies, error) in
                if error != nil {
                    self?.searchMovies = []
                    self?.state = .error
                } else {
                    self?.page += 1
                    guard self?.searching == false else { return }
                    self?.searchMovies.append(contentsOf: movies)
                    self?.state = .movies
                }
            })
    }
    
    // MARK: - Data convertion
    
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
    
    // MARK: - Search
    
    public func fetchNextPage() {
        // TODO: Get from data provider
        DataProvider.shared.fetchMovies(page: self.page)
    }
    
    public func refreshMovies(completion: @escaping () -> Void) {
        self.page = 1
        self.searchMovies = []
        // TODO: Get from data provider
        DataProvider.shared.fetchMovies(page: self.page, completion: completion)
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
