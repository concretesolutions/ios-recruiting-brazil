//
//  TMDBMoyaGateway.swift
//  Mov
//
//  Created by Miguel Nery on 25/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation
import Moya

class TMDBMoyaGateway {
    let provider = MoyaProvider<TMDBProvider>()
}

extension TMDBMoyaGateway: MovieFetcher {
    func fetchPopularMovies(page: Int, _ completion: @escaping (Result<[Movie]>) -> Void) {
            
        self.provider.requestDecodable(target: .popular(page: page), decoder: API.TMDB.decoder) { (result: Result<MoviesResults>) in
            let movies = result.map { result in result.results }
            completion(movies)
        }
    }
}

extension TMDBMoyaGateway: GenreFetcher {
    func fetchGenres(_ completion: @escaping (Result<[Genre]>) -> Void) {
        self.provider.requestDecodable(target: .genres, decoder: JSONDecoder()) { (result: Result<GenreResults>) in
            let genres = result.map { result in result.genres }
            completion(genres)
        }
    }
}
