//
//  HomeProvider.swift
//  ConcreteChallenge
//
//  Created by Thiago  Wlasenko Nicolau on 30/10/18.
//  Copyright © 2018 Thiago  Wlasenko Nicolau. All rights reserved.
//

import Foundation

protocol HomeProviderDelegate {
    func handler(badRequest: BadRequest)
}

class HomeProvider {
    var delegate: HomeProviderDelegate?
    
    func fetchPopularMovies(page: Int, completion: @escaping ([Movie]) -> Void) {
        let parameters = [
            "api_key": Network.manager.apiKey,
            "page": page
        ] as [String: Any]
        
        Network.manager.request(Router.popularMovies, parameters: parameters, decodable: PopularMovies.self) { (popularMovies, badRequest) in
            if let badRequest = badRequest {
                self.delegate?.handler(badRequest: badRequest)
                return
            }
            
            guard let movies = popularMovies?.results else {
                print("No results")
                return
            }
            
            
            
            completion(movies)
        }
    }
}
