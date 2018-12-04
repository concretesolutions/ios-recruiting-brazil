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

enum Result<Value> {
    case success(Value)
    case failure(Error)
}

class MovieAPIClient {
    
    private let baseURL: URL = URL(string: "https://api.themoviedb.org/3/")! 
    private let apiKey = "72276e5f1c91b4d55037d5c35ffbdfe1"
    
    init() {}

    func fetchPopularMovies(page: Int = 1, completion: @escaping (Result<PagedResponse<Movie>>) -> Void) {
        
        let req = Alamofire.request(baseURL.appendingPathComponent("movie/popular"), parameters: ["page": page, "api_key": apiKey])

        req.validate().responseData { dataResponse in
            switch dataResponse.result {
            case .success(let value):
    
                let decoder = JSONDecoder()
                let pagedResponse = try! decoder.decode(PagedResponse<Movie>.self, from: value)
                completion(.success(pagedResponse))
                
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
    
    func fetchMovie(with id: Int, completion: @escaping (Result<Detail>) -> Void) {
        let req = Alamofire.request(baseURL.appendingPathComponent("movie/\(id)"), parameters: ["api_key": apiKey])
        
        req.validate().responseData { (dataResponse) in
            switch dataResponse.result {
            case .success(let value):
                let decoder = JSONDecoder()
                let movieResponse = try! decoder.decode(Detail.self, from: value)
                completion(.success(movieResponse))
                
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
    
    func fetchConfiguration(completion: @escaping (Result<Configuration>) -> Void) {
        let req = Alamofire.request(baseURL.appendingPathComponent("configuration"), parameters: ["api_key": apiKey])
        
        req.validate().responseData { dataResponse in
            switch dataResponse.result {
            case .success(let value):
                let decoder = JSONDecoder()
                let response = try! decoder.decode(Configuration.self, from: value)
                completion(.success(response))
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }

        }
    }
    
    static func imageURL(with path: String) -> URL {
        guard let configuration = APISettings.shared.configuration else {
            return URL(string: "https://image.tmdb.org/t/p/w500/")!.appendingPathComponent(path)
        }
        
        guard let baseImageURL = URL(string: configuration.images.baseURL) else {
            //TODO: Show error screen
            fatalError("Invalid base URL supplied by API")
        }
        
        var imageSize = ""
        if configuration.images.posterSizes.contains("w500") {
            imageSize = "w500"
        } else {
            imageSize = configuration.images.posterSizes.first ?? "w300"
        }
        let url = baseImageURL.appendingPathComponent(imageSize).appendingPathComponent(path)
        
        return url
        
    }

}
