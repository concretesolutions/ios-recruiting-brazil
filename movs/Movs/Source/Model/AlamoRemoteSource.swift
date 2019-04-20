//
//  AlamoSource.swift
//  Headlines
//
//  Created by Lorien Moisyn on 14/03/19.
//  Copyright © 2019 Lorien Moisyn. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class AlamoRemoteSource {
    
    private let manager = SessionManager.default
    private let baseURL = URL(string: "https://api.themoviedb.org/3/")!
    private var parameters: [String: String] = [:]
    
    func getTopMovies(at page: Int) -> Single<[Movie]> {
        var request = URLRequest(url: baseURL.appendingPathComponent("movie/popular"))
        request.httpMethod = "GET"
        parameters["api_key"] = "c0ff0f1a3f08240ea2419ef0b323ef53"
        parameters["page"] = String(page)
        
        return URLEncoding.default
            .encode(request, with: parameters)
            .flatMap { request in
                self.manager
                    .request(request)
                    .responseData(queue: DispatchQueue.global())
            }
            .map { tuple in
                return try JSONDecoder().decode(ResponseMovies<Movie>.self, from: tuple.0!)
            }
            .map({ (response) in
                DataModel.sharedInstance.movies += response.results
                return response.results
            })
            .do(onError: { error in
                print("Error: \(error)")
            })
            .asSingle()
    }
    
    func getGenres() -> Single<[Genre]> {
        var request = URLRequest(url: baseURL.appendingPathComponent("genre/movie/list"))
        request.httpMethod = "GET"
        parameters.removeAll()
        parameters["api_key"] = "c0ff0f1a3f08240ea2419ef0b323ef53"
        
        return URLEncoding.default
            .encode(request, with: parameters)
            .flatMap { request in
                self.manager
                    .request(request)
                    .responseData(queue: DispatchQueue.global())
            }
            .map { tuple in
                return try JSONDecoder().decode(ResponseGenres<Genre>.self, from: tuple.0!)
            }
            .map({ (response) in
                return response.genres
            })
            .do(onError: { error in
                print("Error: \(error)")
            })
            .asSingle()
    }
    
}
