//
//  NetworkManager.swift
//  ConcreteRecruiting
//
//  Created by Alysson Moreira on 23/12/19.
//  Copyright © 2019 Alysson Moreira. All rights reserved.
//

import Foundation
import NetworkLayer

class NetworkManager {
    
    static let baseUrl = "https://api.themoviedb.org/3/movie"
    static let baseImageUrl = "https://image.tmdb.org/t/p"
    static let apiKey = "d07322200307dc499064d61f72cbee14"
    
    private static let router = Router<MovieEndPoint>()
    
    static func getPopularMovies(page: Int, completion: @escaping (Result<MovieApiResponse, Error>
        ) -> Void) {
        
        router.request(.popularMovies(page: page), type: MovieApiResponse.self, completion: completion)
        
    }
    
    static func getPosterImage(path: String, completion: @escaping (Result<Data, Error>) -> Void) {
        router.request(.getPosterImage(path: path), type: Data.self, completion: completion)
    }
    
}
