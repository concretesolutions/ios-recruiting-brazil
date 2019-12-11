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
    
    typealias Dependencies = HasAPIManager & HasCoreDataManager
    internal let dependencies: Dependencies
    internal let apiManager: MoviesAPIManager
    internal let coreDataManager: CoreDataManager
    
    // MARK: - Initializers and Deinitializers
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        self.coreDataManager = dependencies.coreDataManager
        self.apiManager = dependencies.apiManager
    }
    
    func cellViewModelForItemAt(indexPath: IndexPath) -> MovieViewModel {
        let favoriteMovie = Array(self.coreDataManager.favorites)[indexPath.row]
        let movie = Movie(favoriteMovie: favoriteMovie, genres: self.apiManager.genres)
        return MovieViewModel(movie: movie, dependencies: self.dependencies)
    }
    
    func removeItemAt(indexPath: IndexPath) {
        let favoriteMovie = Array(self.coreDataManager.favorites)[indexPath.row]
        self.coreDataManager.removeFavorite(movieID: favoriteMovie.id)
    }
}
