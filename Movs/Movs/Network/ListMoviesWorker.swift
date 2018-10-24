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

class ListMoviesWorker {
  
    fileprivate let provider = MoyaProvider<MovieDB_API>()
    
    /**
     Fetch the most popular movies
     - parameter page: the current page to load
     */
    func fetchPopularMovies(page: Int, completion: @escaping (ListMovies.Fetch.Response) -> ()) {
        provider.request(.listPopularMovies(page: page)) { (result) in
            
            switch result {
            case .success(let response):
                do {
                    let movies = try JSONDecoder().decode(MovieList.self, from: response.data)
                    let responseSuccess = ListMovies.Fetch.Response(movies: movies.movies, error: "")
                    completion(responseSuccess)
                } catch let error {
                    print(error)
                }
            case .failure(let error):
                let error = NSError.init(domain: "FetchMovies", code: 0, userInfo: [NSLocalizedDescriptionKey: "Parsing Error"])
            }
        }
    }
}
