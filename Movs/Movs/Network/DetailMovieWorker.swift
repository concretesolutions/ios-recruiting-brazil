//
//  DetailMovieWorker.swift
//  Movs
//
//  Created by Maisa on 22/10/18.
//  Copyright (c) 2018 Maisa Milena. All rights reserved.
//

import UIKit
import Moya

protocol DetailMovieWorkerProtocol {
    func getMovieDetails(request: DetailMovieModel.Request,
                         success successCallback: @escaping (MovieDetailed) -> (),
                         error errorCallback: @escaping (FetchError) -> (),
                         failure failureCallback: @escaping (FetchError) -> ())
}

class DetailMovieWorker: DetailMovieWorkerProtocol {
  
    fileprivate let provider = MoyaProvider<MovieDB_API>()
    
    /**
     Fetch details about a movie
     */
    func getMovieDetails(request: DetailMovieModel.Request,
                         success successCallback: @escaping (MovieDetailed) -> (),
                         error errorCallback: @escaping (FetchError) -> (),
                         failure failureCallback: @escaping (FetchError) -> ()) {
        
        provider.request(.getMovieDetails(movieRequest: request)) { (result) in
            switch result {
            case .success(let response):
                do {
                    let movie: MovieDetailed = try JSONDecoder().decode(MovieDetailed.self, from: response.data)
                    successCallback(movie)
                } catch {
                    errorCallback(FetchError.serverError)
                }
            case .failure:
               failureCallback(FetchError.networkFailToConnect)
            }
        }
        
    }
    
}
