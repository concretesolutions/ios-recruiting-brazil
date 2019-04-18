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
                return try JSONDecoder().decode(Response<Movie>.self, from: tuple.0!)
            }
            .map({ (response) in
                return response.results
            })
            .do(onError: { error in
                print("Error: \(error)")
            })
            .asSingle()
    }
    
}
