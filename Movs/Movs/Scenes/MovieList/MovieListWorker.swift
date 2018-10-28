//
//  MovieListWorker.swift
//  Movs
//
//  Created by Ricardo Rachaus on 26/10/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Moya 

protocol MovieListWorkingLogic {
    func fetch(page: Int, completion: @escaping (MovieList, MovieListModel.Response.Status, Error?) -> ())
}

class MovieListWorker: MovieListWorkingLogic {
    
    let provider = MoyaProvider<MovieService>()
    
    func fetch(page: Int, completion: @escaping (MovieList, MovieListModel.Response.Status, Error?) -> ()) {
        provider.request(.listPopular(page: page)) { (result) in
            var movieList = MovieList(results: [])
            
            switch result {
            case .success(let response):
                    do {
                        let movies = try JSONDecoder().decode(MovieList.self, from: response.data)
                        movieList.results = movies.results
                        completion(movieList, MovieListModel.Response.Status.success, nil)
                    } catch let error {
                        print(error.localizedDescription)
                        completion(movieList, MovieListModel.Response.Status.error, error)
                    }
                
            case .failure(let error):
                print(error.localizedDescription)
                completion(movieList, MovieListModel.Response.Status.error, error)
            }
            
        }
    }
    
}
