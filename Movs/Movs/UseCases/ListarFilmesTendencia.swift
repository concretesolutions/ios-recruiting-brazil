//
//  ListTrendingMovies.swift
//  Movs
//
//  Created by Gabriel Coutinho on 01/12/20.
//

import Foundation

protocol ListarFilmesTendenciaUseCase {
    func getFilmesTendencia(_ completionHandler: @escaping (Trending?) -> Void)
}

class ListarFilmesTendencia: ListarFilmesTendenciaUseCase {
    private let api: TheMovieDBAPI
    
    init() {
        api = API()
    }
    
    func getFilmesTendencia(_ completionHandler: @escaping (Trending?) -> Void) {
        let decoder = JSONDecoder()
        api.getFilmesTendencia { data in
            guard let data = data else { return }
            let trending = try? decoder.decode(Trending.self, from: data)
            completionHandler(trending)
        }
    }
}
