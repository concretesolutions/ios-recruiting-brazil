//
//  Requester.swift
//  DesafioConcrete
//
//  Created by Fabio Martins on 17/08/19.
//  Copyright © 2019 Fabio Martins. All rights reserved.
//

import Foundation
import UIKit

class Requester {
    
    var view:PopularView?
    
    func requestPopular(page: Int, callback:@escaping (_ success: Bool) -> ()) {
        Endpoints.shared.makeRequest(apiUrl: Endpoints.shared.getPopularMovies(page: page), method: .get) { (response) in
            if(response?.result.isSuccess)! {
                do {
                    let decoder = JSONDecoder()
                    let movies = try decoder.decode(MovieResponse.self, from: (response?.data)!)
                    Singleton.shared.populares.append(contentsOf: movies.results)
                    callback(true)
                }  catch let (error) {
                    print(error)
                    print("JSON Decode Error: requestPopular")
                }
            } else {
                print("Erro ao recuperar os filmes")
                callback(false)
            }
        }
    }
    
    func requestGenreList(didFail:@escaping () -> ()) {
        Endpoints.shared.makeRequest(apiUrl: Endpoints.shared.getGenreList(), method: .get, callback: { (response) in
            if(response?.result.isSuccess)! {
                do {
                    let decoder = JSONDecoder()
                    let genres = try decoder.decode(GenreResponse.self, from: (response?.data)!)
                    Singleton.shared.genres = Dictionary(uniqueKeysWithValues: genres.results.map{ ($0.id, $0) })
                } catch let (error){
                    print(error)
                    print("JSON Decode Error: requestGenre")
                }
            } else {
                print("Erro ao recuperar os gêneros")
                didFail()
            }
        })
    }
    
    init(vc: PopularView) {
        self.view = vc
    }
    
}
