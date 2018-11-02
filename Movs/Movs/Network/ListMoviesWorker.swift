//
//  ListMoviesWorker.swift
//  Movs
//
//  Created by Maisa on 23/10/18.
//  Copyright (c) 2018 Maisa Milena. All rights reserved.
//

import Moya
import Result
import Foundation

protocol ListMoviesWorkerProtocol {
    func fetchPopularMovies(request: ListMovies.Request,
                            success successCallback: @escaping (MovieList) -> (),
                            error errorCallback: @escaping (FetchError) -> (),
                            failure failureCallback: @escaping (FetchError) -> ())
}


class ListMoviesWorker: ListMoviesWorkerProtocol {
  
    fileprivate let provider = MoyaProvider<MovieDB_API>()
    
    /**
     Fetch the most popular movies
     - parameter page: the current page to load
     */
    func fetchPopularMovies(request: ListMovies.Request,
                            success successCallback: @escaping (MovieList) -> (),
                            error errorCallback: @escaping (FetchError) -> (),
                            failure failureCallback: @escaping (FetchError) -> ()) {
        provider.request(.listPopularMovies(listRequest: request)) { (result) in
            switch result {
            case .success(let response):
                do {
                    let movies: MovieList = try JSONDecoder().decode(MovieList.self, from: response.data)
                    successCallback(movies)
                } catch {
                    errorCallback(FetchError.serverError)
                }
            case .failure:
                failureCallback(FetchError.networkFailToConnect)
            }
        }
    }
}
