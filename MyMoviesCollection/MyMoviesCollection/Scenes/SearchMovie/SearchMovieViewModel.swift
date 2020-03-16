//
//  SearchMovieViewModel.swift
//  MyMoviesCollection
//
//  Created by Filipe Merli on 16/03/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import Foundation

protocol SearchMovieViewModelDelegate: class {
    func onFetchCompleted()
    func onFetchFailed(with reason: String)
}

final class SearchMovieViewModel {
    
    // MARK: - Initializer
    
    init(delegate: SearchMovieViewModelDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - Properties
    
    private weak var delegate: SearchMovieViewModelDelegate?
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
    
    public func fetchSearchMovies() {
        guard !isFetchInProgress else {
            return
        }
        isFetchInProgress = true
        client.fetchSearchMovie(text: "Thor") { resultMov in
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
                    self.delegate?.onFetchCompleted()
                }
            }
        }
    }
    
}
