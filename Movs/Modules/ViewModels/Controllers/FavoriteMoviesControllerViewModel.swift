//
//  FavoriteMoviesControllerViewModel.swift
//  Movs
//
//  Created by Gabriel D'Luca on 10/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import Foundation
import Combine

class FavoriteMoviesControllerViewModel {
    
    // MARK: - Data Source
    
    private var dataSource: [Movie] = [] {
        willSet {
            if newValue.isEmpty, self.currentSearch != nil {
                self.hasSearchResults = false
            } else {
                self.hasSearchResults = true
            }
        }
        didSet {
            self.dataSource.sort(by: { $0.title < $1.title })
            self.numberOfFavoriteMovies = self.dataSource.count
        }
    }
        
    // MARK: - Dependencies
    
    typealias Dependencies = HasStorageManager
    private let dependencies: Dependencies
    private let storageManager: StorageManager
    
    // MARK: - Filters
    
    typealias Filters = HasGenreFilter & HasYearFilter
    
    // MARK: - Properties
    
    unowned var modalPresenter: ModalPresenterDelegate!
    internal var deletedIndex: IndexPath?
    internal var searchStatus: SearchStatus = .none
    internal var currentFilters: Filters?
    internal var currentSearch: String?
    
    // MARK: - Publishers and Subscribers
    
    @Published var numberOfFavoriteMovies: Int = 0
    @Published var hasSearchResults: Bool = true
    private var subscribers: [AnyCancellable?] = []
    
    // MARK: - Initializers and Deinitializers
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        self.storageManager = dependencies.storageManager
        self.dataSource = self.storageManager.favorites.map({ Movie(favoriteMovie: $0, genres: self.storageManager.genres) })

        self.bind(to: self.storageManager)
    }
    
    deinit {
        for subscriber in self.subscribers {
            subscriber?.cancel()
        }
    }
    
    // MARK: - Methods
    
    func updateDataSource(with movies: [Movie]) {
        switch self.searchStatus {
        case .searching:
            guard let searchText = self.currentSearch else { return }
            self.dataSource = self.search(movies: movies, with: searchText)
        case .filtering:
            guard let filters = self.currentFilters else { return }
            self.dataSource = self.filter(movies: movies, with: filters)
        case .searchingAndFiltering:
            guard let searchText = self.currentSearch, let filters = self.currentFilters else { return }
            self.dataSource = self.search(movies: movies, with: searchText)
            self.dataSource = self.filter(movies: movies, with: filters)
        default:
            self.dataSource = movies
        }
    }
    
    // MARK: - Binding
    
    func bind(to storageManager: StorageManager) {
        self.subscribers.append(storageManager.$favorites
            .sink(receiveValue: { storedFavorites in
                if let index = self.deletedIndex {
                    self.dataSource.remove(at: index.row)
                } else {
                    let favorites = storedFavorites.map({ Movie(favoriteMovie: $0, genres: self.storageManager.genres) })
                    self.updateDataSource(with: favorites)
                }
            })
        )
    }
}

// MARK: - UITableView

extension FavoriteMoviesControllerViewModel {
    func cellViewModelForItemAt(indexPath: IndexPath) -> MovieViewModel {
        let movie = self.dataSource[indexPath.row]
        return MovieViewModel(movie: movie, dependencies: self.dependencies)
    }
    
    func didSelectItemAt(indexPath: IndexPath) {
        let movie = self.dataSource[indexPath.row]
        if let showDetails = self.modalPresenter.showMovieDetails {
            showDetails(movie)
        }
    }
    
    func removeItemAt(indexPath: IndexPath) {
        self.deletedIndex = indexPath
        let movie = self.dataSource[indexPath.row]
        self.storageManager.deleteFavorite(movieID: movie.id)
    }
}

// MARK: - UISearchController

extension FavoriteMoviesControllerViewModel {
    func applySearch(searchText: String) {
        switch self.searchStatus {
        case .filtering, .searchingAndFiltering:
            self.searchStatus = .searchingAndFiltering
        default:
            self.searchStatus = .searching
        }
        
        let storedMovies = self.storageManager.favorites.map({ Movie(favoriteMovie: $0, genres: self.storageManager.genres) })
        self.dataSource = self.search(movies: storedMovies, with: searchText)
        
        if let filters = self.currentFilters {
            self.dataSource = self.filter(movies: self.dataSource, with: filters)
        }
    }
    
    func search(movies: [Movie], with searchText: String) -> [Movie] {
        self.currentSearch = searchText == "" ? nil : searchText
        if let currentText = self.currentSearch {
            return movies.filter({ $0.title.starts(with: currentText.capitalized) })
        } else {
            return movies
        }
    }
    
    func resetSearch() {
        let storedMovies = self.storageManager.favorites.map({ Movie(favoriteMovie: $0, genres: self.storageManager.genres) })
        self.currentSearch = nil
        
        switch self.searchStatus {
        case .filtering, .searchingAndFiltering:
            guard let filters = self.currentFilters else { return }
            self.searchStatus = .filtering
            self.dataSource = self.filter(movies: storedMovies, with: filters)
        default:
            self.searchStatus = .none
            self.dataSource = storedMovies
        }
    }
}

// MARK: - Filters

extension FavoriteMoviesControllerViewModel {
    func applyFilter(_ filters: Filters) {
        let storedMovies = self.storageManager.favorites.map({ Movie(favoriteMovie: $0, genres: self.storageManager.genres) })
        
        if filters.genresNames == nil && filters.year == nil {
            self.resetFilters(for: storedMovies)
        } else {
            self.searchStatus = .filtering
            self.dataSource = self.filter(movies: storedMovies, with: filters)
        }
    }
        
    func filter(movies: [Movie], with filters: Filters) -> [Movie] {
        self.currentFilters = filters
        return movies
            .filter({ // Filtering by year
                guard filters.year != nil else { return true }
                guard let movieRelease = $0.releaseDate else { return false }
                let movieYear = Calendar.current.component(.year, from: movieRelease)
                
                if filters.year == 1970 {
                    return movieYear <= filters.year
                } else {
                    return movieYear == filters.year
                }
            })
            .filter({ // Filtering by genres
                guard filters.genresNames != nil else { return true }
                
                let movieGenres = $0.genres.map({ $0.name })
                return movieGenres.contains(where: filters.genresNames.contains)
            })
    }
    
    func resetFilters(for movies: [Movie]) {
        self.searchStatus = .none
        self.currentFilters = nil
        self.dataSource = movies
    }
}
