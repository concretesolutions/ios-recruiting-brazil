//
//  MoviesService.swift
//  MoviesApp
//
//  Created by Thiago Borges Jordani on 04/12/18.
//  Copyright © 2018 Thiago Borges Jordani. All rights reserved.
//

import Foundation

class MoviesService: BaseService {
    private var endpoints = (popular: "/movie/popular",
                             genre: "/genre/movie/list")
    
    typealias PagedMoviesCompletion = ((_ movies: [Movie], _ pagination: Pagination?, _ error: Error?) -> ())
    typealias ErrorCompletion = ((_ error: Error?) -> ())
    
    func loadPopular(page: Int = 1, completion: @escaping PagedMoviesCompletion) {
        self.serviceResponse(method: .get, path: endpoints.popular, parameters: ["page": String(page)]) { (_code, _result, _error) in
            if let error = _error {
                completion([], nil, error)
            } else if let code = _code, let httpCode = HTTPResponseCode(rawValue: code) {
                switch httpCode {
                case .success:
                    if let result = _result as? [String:Any] {
                        var movies = [Movie]()
                        if let moviesData = result["results"] as? [[String:Any]] {
                            for movie in moviesData {
                                movies.append(Movie(dictionary: movie))
                            }
                        }
                        let pagination = Pagination(from: result)
                        completion(movies, pagination, nil)
                    } else {
                        completion([], nil, NSError.init())
                    }
                default:
                    completion([], nil, NSError.init())
                }
            } else {
                completion([], nil, NSError.init())
            }
        }
    }
    
    func loadGenres(completion: @escaping ErrorCompletion) {
        self.serviceResponse(method: .get, path: endpoints.genre) { (_code, _result, _error) in
            if let error = _error {
                completion(error)
            } else if let code = _code, let httpCode = HTTPResponseCode(rawValue: code) {
                switch httpCode {
                case .success:
                    if let result = _result as? [String:Any], let genresData = result["genres"] as? [[String:Any]] {
                        for genre in genresData {
                            GenrePersistanceHelper.save(genreData: genre)
                        }
                        completion(nil)
                    } else {
                        completion(NSError.init())
                    }
                default:
                    completion(NSError.init())
                }
            } else {
                completion(NSError.init())
            }
        }
    }
}
