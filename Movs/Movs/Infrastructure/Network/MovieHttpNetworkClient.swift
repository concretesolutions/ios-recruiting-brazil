//
//  MovieHttpNetworkClient.swift
//  Movs
//
//  Created by Douglas Silveira Machado on 12/08/19.
//  Copyright © 2019 Douglas Silveira Machado. All rights reserved.
//

import Foundation

class MovieHttpNetworkClient: MovieService {

    private var popularMoviesResponse: TMDBResponse?

    private var authParams: [URLQueryItem] {
        let languageCode = Locale.current.languageCode == "pt" ? MovieApiConfig.Language.portuguese : MovieApiConfig.Language.english
        return [
            URLQueryItem(name: "api_key", value: MovieApiConfig.privateKey),
            URLQueryItem(name: "language", value: languageCode)
        ]
    }

    func getPopularMovies(page: Int, completion: @escaping (Result<[Movie]>) -> Void) {
        let endPoint = MovieApiConfig.EndPoint.popular
        var urlComponents = URLComponents(string: endPoint)

        var queryItems: [URLQueryItem] = [URLQueryItem(name: "page", value: String(page))]
        queryItems.append(contentsOf: authParams)

        urlComponents?.queryItems = queryItems

        guard let url = urlComponents?.url else {
            completion(.error(TMDBError.buildingURL("error creating URL for endpoint:\(endPoint)")))
            return
        }

        _ = URLSession.shared.dataTask(with: url) { data, _, error in

            guard let data = data else {
                completion(.error(TMDBError.gettingData("error getting data with error:\(error?.localizedDescription ?? "")")))
                return
            }

            let jsonDecoder = JSONDecoder()

            do {
                let moviesResponse = try jsonDecoder.decode(TMDBResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(moviesResponse.results))
                }
            } catch {
                completion(.error(TMDBError.jsonSerialization(error.localizedDescription)))
            }
        }.resume()
    }

    func getGenres(completion: @escaping (Result<[Genre]>) -> Void) {
        let endPoint = MovieApiConfig.EndPoint.genres
        var urlComponents = URLComponents(string: endPoint)

        var queryItems: [URLQueryItem] = []
        queryItems.append(contentsOf: authParams)

        urlComponents?.queryItems = queryItems

        guard let url = urlComponents?.url else {
            completion(.error(TMDBError.buildingURL("error creating URL for endpoint:\(endPoint)")))
            return
        }

        _ = URLSession.shared.dataTask(with: url) { data, _, error in

            guard let data = data else {
                completion(.error(TMDBError.gettingData("error getting data with error:\(error?.localizedDescription ?? "")")))
                return
            }

            let jsonDecoder = JSONDecoder()

            do {
                let genresResponse = try jsonDecoder.decode(GenreResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(genresResponse.genres))
                }
            } catch {
                completion(.error(TMDBError.jsonSerialization(error.localizedDescription)))
            }
        }.resume()
    }
}
