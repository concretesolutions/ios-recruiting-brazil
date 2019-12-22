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
    private var querySubscriber: AnyCancellable?
    private var popularMoviesSubscriber: AnyCancellable?
    
    // Data provider
    private let dataProvider: DataProvidable
       
    init(dataProvider: DataProvidable) {
        self.dataProvider = dataProvider
        
        self.subscribeToPopularMovies(dataProvider.popularMoviesPublisher.eraseToAnyPublisher())
    }
    
    // MARK: - Subscribers
    
    public func bindQuery(_ query: AnyPublisher<String?, Never>) {
        self.querySubscriber = query // Listen to changes in query and search movie
            .throttle(for: 1.0, scheduler: RunLoop.main, latest: false)
            .removeDuplicates()
            .sink { [weak self] queryString in
                self?.searchMovie(query: queryString, completion: { (movies, state) in
                    self?.state = state
                    self?.searchMovies = movies
                })
            }
    }
    
    private func subscribeToPopularMovies(_ publisher: AnyPublisher<([Movie], Error?), Never>) {
        self.state = .loading
        self.popularMoviesSubscriber = publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] (movies, error) in
                if error != nil {
                    self?.searchMovies = []
                    self?.state = .error
                } else {
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
    
    // MARK: - Movie List
    
    public func fetchNextPage() {
        self.page += 1
        self.dataProvider.fetchPopularMovies(page: self.page, completion: nil)
    }
    
    public func refreshMovies(completion: @escaping () -> Void) {
        self.page = 1
        self.searchMovies = []
        self.dataProvider.fetchPopularMovies(page: self.page, completion: completion)
        if self.dataProvider.genres.isEmpty {
            MovieService.fetchGenres()
        }
    }
    
    /// Search movies according to their names using the given query
    /// - Parameter query: Name of the movie being searched
    private func searchMovie(query: String?, completion: @escaping ([Movie], MovieListViewState) -> Void) {
        guard let query = query, !query.isEmpty else { // Check if there is a valid text on the query
            self.searching = false
            self.state = .movies
            return
        }
        
        self.searching = true
        self.state = .loading
        self.dataProvider.searchMovie(query: query) { result in
            switch result {
            case .failure(let error):
                if let error = error as? MovieError, error == .noData {
                    completion([], .noDataError)
                } else {
                    completion([], .error)
                }
            case .success(let movies):
                completion(movies, .movies)
            }
        }
    }
}
