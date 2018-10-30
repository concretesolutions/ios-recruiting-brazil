//
//  TMDBMoyaGateway.swift
//  Mov
//
//  Created by Miguel Nery on 25/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation
import Moya

struct TMDBMoyaGateway: MovieFetcher {
    
    private(set) static var fetchedMovies = [Movie]()
    
    let provider = MoyaProvider<TMDBProvider>()
    
    func fetchPopularMovies(page: Int, _ completion: @escaping (Result<[Movie]>) -> Void) {
        
        guard TMDBMoyaGateway.fetchedMovies.isEmpty else {
            completion(.success(TMDBMoyaGateway.fetchedMovies))
            return
        }
            
        self.provider.requestDecodable(target: .popular(page: page), decoder: API.TMDB.decoder) { (result: Result<MoviesFetchResults>) in
            let movies = result.map { result in result.results }
            completion(movies)
        }
    }
}
