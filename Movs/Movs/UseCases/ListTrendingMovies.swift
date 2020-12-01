//
//  ListTrendingMovies.swift
//  Movs
//
//  Created by Gabriel Coutinho on 01/12/20.
//

import Foundation

protocol ListTrendingMoviesUseCase {
    func getTrendingMovies(completionHandler: @escaping (Trending?) -> Void)
}

class ListTrendingMovies: ListTrendingMoviesUseCase {
    private let api: TheMovieDBAPI
    
    init() {
        api = API()
    }
    
    func getTrendingMovies(completionHandler: @escaping (Trending?) -> Void) {
        let decoder = JSONDecoder()
        api.getFilmesTendencia { data in
            guard let data = data else { return }
            let trending = try? decoder.decode(Trending.self, from: data)
            completionHandler(trending)
        }
    }
}
