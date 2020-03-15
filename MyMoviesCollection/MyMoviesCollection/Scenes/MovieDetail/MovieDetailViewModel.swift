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
    
    // MARK: - Initializer
    
    init(delegate: MovieDetailViewModelDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - Properties
    
    private weak var delegate: MovieDetailViewModelDelegate?
    private var genres: [Genres] = []
    private var genresAppended: String = ""
    private var isFetchInProgress = false
    
    let client = MoviesAPIClient()
    
    // MARK: - Class Functions
    
    public func getGenres() -> [Genres] {
        return genres
    }
    
    public func fetchMovieDetail() {
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
    
    public func findGens(genIds: [Int?]) -> String {
        var finalGenString = ""
        for i in 0..<genIds.count {
            finalGenString.append(contentsOf: getGenById(from: genIds[i] ?? 0))
            if i != (genIds.count - 1) {
                finalGenString.append(contentsOf: ", ")
            }
        }
        return finalGenString
    }
    
    private func getGenById(from id: Int) -> String {
        for index in 0..<genres.count  {
            if genres[index].id == id {
                return genres[index].name
            }
        }
        return ""
    }
    
}
