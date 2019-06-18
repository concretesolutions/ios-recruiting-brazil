//
//  TheMovieDBClient.swift
//  Movs
//
//  Created by Filipe on 18/06/19.
//  Copyright © 2019 Filipe Merli. All rights reserved.
//

import Foundation

final class TheMovieDBClient {
    private lazy var corpoURL: URL = {
        return URL(string: "https://api.themoviedb.org/3/")!
    }()
    
    var session: URLSession = URLSession.shared
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchPopularMovies(with request: PopularMoviesRequest, completion: @escaping (Result<MoviesResponse, ResponseError>) -> Void) {
        let urlRequest = URLRequest(url: corpoURL.appendingPathComponent(request.path))
        let encodedURLRequest = urlRequest
        session.dataTask(with: encodedURLRequest, completionHandler: { data, response, error in
            guard
                let httpResponse = response as? HTTPURLResponse, httpResponse.hasSuccessStatusCode,
                let data = data
                else {
                    completion(Result.failure(ResponseError.rede))
                    return
            }
            
            guard let decodedResponse = try? JSONDecoder().decode(MoviesResponse.self, from: data) else {
                completion(Result.failure(ResponseError.decoding))
                return
            }
            
            completion(Result.success(decodedResponse))
        }).resume()

    }
    
}


