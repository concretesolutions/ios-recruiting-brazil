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
        return URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=6009379178c6cf65ffc7468b6598440f&language=pt-BR&page=1")!
    }()
    
    var session: URLSession = URLSession.shared
    //let urlReq = "movie/popular?api_key=6009379178c6cf65ffc7468b6598440f&language=pt-BR&page=1"
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchPopularMovies(completion: @escaping (Result<MoviesResponse, ResponseError>) -> Void) {
        let urlRequest = URLRequest(url: corpoURL)
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


