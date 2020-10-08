//
//  MoviesListService.swift
//  Movs
//
//  Created by Joao Lucas on 08/10/20.
//

import Foundation

class MoviesListService: MoviesListServiceProtocol {
    
    private let client: HttpClientProtocol

    init(client: HttpClientProtocol = HttpClient()) {
        self.client = client
    }
    
    func getMoviesList(completion: @escaping (Result<MoviesDTO, HTTPError>) -> Void) {
        let endpoint: MovsEndpoint = .moviesList
        let request = endpoint.request
        
        client.request(request, completion: completion)
    }
}
