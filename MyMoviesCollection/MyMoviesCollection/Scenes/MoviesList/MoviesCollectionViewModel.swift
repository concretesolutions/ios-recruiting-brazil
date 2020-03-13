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
    private weak var delegate: MoviesViewModelDelegate?
    private var movies: [Movie] = []
    private var currentPage = 1
    private var total = 0
    private var isFetchInProgress = false
    
    let client = TheMovieDBClient()
    
    init(delegate: MoviesViewModelDelegate) {
        self.delegate = delegate
    }
    
    var totalCount: Int {
        return total
    }
    
    var currentCount: Int {
        return movies.count
    }
    
    func movie(at index: Int) -> Movie {
        return movies[index]
    }
    
    func fetchPopularMovies() {
        guard !isFetchInProgress else {
            return
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
                //self.client.fetchMoviesGenres() { resultGen in
                    //switch resultGen {
                    //case .failure(let errorGen):
                        //DispatchQueue.main.async {
                            self.isFetchInProgress = false
                            //self.delegate?.onFetchFailed(with: errorGen.reason)
                        //}
                    //case .success(let responseGen):
                        DispatchQueue.main.async {
                            //self.genres.append(contentsOf: responseGen.genres)
                            self.currentPage += 1
                            self.total = responseMov.totalResults
                            self.movies.append(contentsOf: responseMov.movies)
                            self.isFetchInProgress = false
                            self.delegate?.onFetchCompleted(with: .none)
                        }
                        
                    //}
                //}
            }
        }
    }
    
}
