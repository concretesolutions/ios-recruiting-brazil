//
//  MovieClient.swift
//  ios-challenge-moviedb
//
//  Created by Giovanni Severo Barros on 22/02/20.
//  Copyright © 2020 Giovanni Severo Barros. All rights reserved.
//

import Alamofire

/**
 Perform requests to Movie related Stuff
 */
class MovieClient {
    /**
     Create requests based on the parameters received
     
     - Parameters:
        - route: What type of *Endpoint* that will be used on the *Request*
        - completion: Return Data or Error
     */
    @discardableResult
    private static func performRequest(route: MoviesEndpoint, completion: @escaping (DataResponse<Any, AFError>?) -> Void) -> DataRequest {
        return AF.request(route).validate().responseJSON() { (response: DataResponse<Any, AFError>?) in
            completion(response)
        }
    }
    /**
     Perform an request to get all Popular Movies
    
     - Parameters:
        - page: Requested Page
        - completion: Return all popular Movies or an Error
     */
    static func getPopularMovies(page: Int, completion: @escaping (PopularMovies?, Error?) -> Void) {
        performRequest(route: .popularMovies(page: page)) { response in
            if response?.error == nil {
                if let data = response?.data, let utf8Text = String(data: data, encoding: .utf8) {
                    guard let json = utf8Text.data(using: .utf8) else { return completion(nil, response?.error) }
                    do {
                        let jsonDecoder = JSONDecoder()
                        let decodedJson = try jsonDecoder.decode(PopularMovies.self, from: json)
                        completion(decodedJson, nil)
                    } catch {
                        completion(nil, error)
                    }
                }
            } else {
                completion(nil, response?.error)
            }
        }
    }
        /**
     Perform an request to get all Genres
     
     - Parameters:
        - completion: Return all Genres an Error
     */
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
