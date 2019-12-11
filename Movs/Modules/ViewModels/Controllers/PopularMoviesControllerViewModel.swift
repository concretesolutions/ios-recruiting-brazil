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
    
    typealias Dependencies = HasAPIManager & HasCoreDataManager
    private let dependencies: Dependencies
    internal let apiManager: MoviesAPIManager
    internal let coreDataManager: CoreDataManager
    
    // MARK: - Properties

    internal let decoder = JSONDecoder()
    internal var isMovieFetchInProgress: Bool = false
    weak var coordinatorDelegate: PopularMoviesCoordinator?
    
    // MARK: - Publishers and Subscribers
    
    @Published var currentPage: Int = 0
    @Published var numberOfMovies: Int = 0
        
    // MARK: - Initializers and Deinitializers
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        self.coreDataManager = dependencies.coreDataManager
        self.apiManager = dependencies.apiManager
    }
    
    // MARK: - MovieCellViewModel
    
    func cellViewModelForItemAt(indexPath: IndexPath) -> MovieViewModel {
        let movie = Movie(movieDTO: self.apiManager.movies[indexPath.row], genres: self.apiManager.genres)
        return MovieViewModel(movie: movie, dependencies: self.dependencies)
    }
    
    func didSelectItemAt(indexPath: IndexPath) {
        let movie = Movie(movieDTO: self.apiManager.movies[indexPath.row], genres: self.apiManager.genres)
        self.coordinatorDelegate?.didSelectItem(movie: movie)
    }
    
    // MARK: - Fetch Methods
    
    func shouldFetchMovies() -> Bool {
        return self.currentPage < 500 && !self.isMovieFetchInProgress
    }

    func fetchPopularMovies() {
        self.isMovieFetchInProgress = true
        self.apiManager.getPopularMovies(page: self.currentPage + 1, completion: { (data, error) in
            if let data = data {
                do {
                    let popularMovies = try self.decoder.decode(PopularMoviesDTO.self, from: data)
                    self.updateData(with: popularMovies)
                } catch {
                    print(error)
                }
            }
            
            self.isMovieFetchInProgress = false
        })
    }
    
    private func updateData(with popularMovies: PopularMoviesDTO) {
        self.currentPage = popularMovies.page
        self.apiManager.movies += popularMovies.movies
        self.numberOfMovies += popularMovies.movies.count
    }
}
