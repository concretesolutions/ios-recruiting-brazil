//
//  MoviesViewModel.swift
//  Movs
//
//  Created by Filipe Merli on 18/06/19.
//  Copyright © 2019 Filipe Merli. All rights reserved.
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
    
    func moviesTitles() -> [String] {
        var titles = [String]()
        for index in 0..<movies.count {
            titles.append(movies[index].title)
        }
        return titles
    }
    
    func postersImages() -> [String] {
        var paths = [String]()
        for index in 0..<movies.count {
            paths.append(movies[index].posterImage)
        }
        return paths
    }
    
    func fetchPopularMovies() {
        guard !isFetchInProgress else {
            return
        }
        
        isFetchInProgress = true
        
        client.fetchPopularMovies() { result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self.isFetchInProgress = false
                    self.delegate?.onFetchFailed(with: error.reason)
                }
            case .success(let response):
                DispatchQueue.main.async {
                    self.currentPage += 1
                    self.isFetchInProgress = false
                    self.movies.append(contentsOf: response.movies)
                    
                    if response.page > 1 {
                        let indexPathsToReload = self.calculateIndexPathsToReload(from: response.movies)
                        self.delegate?.onFetchCompleted(with: indexPathsToReload)
                    } else {
                        self.delegate?.onFetchCompleted(with: .none)
                    }
                }
            }
        }
    }
    
    private func calculateIndexPathsToReload(from newMovies: [Movie]) -> [IndexPath] {
        let startIndex = movies.count - newMovies.count
        let endIndex = startIndex + newMovies.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
    
}

