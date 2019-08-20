//
//  Requester.swift
//  DesafioConcrete
//
//  Created by Fabio Martins on 17/08/19.
//  Copyright © 2019 Fabio Martins. All rights reserved.
//

import Foundation

class Requester {
    
    func requestPopular(page: Int, callback:@escaping () -> ()) {
        Endpoints.shared.makeRequest(apiUrl: Endpoints.shared.getPopularMovies(page: page), method: .get) { (response) in
            if(response?.result.isSuccess)! {
                do {
                    let decoder = JSONDecoder()
                    let movies = try decoder.decode(MovieResponse.self, from: (response?.data)!)
                    Singleton.shared.populares.append(contentsOf: movies.results)
                    callback()
                }  catch let (error) {
                    print(error)
                }
            } else {
                print("Erro ao recuperar os filmes")
            }
        }
    }
    
    func requestGenreList() {
        Endpoints.shared.makeRequest(apiUrl: Endpoints.shared.getGenreList(), method: .get, callback: { (response) in
            if(response?.result.isSuccess)! {
                do {
                    let decoder = JSONDecoder()
                    let genres = try decoder.decode(GenreResponse.self, from: (response?.data)!)
                    Singleton.shared.genres = Dictionary(uniqueKeysWithValues: genres.results.map{ ($0.id, $0) })
                } catch let (error){
                    print(error)
                }
            } else {
                print("Erro ao recuperar os gêneros")
            }
        })
    }
    
}
