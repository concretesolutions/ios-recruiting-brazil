//
//  MovieService.swift
//  iOS-Recruiting
//
//  Created by Thiago Augusto on 10/12/19.
//  Copyright © 2019 sevontheedge. All rights reserved.
//


import Foundation

class MovieService: NetworkBaseService {
    
    static let shared = MovieService()
    
    typealias MovieResultHandler = (NetworkResult<MovieResult, NetworkError, Int>) -> Void
    
    // MARK: - Endpoints
    internal func getPopularMovies(page: Int, handler: @escaping MovieResultHandler) {
        let path = "movie/popular"
        let parameters: [String : Any] = ["language": "en-US", "page": page]
        let service = NetworkService(api: .movieDBv3, path: path, parameters: parameters)
        NetworkDispatch.shared.get(service) {
            handler($0)
        }
    }

}
