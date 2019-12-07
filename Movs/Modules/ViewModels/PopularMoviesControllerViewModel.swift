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
    
    // MARK: - Models
    
    private var movies: [Movie] = []
    
    // MARK: - Properties
    
    internal let apiManager: MoviesAPIManager
    internal let decoder = JSONDecoder()
    internal var isMovieFetchInProgress: Bool = false
    weak var coordinatorDelegate: PopularMoviesCoordinator?
    
    // MARK: - Publishers
    
    @Published var currentPage: Int = 0
    @Published var numberOfMovies: Int = 0
        
    // MARK: - Initializers and Deinitializers
    
    init(apiManager: MoviesAPIManager) {
        self.apiManager = apiManager
    }
    
    // MARK: - MovieCellViewModel
    
    func cellViewModelForItemAt(indexPath: IndexPath) -> MovieCellViewModel {
        return MovieCellViewModel(movie: self.movies[indexPath.row], apiManager: self.apiManager)
    }
    
    func didSelectItemAt(indexPath: IndexPath) {
        self.coordinatorDelegate?.didSelectItem(movie: self.movies[indexPath.row])
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
        self.movies += popularMovies.movies.map({ Movie(movieDTO: $0, genres: self.apiManager.genres) })
        self.numberOfMovies += popularMovies.movies.count
    }
}
