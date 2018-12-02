//
//  MovieAPIClient.swift
//  MoviesC
//
//  Created by Isabel Lima on 02/12/18.
//  Copyright © 2018 Isabel Lima. All rights reserved.
//

import Foundation
import Alamofire

struct PagedResponse<T: Codable> : Codable {
    let page: Int
    let totalPages: Int
    let totalResults: Int
    let results: [T]
    
    private enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case results
    }
    
    
    
}

class MovieAPIClient {
    
    private let baseURL: URL = URL(string: "https://api.themoviedb.org/3/")!
    private let apiKey = "72276e5f1c91b4d55037d5c35ffbdfe1"
    
    init() {}

    func fetchPopularMovies(page: Int = 1, completion: @escaping (PagedResponse<Movie>) -> Void) {
        
        let req = Alamofire.request(baseURL.appendingPathComponent("movie/popular"), parameters: ["page": page, "api_key": apiKey])

        req.validate().responseData { dataResponse in
            switch dataResponse.result {
            case .success(let value):
    
                let decoder = JSONDecoder()
                let pagedResponse = try! decoder.decode(PagedResponse<Movie>.self, from: value)
                completion(pagedResponse)
                
            case .failure(let error):
                print(error) // TODO: display error feedback
            }
        }
    }
    
    func fetchConfiguration(completion: @escaping (Configuration) -> Void) {
        let req = Alamofire.request(baseURL.appendingPathComponent("configuration"), parameters: ["api_key": apiKey])
        
        req.validate().responseData { dataResponse in
            let decoder = JSONDecoder()
            let response = try! decoder.decode(Configuration.self, from: dataResponse.data!)
            completion(response)
        }
    }
}
