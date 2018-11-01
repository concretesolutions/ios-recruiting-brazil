//
//  MovieListWorker.swift
//  Movs
//
//  Created by Ricardo Rachaus on 26/10/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Moya 

class MovieListWorker: MovieListWorkingLogic {
    
    let provider = MoyaProvider<MovieService>()
    
    func fetch(page: Int, completion: @escaping (MoviesList, MovieList.Response.Status, Error?) -> ()) {
        provider.request(.listPopular(page: page)) { (result) in
            var movieList = MoviesList(results: [])
            
            switch result {
            case .success(let response):
                    do {
                        let movies = try JSONDecoder().decode(MoviesList.self, from: response.data)
                        movieList.results = movies.results
                        completion(movieList, MovieList.Response.Status.success, nil)
                    } catch let error {
                        print(error.localizedDescription)
                        completion(movieList, MovieList.Response.Status.error, error)
                    }
                
            case .failure(let error):
                print(error.localizedDescription)
                completion(movieList, MovieList.Response.Status.error, error)
            }
            
        }
    }
    
}
