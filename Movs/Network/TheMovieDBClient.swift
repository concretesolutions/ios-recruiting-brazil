//
//  TheMovieDBClient.swift
//  Movs
//
//  Created by Filipe on 18/06/19.
//  Copyright © 2019 Filipe Merli. All rights reserved.
//

import Foundation
import UIKit

final class TheMovieDBClient {
    private lazy var corpoURL: URL = {
        return URL(string: "https://api.themoviedb.org/3/")!
    }()
    private lazy var bannerURL: URL = {
        return URL(string: "https://image.tmdb.org/t/p/w500")!
    }()
    
    let session: URLSession
    let defaultParameters = ["api_key" : "6009379178c6cf65ffc7468b6598440f", "language" : "pt-BR"]
    let path = "movie/popular"
    
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
        print(urlRequest)
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
    
}


