//
//  MoviesCollectionViewModel.swift
//  MyMoviesCollection
//
//  Created by Filipe Merli on 13/03/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import Foundation
protocol MoviesViewModelDelegate: class {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?)
    func onFetchFailed(with reason: String)
}

final class MoviesViewModel {
    
    // MARK: - Initializer
    
    init(delegate: MoviesViewModelDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - Properties
    
    private weak var delegate: MoviesViewModelDelegate?
    private var movies: [Movie] = []
    private var currentPage = 1
    private var total = 0
    private var isFetchInProgress = false
    
    let client = MoviesAPIClient()
    
    private var totalCount: Int {
        return total
    }
    
    public var currentCount: Int {
        return movies.count
    }
    
    // MARK: - Class Functions
    
    public func movie(at index: Int) -> Movie {
        return movies[index]
    }
    
    public func fetchPopularMovies() {
        guard !isFetchInProgress else {
            return
        }
        if currentCount != 0 && total != 0 {
            guard total > currentCount else {
                return
            }
        }
        isFetchInProgress = true
        client.fetchPopularMovies(page: currentPage) { resultMov in
            switch resultMov {
            case .failure(let errorMov):
                DispatchQueue.main.async {
                    self.isFetchInProgress = false
                    self.delegate?.onFetchFailed(with: errorMov.reason)
                }
            case .success(let responseMov):
                DispatchQueue.main.async {
                    self.currentPage += 1
                    self.total = responseMov.totalResults
                    self.movies.append(contentsOf: responseMov.movies)
                    self.isFetchInProgress = false
                    self.delegate?.onFetchCompleted(with: .none)
                }
            }
        }
    }
    
}
