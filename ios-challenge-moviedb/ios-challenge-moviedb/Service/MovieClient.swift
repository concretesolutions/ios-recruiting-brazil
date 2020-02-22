//
//  MovieClient.swift
//  ios-challenge-moviedb
//
//  Created by Giovanni Severo Barros on 22/02/20.
//  Copyright © 2020 Giovanni Severo Barros. All rights reserved.
//

import Alamofire


class MovieClient {
    @discardableResult
    private static func performRequest(route: MoviesEndpoint, completion: @escaping (DataResponse<Any, AFError>?) -> Void) -> DataRequest {
        return AF.request(route).validate().responseJSON() { (response: DataResponse<Any, AFError>?) in
            completion(response)
        }
    }
    
    // TO DO: - Função de get popular movies / get genres / search
    
    static func getPopularMovies(page: Int, completion: @escaping ([Movie]?, Error?) -> Void) {
        performRequest(route: .popularMovies(page: page)) { response in
            if response?.error == nil {
                if let data = response?.data, let utf8Text = String(data: data, encoding: .utf8) {
                    guard let json = utf8Text.data(using: .utf8) else { return completion(nil, response?.error) }
                    do {
                        let jsonDecoder = JSONDecoder()
                        let decodedJson = try jsonDecoder.decode(PopularMovies.self, from: json)
                        completion(decodedJson.movies, nil)
                    } catch {
                        completion(nil, error)
                    }
                }
            } else {
                completion(nil, response?.error)
            }
        }
    }
    
    static func getAllGenres(completion: @escaping ([Genre]?, Error?) -> Void) {
        performRequest(route: .genres) { response in
            if response?.error == nil {
                if let data = response?.data, let utf8Text = String(data: data, encoding: .utf8) {
                    guard let json = utf8Text.data(using: .utf8) else { return completion(nil, response?.error) }
                    do {
                        let jsonDecoder = JSONDecoder()
                        let decodedJson = try jsonDecoder.decode(GenreList.self, from: json)
                        completion(decodedJson.genres, nil)
                    } catch {
                        completion(nil, error)
                    }
                }
            } else {
                completion(nil, response?.error)
            }
        }
    }
    
    static func searchMovie(text: String, completion: @escaping ([Movie]?, Error?) -> Void) {
//        performRequest(route: .search(text: <#T##String#>), completion: <#T##(DataResponse<Any, AFError>?) -> Void#>)
    }
}
