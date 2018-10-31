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
    
    func fetchPopularMovies(page: Int, completion: @escaping ([MovieJSON], Int, Int) -> Void) {
        let parameters = [
            "api_key": Network.manager.apiKey,
            "page": page
        ] as [String: Any]
        
        Network.manager.request(Router.popularMovies, parameters: parameters, decodable: PopularMovies.self) { (popularMovies, badRequest) in
            if let badRequest = badRequest {
                self.delegate?.handler(badRequest: badRequest)
                return
            }
            
            guard let popularMovies = popularMovies, let results = popularMovies.results, let totalPages = popularMovies.total_pages, let totalResults = popularMovies.total_results else {
                print("No results")
                return
            }
            
            completion(results, totalPages, totalResults)
        }
    }
}
