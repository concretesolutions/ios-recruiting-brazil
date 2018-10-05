//
//  MoviesListClient.swift
//  TMDBMoviesSample
//
//  Created by Breno Rage Aboud on 04/10/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

typealias MoviesPages = [[MovieModel]]

class MoviesListClient {
    
    var moviesList: MoviesPages = []
    
    private lazy var service = Service()
    private var totalPages: Int = 1
    
    private var actualPage: Int {
        return moviesList.count
    }
    
    private var moviePage: Int {
        if moviesList.isEmpty {
            return 1
        } else {
            return actualPage + 1
        }
    }
    
    internal func getMoviesList(completion: @escaping (ResponseResultType<Int>) -> Void) {
        let url = TMDBUrl().getUrl(to: .moviesList, and: moviePage)
        if actualPage > totalPages { return }
        service.get(in: url) { [weak self] (result: ResponseResultType<MoviesListModel>) in
            switch result {
            case let .success(moviesListResult):
                self?.doSuccessTreat(with: moviesListResult, completion: completion)
            case let .fail(error):
                self?.doErrorTreat(with: error, completion: completion)
            }
        }
    }
    
    private func doSuccessTreat(with moviesListResult: MoviesListModel, completion: @escaping (ResponseResultType<Int>) -> Void) {
        totalPages = moviesListResult.totalPages
        moviesList.append(moviesListResult.moviesList)
        completion(.success(moviesListResult.page))
    }
    
    private func doErrorTreat(with error: Error, completion: @escaping (ResponseResultType<Int>) -> Void) {
        
        completion(.fail(error))
    }
}
