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
    
    // MARK: - Data Source
    
    private var dataSource: [MovieDTO] {
        didSet {
            self.numberOfMovies = self.dataSource.count
        }
    }
    
    // MARK: - Dependencies
    
    typealias Dependencies = HasAPIManager & HasStorageManager
    private let dependencies: Dependencies
    internal let apiManager: MoviesAPIManager
    internal let storageManager: StorageManager
    
    // MARK: - Properties

    internal let decoder = JSONDecoder()
    internal var isSearchInProgress: Bool = false
    weak var coordinatorDelegate: PopularMoviesCoordinator?
    
    // MARK: - Publishers and Subscribers
    
    @Published var numberOfMovies: Int = 0
    private var subscribers: [AnyCancellable?] = []
        
    // MARK: - Initializers and Deinitializers
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        self.storageManager = dependencies.storageManager
        self.apiManager = dependencies.apiManager

        self.dataSource = self.apiManager.movies
        self.bind(to: dependencies.apiManager)
    }
    
    deinit {
        for subscriber in self.subscribers {
            subscriber?.cancel()
        }
    }
    
    // MARK: - Binding
    
    func bind(to apiManager: MoviesAPIManager) {
        self.subscribers.append(apiManager.$movies
            .sink(receiveValue: { fetchedMovies in
                self.dataSource = fetchedMovies
            })
        )
    }
    
    // MARK: - UICollectionView
    
    func cellViewModelForItemAt(indexPath: IndexPath) -> MovieViewModel {
        let movie = Movie(movieDTO: self.dataSource[indexPath.row], genres: self.apiManager.genres)
        return MovieViewModel(movie: movie, dependencies: self.dependencies)
    }
    
    func didSelectItemAt(indexPath: IndexPath) {
        let movie = Movie(movieDTO: self.dataSource[indexPath.row], genres: self.apiManager.genres)
        self.coordinatorDelegate?.didSelectItem(movie: movie)
    }
    
    // MARK: - UISearchController
    
    func filterMovies(for title: String) {
        if title.isEmpty {
            self.dataSource = self.apiManager.movies
            self.isSearchInProgress = false
        } else {
            self.dataSource = self.apiManager.movies.filter({ $0.title.starts(with: title) })
            self.isSearchInProgress = true
        }
    }
}
