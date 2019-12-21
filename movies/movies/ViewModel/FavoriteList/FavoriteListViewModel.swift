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

    var filters = CurrentValueSubject<[Filter], Never>([])
    
    // Cancellables
    var querySubscriber: AnyCancellable?
    var favoriteMoviesSubscriber: AnyCancellable?
    var filtersSubscriber: AnyCancellable?
    
    // Data provider
    let dataProvider: DataProvidable
    
    init(dataProvider: DataProvidable) {
        self.dataProvider = dataProvider
        
        subscribeToFilters()
        self.subscribeToFavoriteMovies(dataProvider.favoriteMoviesPublisher.eraseToAnyPublisher())
    }
    
    // MARK: - Subscribers
    
    public func bindQuery(_ query: AnyPublisher<String?, Never>) {
        querySubscriber = query // Listen to changes in query and search movie
            .throttle(for: 1.0, scheduler: RunLoop.main, latest: false)
            .removeDuplicates()
            .sink(receiveValue: { [weak self] query in
                self?.query = query
                
                guard let favoriteMovies = self?.dataProvider.favoriteMovies else { return }
                self?.setMoviesList(favoriteMovies)
            })
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
                    self?.setMoviesList(movies)
                    self?.setFilters(for: movies)
                }
            })
    }
    
    private func subscribeToFilters() {
        filtersSubscriber = self.filters
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                guard let favoriteMovies = self?.dataProvider.favoriteMovies else { return }
                
                self?.setMoviesList(favoriteMovies)
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
    public func searchMovie(_ movies: [Movie], query: String?) -> [Movie] {
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
    
    private func setMoviesList(_ movies: [Movie]) {
        let filteredMovies = self.filterArray(movies, with: self.filters.value)
        let searchedMovies = self.searchMovie(filteredMovies, query: self.query)
        let sortedMovies = self.sortMovies(searchedMovies)
        
        self.searchMovies = sortedMovies
    }
}

// MARK: - Filter functions
extension FavoriteListViewModel {
    private func setFilters(for movies: [Movie]) {
        let dateOptions = getAllDates(from: movies)
        let genreOptions = getAllGenres(from: movies, genresDictionary: self.dataProvider.genres)
        
        let filters: [Filter] = [
            ReleaseDateFilter(withOptions: dateOptions),
            GenreFilter(withOptions: genreOptions, dict: self.dataProvider.genres)
        ]
        
        self.filters.send(filters)
    }
    
    func isFiltering(_ filters: [Filter]) -> Bool {
        return filters.filter { $0.selected.value.isEmpty == false }.isEmpty == false
    }
    
    func removeFilter() {
        _ = self.filters.value.map { $0.selected.send([]) }
        self.filters.send(self.filters.value)
    }
    
    /// Returns all dates from favorite movies
    public func getAllDates(from movies: [Movie]) -> [String] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy" // Format using year
        
        // Map all movies with their release dates formatted
        let dates = movies.map { movie -> String in
            guard let releaseDate = movie.releaseDate else { return "Upcoming" }
            return dateFormatter.string(from: releaseDate)
        }
        
        return cleanArray(dates) // Return sorted array without nil and duplicate values
    }
    
    public func getAllGenres(from movies: [Movie], genresDictionary: [Int: String]) -> [String] {
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
        let regex = "^\(query.lowercased())(\\s?\\w*)*" // Create regular expression to catch only strings starting with query text
        
        return array.filter { $0.title.lowercased().range(of: regex, options: .regularExpression) != nil } // Filter movies with title starting with query text
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
