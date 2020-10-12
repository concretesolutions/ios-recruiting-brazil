//
//  MoviesListService.swift
//  Movs
//
//  Created by Joao Lucas on 08/10/20.
//

import Foundation

class MoviesListService: MoviesListServiceProtocol {
    
    private let client: HTTPClientProtocol

    init(client: HTTPClientProtocol = HTTPClient()) {
        self.client = client
    }
    
    func getMoviesList(completion: @escaping (Result<MoviesDTO, HTTPError>) -> Void) {
        let endpoint: MovsEndpoint = .moviesList
        let request = endpoint.request
        
        client.request(request, completion: completion)
    }
    
    func getGenres(completion: @escaping (Result<GenresDTO, HTTPError>) -> Void) {
        let endpoint: MovsEndpoint = .getGenres
        let request = endpoint.request
        
        client.request(request, completion: completion)
    }
}
