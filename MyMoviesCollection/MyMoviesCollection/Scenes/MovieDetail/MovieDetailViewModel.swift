//
//  MovieDetailViewModel.swift
//  MyMoviesCollection
//
//  Created by Filipe Merli on 14/03/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import Foundation
protocol MovieDetailViewModelDelegate: class {
    func onFetchCompleted()
    func onFetchFailed(with reason: String)
}

final class MovieDetailViewModel {
    private weak var delegate: MovieDetailViewModelDelegate?
    private var genres: [Genres] = []
    private var isFetchInProgress = false
    
    let client = MoviesAPIClient()
    
    init(delegate: MovieDetailViewModelDelegate) {
        self.delegate = delegate
    }
    
    func fetchMovieDetail() {
        guard !isFetchInProgress else {
            return
        }
        isFetchInProgress = true
        client.fetchMoviesGenres() { result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self.isFetchInProgress = false
                    self.delegate?.onFetchFailed(with: error.reason)
                }
            case .success(let response):
                self.isFetchInProgress = false
                DispatchQueue.main.async {
                    self.genres = response.genres
                    self.isFetchInProgress = false
                    self.delegate?.onFetchCompleted()
                }
            }
        }
    }
    
}
