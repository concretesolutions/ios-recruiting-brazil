//
//  MovieNetworkManager.swift
//  concreto-filmes
//
//  Created by Leonel Menezes on 24/10/18.
//  Copyright © 2018 Leonel Menezes. All rights reserved.
//

import Foundation
import Keys

class MovieNetworkManager: NetworkManager<MovieApi> {
    static let MovieAPIKey = ConcretoFilmesKeys().tHE_MOVIE_DB_V3_KEY
    static let environment: NetworkEnvironment = .production

    func getPopularMovies(page: Int, completion: @escaping (_ movies: [Movie]?, _ error: String?) -> Void) {
        router.request(.popular(page: page)) { (data, response, error) in
            if error != nil {
                completion(nil, "Please check your network connection")
            }

            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode(MovieApiResponse.self, from: responseData)
                        completion(apiResponse.movies, nil)
                    } catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
}
