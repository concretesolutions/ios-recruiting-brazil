//
//  FavoriteListViewModel.swift
//  movies
//
//  Created by Jacqueline Alves on 02/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

// TODO: Remove or add favorite when filter is applied

import Foundation
import Combine

class FavoriteListViewModel: ObservableObject {
    
    private var searchMovies: [Movie] = [] {
        willSet {
            // Update movie count when search movies is updated
            self.movieCount = newValue.count
            // Check if list is empty
            if newValue.isEmpty && !self.dataProvider.favoriteMovies.isEmpty {
                self.state = .noDataError
            } else {
                self.state = self.isFiltering(self.filters.value) ? .filter : .movies
            }
        }
    }
    
    private var searching: Bool = false
    
    // Publishers
    @Published private(set) var movieCount: Int = 0
    @Published private(set) var state: MovieListViewState = .movies
    @Published private var query: String?

    private var filters = CurrentValueSubject<[Filter], Never>([])
    
    // Cancellables
    private var querySubscriber: AnyCancellable?
    private var favoriteMoviesSubscriber: AnyCancellable?
    private var filtersSubscriber: AnyCancellable?
    
    // Data provider
    private let dataProvider: DataProvidable
    
    init(dataProvider: DataProvidable) {
        self.dataProvider = dataProvider
        
        self.subscribeToFilters(self.filters.eraseToAnyPublisher())
        self.subscribeToFavoriteMovies(dataProvider.favoriteMoviesPublisher.eraseToAnyPublisher())
    }
    
    // MARK: - Subscribers
    
    /// Bind a string publisher responsible for searching from movies
    /// - Parameter query: String publisher
    public func bindQuery(_ query: AnyPublisher<String?, Never>) {
        self.querySubscriber = query // Listen to changes in query and search movie
            .throttle(for: 1.0, scheduler: RunLoop.main, latest: false)
            .removeDuplicates()
            .sink(receiveValue: { [weak self] query in
                self?.query = query
                
                guard let favoriteMovies = self?.dataProvider.favoriteMovies, let filters = self?.filters.value else { return }
                guard let movieList = self?.getMoviesList(favoriteMovies, withFilters: filters, andQuery: query) else { return }
                
                self?.searchMovies = movieList
            })
    }
    
    private func subscribeToFavoriteMovies(_ publisher: AnyPublisher<([Movie], Error?), Never>) {
        self.state = .loading
        self.favoriteMoviesSubscriber = publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] (movies, error) in
                if error != nil {
                    self?.searchMovies = []
                    self?.state = .error
                } else {
                    guard let filters = self?.filters.value else { return }
                    guard let movieList = self?.getMoviesList(movies, withFilters: filters, andQuery: self?.query) else { return }
                    
                    self?.searchMovies = movieList
                    
                    guard let newFilters = self?.getFilters(for: movies) else { return }
                    self?.filters.send(newFilters)
                }
            })
    }
    
    private func subscribeToFilters(_ publisher: AnyPublisher<[Filter], Never>) {
        self.filtersSubscriber = publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] filters in
                guard let favoriteMovies = self?.dataProvider.favoriteMovies else { return }
                guard let movieList = self?.getMoviesList(favoriteMovies, withFilters: filters, andQuery: self?.query) else { return }
                
                self?.searchMovies = movieList
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
    
    /// Return a view model for the filters screen
    public func viewModelForFilters() -> FilterViewViewModel {
        return FilterViewViewModel(filterSubject: self.filters)
    }
    
    /// Add movie id to favorite list if it is not there and removes it if it is
    /// - Parameter index: Index of the movie
    public func toggleFavoriteMovie(at index: Int) {
        guard index < self.movieCount else { return } // Check if it is an valid index
        self.dataProvider.toggleFavorite(withId: self.searchMovies[index].id)
    }

    // MARK: - Movie List
    
    public func refreshMovies(completion: @escaping () -> Void) {
        self.dataProvider.fetchFavoriteMovies(completion: completion)
        if self.dataProvider.genres.isEmpty {
            MovieService.fetchGenres()
        }
    }
    
    /// Filter movies according to their names using the given query
    /// - Parameter query: Name of the movie being searched
    private func searchMovie(_ movies: [Movie], query: String?) -> [Movie] {
        guard let query = query, !query.isEmpty else { // Check if there is a valid text on the query
            self.searching = false
            return movies
        }
        
        self.searching = true
        self.state = .loading
        return self.filterArray(movies, with: query) // Filter search list with text in query
    }
    
    /// Sort array of movies in alphabetical order
    /// - Parameter movies: Array of movies to be sorted
    private func sortMovies(_ movies: [Movie]) -> [Movie] {
        return movies.sorted { $0.title < $1.title }
    }
    
    /// Return sorted list of movies filtered by filters and query search
    /// - Parameters:
    ///   - movies: List of movies to convert
    ///   - filters: Applied filters
    ///   - query: Query to search on movie title
    private func getMoviesList(_ movies: [Movie], withFilters filters: [Filter], andQuery query: String?) -> [Movie] {
        let filteredMovies = self.filterArray(movies, with: filters)
        let searchedMovies = self.searchMovie(filteredMovies, query: query)
        let sortedMovies = self.sortMovies(searchedMovies)
        
        return sortedMovies
    }
}

