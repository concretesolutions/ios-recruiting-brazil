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
    
    private var dataSource: [CDFavoriteMovie] {
        didSet {
            self.numberOfFavoriteMovies = self.dataSource.count
        }
    }
    
    // MARK: - Dependencies
    
    typealias Dependencies = HasAPIManager & HasStorageManager
    internal let dependencies: Dependencies
    internal let apiManager: MoviesAPIManager
    internal let storageManager: StorageManager
    
    // MARK: - Properties
    
    internal var isSearchInProgress: Bool = false
    
    // MARK: - Publishers and Subscribers
    
    @Published var numberOfFavoriteMovies: Int
    private var subscribers: [AnyCancellable?] = []
    
    // MARK: - Initializers and Deinitializers
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        self.storageManager = dependencies.storageManager
        self.apiManager = dependencies.apiManager
        
        self.dataSource = Array(self.storageManager.favorites)
        self.numberOfFavoriteMovies = self.storageManager.favorites.count
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
            .sink(receiveValue: { value in
                if !self.isSearchInProgress {
                    self.dataSource = Array(value)
                }
            })
        )
    }
    
    // MARK: - UITableView
    
    func cellViewModelForItemAt(indexPath: IndexPath) -> MovieViewModel {
        let favoriteMovie = self.dataSource[indexPath.row]
        let movie = Movie(favoriteMovie: favoriteMovie, genres: self.apiManager.genres)
        return MovieViewModel(movie: movie, dependencies: self.dependencies)
    }
    
    func removeItemAt(indexPath: IndexPath) {
        let favoriteMovie = self.dataSource[indexPath.row]
        self.storageManager.removeFavorite(movieID: favoriteMovie.id)
        if self.isSearchInProgress {
            self.dataSource.remove(at: indexPath.row)
        }
    }
    
    // MARK: - UISearchController
    
    func filterMovies(for title: String) {
        if title.isEmpty {
            self.dataSource = Array(self.storageManager.favorites)
            self.isSearchInProgress = false
        } else {
            self.dataSource = self.storageManager.favorites.filter({ $0.title!.starts(with: title) })
            self.isSearchInProgress = true
        }
    }
}
