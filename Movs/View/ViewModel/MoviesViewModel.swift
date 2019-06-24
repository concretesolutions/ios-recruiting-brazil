//
//  MoviesViewModel.swift
//  Movs
//
//  Created by Filipe Merli on 18/06/19.
//  Copyright © 2019 Filipe Merli. All rights reserved.
//

import Foundation
import UIKit

protocol MoviesViewModelDelegate: class {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?)
    func onFetchFailed(with reason: String)
}

final class MoviesViewModel {
    private weak var delegate: MoviesViewModelDelegate?
    private var movies: [Movie] = []
    private var genres: [Genres] = []
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
    
    func findGen(from id: Int) -> String {
        for index in 0..<genres.count  {
            if genres[index].id == id {
                return genres[index].name
            }
        }
        return ""
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
                self.client.fetchMoviesGenres() { resultGen in
                    switch resultGen {
                    case .failure(let errorGen):
                        DispatchQueue.main.async {
                            self.isFetchInProgress = false
                            self.delegate?.onFetchFailed(with: errorGen.reason)
                        }
                    case .success(let responseGen):
                        DispatchQueue.main.async {
                            self.genres.append(contentsOf: responseGen.genres)
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
    }
    
}

