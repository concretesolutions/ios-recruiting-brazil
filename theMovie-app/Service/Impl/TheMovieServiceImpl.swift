//
//  TheMovieAPI.swift
//  theMovie-app
//
//  Created by Adriel Alves on 19/12/19.
//  Copyright © 2019 adriel. All rights reserved.
//

import Foundation

final class TheMovieServiceImpl: TheMovieService {
   
    private let client: HTTPClient
    private let apiDetails = APIRequest()
    
    init(client: HTTPClient = HTTP()) {
        self.client = client
    }
    
    func getMovies(page: Int = 1, completion: @escaping (Result<PopularMovies, APIError>) -> Void) {
        
        let queryItems = [
            URLQueryItem(name: "page", value: String(page))
        ]
        let request = apiDetails.request(path: "movie/popular", method: HTTPMethod.get, queryItems: queryItems)
        client.perform(request, completion)
    }
}

