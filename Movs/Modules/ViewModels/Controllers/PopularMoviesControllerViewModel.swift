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
    
    private var dataSource: [Movie] = [] {
        willSet {
            if newValue.isEmpty, self.currentSearch != nil {
                self.searchStatus = .noResults
            }
        }
        didSet {
            self.numberOfPopularMovies = self.dataSource.count
        }
    }
    
    // MARK: - Dependencies
    
    typealias Dependencies = HasAPIManager & HasStorageManager
    private let dependencies: Dependencies
    private let apiManager: MoviesAPIManager
    private let storageManager: StorageManager
    
    // MARK: - Properties

    internal let decoder = JSONDecoder()
    internal var currentSearch: String?
    weak var detailsPresenter: PopularMoviesCoordinator?
    var shouldFetchGenres: Bool {
        return self.apiManager.shouldFetchGenres()
    }
    var shouldFetchNextPage: Bool {
        return self.apiManager.shouldFetchNextPage()
    }
    
    // MARK: - Publishers and Subscribers
    
    @Published var numberOfPopularMovies: Int = 0
    @Published var numberOfFavoriteMovies: Int = 0
    @Published var fetchStatus: MoviesAPIManager.FetchStatus = .none
    @Published var searchStatus: SearchStatus = .none
    private var subscribers: [AnyCancellable?] = []
        
    // MARK: - Initializers and Deinitializers
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        self.storageManager = dependencies.storageManager
        self.apiManager = dependencies.apiManager

        self.dataSource = self.apiManager.movies.map({ Movie(movieDTO: $0, genres: self.apiManager.genres) })
        self.bind(to: dependencies.apiManager)
        self.bind(to: dependencies.storageManager)
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
                self.dataSource = fetchedMovies.map({ Movie(movieDTO: $0, genres: apiManager.genres) })
            })
        )
        
        self.subscribers.append(apiManager.$fetchStatus
            .sink(receiveValue: { status in
                self.fetchStatus = status
            })
        )
    }
    
    func bind(to storageManager: StorageManager) {
        self.subscribers.append(storageManager.$favorites
            .receive(on: RunLoop.main)
            .sink(receiveValue: { storedFavorites in
                self.numberOfFavoriteMovies = storedFavorites.count
            })
        )
    }
}

// MARK: - MoviesAPIManager

extension PopularMoviesControllerViewModel {
    func fetchGenresList() {
        self.apiManager.fetchGenresList(completion: { completionStatus in
            if completionStatus == .none {
                self.apiManager.fetchNextPopularMoviesPage()
            }
        })
    }
    
    func fetchNextPopularMoviesPage() {
        self.apiManager.fetchNextPopularMoviesPage()
    }
}

// MARK: - UICollectionView

extension PopularMoviesControllerViewModel {
    func cellViewModelForItemAt(indexPath: IndexPath) -> MovieViewModel {
        let movie = self.dataSource[indexPath.row]        
        return MovieViewModel(movie: movie, dependencies: self.dependencies)
    }
    
    func didSelectItemAt(indexPath: IndexPath) {
        let movie = self.dataSource[indexPath.row]
        self.detailsPresenter?.showDetails(movie: movie)
    }
}

// MARK: - UISearchController

extension PopularMoviesControllerViewModel {
    func applySearch(searchText: String) {
        let fetchedMovies = self.apiManager.movies.map({ Movie(movieDTO: $0, genres: self.apiManager.genres) })
        
        if searchText.isEmpty {
            self.resetSearch(with: fetchedMovies)
        } else {
            self.currentSearch = searchText
            self.filterMovies(fetchedMovies, searchText: searchText)
        }
    }
    
    func filterMovies(_ movies: [Movie], searchText: String) {
        self.searchStatus = .search
        self.dataSource = movies.filter({ $0.title.starts(with: searchText.capitalized) })
    }
    
    func resetSearch(with movies: [Movie]) {
        self.dataSource = movies
        self.currentSearch = nil
        self.searchStatus = .none
    }
}
