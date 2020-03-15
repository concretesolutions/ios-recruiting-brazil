//
//  MoviesAPIClient.swift
//  MyMoviesCollection
//
//  Created by Filipe Merli on 13/03/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import Foundation

final class MoviesAPIClient {
    private lazy var corpoURL: URL = {
        return URL(string: "https://api.themoviedb.org/3/")!
    }()
    
    let session: URLSession
    let defaultParameters = ["api_key" : "6009379178c6cf65ffc7468b6598440f", "language" : "pt-BR"]
    let path = "movie/popular"
    let pathGen = "genre/movie/list"
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchPopularMovies(page: Int, completion: @escaping (Result<MoviesResponse, ResponseError>) -> Void) {
        var urlRequest = URLRequest(url: corpoURL.appendingPathComponent(path))
        let parameters = ["page": "\(page)"].merging(defaultParameters, uniquingKeysWith: +)
        var urlComponents = URLComponents(url: urlRequest.url!, resolvingAgainstBaseURL: false)
        let queryItems = parameters.map { key, value in
                URLQueryItem(name: key, value: value)
        }
        urlComponents?.queryItems = queryItems
        urlRequest.url = urlComponents?.url
        session.dataTask(with: urlRequest, completionHandler: { data, response, error in
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
    
    func fetchMoviesGenres(completion: @escaping (Result<GenresResponse, ResponseError>) -> Void) {
        var urlRequest = URLRequest(url: corpoURL.appendingPathComponent(pathGen))
        var urlComponents = URLComponents(url: urlRequest.url!, resolvingAgainstBaseURL: false)
        let queryItems = defaultParameters.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        urlComponents?.queryItems = queryItems
        urlRequest.url = urlComponents?.url
        session.dataTask(with: urlRequest, completionHandler: { data, response, error in
            guard
                let httpResponse = response as? HTTPURLResponse, httpResponse.hasSuccessStatusCode,
                let data = data
                else {
                    completion(Result.failure(ResponseError.rede))
                    return
            }
            guard let decodedResponse = try? JSONDecoder().decode(GenresResponse.self, from: data) else {
                completion(Result.failure(ResponseError.decoding))
                return
            }
            completion(Result.success(decodedResponse))
        }).resume()
    }
    
}
