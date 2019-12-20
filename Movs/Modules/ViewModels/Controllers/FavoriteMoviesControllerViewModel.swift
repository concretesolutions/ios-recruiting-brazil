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
                self.searchStatus = .noResults
            }
        }
        didSet {
            self.numberOfFavoriteMovies = self.dataSource.count
        }
    }
    
    // MARK: - Dependencies
    
    typealias Dependencies = HasStorageManager
    private let dependencies: Dependencies
    private let storageManager: StorageManager
    
    // MARK: - Properties
    
    weak var detailsPresenter: FavoriteMoviesCoordinator?
    internal var deletedIndex: IndexPath?
    internal var currentSearch: String?
    
    // MARK: - Publishers and Subscribers
    
    @Published var numberOfFavoriteMovies: Int = 0
    @Published var searchStatus: SearchStatus = .none
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
    
    // MARK: - Binding
    
    func bind(to storageManager: StorageManager) {
        self.subscribers.append(storageManager.$favorites
            .sink(receiveValue: { storedFavorites in
                let favorites = storedFavorites.map({ Movie(favoriteMovie: $0, genres: self.storageManager.genres) })
                
                if let index = self.deletedIndex {
                    self.dataSource.remove(at: index.row)
                } else if self.searchStatus == .none {
                    self.dataSource = favorites
                } else if [.search, .searchAndFilter].contains(self.searchStatus), let text = self.currentSearch {
                    self.filterMovies(favorites, searchText: text)
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
        self.detailsPresenter?.showDetails(movie: movie)
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
        let storedMovies = self.storageManager.favorites.map({ Movie(favoriteMovie: $0, genres: self.storageManager.genres) })
        
        if searchText.isEmpty {
            self.resetSearch(with: storedMovies)
        } else {
            self.currentSearch = searchText
            self.filterMovies(storedMovies, searchText: searchText)
        }
    }
    
    func filterMovies(_ movies: [Movie], searchText: String) {
        self.searchStatus = self.searchStatus == .filter ? .searchAndFilter : .search
        self.dataSource = movies.filter({ $0.title.starts(with: searchText.capitalized) })
    }
    
    func resetSearch(with movies: [Movie]) {
        self.dataSource = movies
        self.currentSearch = nil
        self.searchStatus = .none
    }
}
