//
//  FavoriteMoviesControllerViewModel.swift
//  Movs
//
//  Created by Gabriel D'Luca on 10/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import Foundation

class FavoriteMoviesControllerViewModel {
    
    // MARK: - Dependencies
    
    typealias Dependencies = HasAPIManager & HasStorageManager
    internal let dependencies: Dependencies
    internal let apiManager: MoviesAPIManager
    internal let storageManager: StorageManager
    
    // MARK: - Initializers and Deinitializers
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        self.storageManager = dependencies.storageManager
        self.apiManager = dependencies.apiManager
    }
    
    func cellViewModelForItemAt(indexPath: IndexPath) -> MovieViewModel {
        let favoriteMovie = Array(self.storageManager.favorites)[indexPath.row]
        let movie = Movie(favoriteMovie: favoriteMovie, genres: self.apiManager.genres)
        return MovieViewModel(movie: movie, dependencies: self.dependencies)
    }
    
    func removeItemAt(indexPath: IndexPath) {
        let favoriteMovie = Array(self.storageManager.favorites)[indexPath.row]
        self.storageManager.removeFavorite(movieID: favoriteMovie.id)
    }
}
