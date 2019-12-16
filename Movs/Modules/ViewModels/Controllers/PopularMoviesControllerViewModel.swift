//
//  PopularMoviesControllerViewModel.swift
//  Movs
//
//  Created by Gabriel D'Luca on 03/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import Foundation
import Combine

class PopularMoviesControllerViewModel {
    
    // MARK: - Dependencies
    
    typealias Dependencies = HasAPIManager & HasStorageManager
    private let dependencies: Dependencies
    internal let apiManager: MoviesAPIManager
    internal let storageManager: StorageManager
    
    // MARK: - Properties

    internal let decoder = JSONDecoder()
    internal var isMovieFetchInProgress: Bool = false
    weak var coordinatorDelegate: PopularMoviesCoordinator?
    
    // MARK: - Publishers and Subscribers
    
    @Published var numberOfMovies: Int = 0
    private var subscribers: [AnyCancellable?] = []
        
    // MARK: - Initializers and Deinitializers
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        self.storageManager = dependencies.storageManager
        self.apiManager = dependencies.apiManager
        
        self.bind(to: dependencies.apiManager)
    }
    
    deinit {
        for subscriber in self.subscribers {
            subscriber?.cancel()
        }
    }
    
    // MARK: - Binding
    
    func bind(to apiManager: MoviesAPIManager) {
        self.subscribers.append(self.apiManager.$movies.sink(receiveValue: { fetchedMovies in
            self.numberOfMovies = fetchedMovies.count
        }))
    }
    
    // MARK: - Methods
    
    func cellViewModelForItemAt(indexPath: IndexPath) -> MovieViewModel {
        let movie = Movie(movieDTO: self.apiManager.movies[indexPath.row], genres: self.apiManager.genres)
        return MovieViewModel(movie: movie, dependencies: self.dependencies)
    }
    
    func didSelectItemAt(indexPath: IndexPath) {
        let movie = Movie(movieDTO: self.apiManager.movies[indexPath.row], genres: self.apiManager.genres)
        self.coordinatorDelegate?.didSelectItem(movie: movie)
    }
}