// MARK: - Filter functions
extension FavoriteListViewModel {
    
    /// Get filters with the correct options according to the given list of movies
    /// - Parameter movies: List of movies to collect filter options
    private func getFilters(for movies: [Movie]) -> [Filter] {
        let dateOptions = getAllDates(from: movies)
        let genreOptions = getAllGenres(from: movies, genresDictionary: self.dataProvider.genres)
        
        let filters: [Filter] = [
            ReleaseDateFilter(withOptions: dateOptions),
            GenreFilter(withOptions: genreOptions, dict: self.dataProvider.genres)
        ]
        
        return filters
    }
    
    private func isFiltering(_ filters: [Filter]) -> Bool {
        return filters.filter { $0.selected.value.isEmpty == false }.isEmpty == false
    }
    
    public func removeFilter() {
        _ = self.filters.value.map { $0.selected.send([]) }
        self.filters.send(self.filters.value)
    }
    
    internal func getAllDates(from movies: [Movie]) -> [String] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy" // Format using year
        
        // Map all movies with their release dates formatted
        let dates = movies.map { movie -> String in
            guard let releaseDate = movie.releaseDate else { return "Upcoming" }
            return dateFormatter.string(from: releaseDate)
        }
        
        return cleanArray(dates) // Return sorted array without nil and duplicate values
    }
    
    internal func getAllGenres(from movies: [Movie], genresDictionary: [Int: String]) -> [String] {
        // Convert genre ids from all movies for a list with their names
        var genres = movies.flatMap { movie -> [String?] in
            guard let genreIds = movie.genreIds else { return [nil] } // Get genre ids from all movies
            return genreIds.map { (genresDictionary[$0] ?? "") } // Convert genre id for their names
        }
        genres = genres.filter { $0 != "" } // Remove empty strings
            
        return cleanArray(genres) // Return sorted array without nil and duplicate values
    }
    
    /// Remove all nil values, duplicates and sort given array
    /// - Parameter array: Array to be cleaned
    internal func cleanArray<T: Hashable & Comparable>(_ array: [T?]) -> [T] {
        let array: [T] = array.compactMap { $0 } // Remove all nil values
        let set = Set(array) // Remove duplicates
        let sorted = Array(set).sorted() // Sort array
        
        return sorted
    }
    
    /// Filter movies using a string of its title
    /// - Parameters:
    ///   - array: Array of movies do be filtered
    ///   - query: Title of the movie to filter
    internal func filterArray(_ array: [Movie], with query: String) -> [Movie] {
        return array.filter { $0.title.lowercased().contains(query.lowercased()) } // Filter movies with title starting with query text
    }
    
    /// Filter movies using custom filters
    /// - Parameters:
    ///   - array: Array of movies to be filtered
    ///   - filters: Array of custom filters
    internal func filterArray(_ array: [Movie], with filters: [Filter]) -> [Movie] {
        var filteredMovies = [Movie]()
        
        for filter in filters {
            let filtered = filter.filter(filteredMovies.isEmpty ? array : filteredMovies)
            filteredMovies = filtered
        }
        
        let filteredSet = Set(filteredMovies) // Remove duplicates
        
        return Array(filteredSet)
    }
}
