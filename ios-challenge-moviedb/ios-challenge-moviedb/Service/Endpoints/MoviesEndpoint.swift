//
//  MoviesEndpoint.swift
//  ios-challenge-moviedb
//
//  Created by Giovanni Severo Barros on 21/02/20.
//  Copyright © 2020 Giovanni Severo Barros. All rights reserved.
//

import Alamofire

/**
 Movies Endpoints used to request movies related information
 
 - Return: The requested information
 */
enum MoviesEndpoint: APIConfiguration {
    /**
     Get popular Movies
     
     - Parameters:
        - page: Requested Page
     */
    case popularMovies(page: Int)
    
    /**
     Get all genres
     */
    case genres
    
    /**
     Search
     
     - Parameters:
        - text: String used to make the search
     */
    case search(text: String)
    
    // MARK: - Method
    /**
     Method that will be used depending on endpoint case
     */
    var method: HTTPMethod {
        switch self {
        case .search, .genres, .popularMovies:
            return .get
        }
    }
    
    // MARK: - Path
    /**
     Path that will be used depending on endpoint case
     */
    var path: String {
        switch self {
        case .popularMovies(let page):
            return "movie/popular?api_key=\(Constants.APIParameterKey.apiKey)&page=\(page)"
        case .genres:
            return "genre/movie/list?api_key=\(Constants.APIParameterKey.apiKey)"
        case .search(let text):
            return "search/movie?api_key=\(Constants.APIParameterKey.apiKey)&query=\(text)"
        }

    }
    
    // MARK: - Parameters
    /**
     Parameters that will be used depending on the request type
     */
    var parameters: Parameters? {
        switch self {
        case .search, .genres, .popularMovies:
            return nil
        }
    }
    
    // MARK: - Create URL Request
    /**
     Function that creates an URL Request
     */
    func asURLRequest() throws -> URLRequest {
        let baseURL = try Constants.ProductionServer.baseURL.asURL()
        
        var urlRequest = URLRequest(url: baseURL.appendingPathComponent(path))
        
        // Setting url request method
        urlRequest.method = method
        
        // Setting headers
        urlRequest.setValue(ContentType.json.rawValue,
                            forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue,
                            forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters,
                                                                 options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
}
