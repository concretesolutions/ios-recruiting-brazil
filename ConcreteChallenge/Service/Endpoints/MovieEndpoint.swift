//
//  MovieEndpoint.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 07/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import Alamofire

/**
Provides requests for movie operations
 
 - Returns: The request for a determinated operation
 */
enum MovieEndpoint: APIConfiguration {
    /**
     Get the popular movies
     
     - Parameters:
        - page: The request page
     */
    case popular(page: Int)
    
    /**
     Get the genre list
     */
    case genreList
    
    /**
     Do a search query.
     - Parameter text: The text to be searched.
     */
    case search(_ text: String)
    
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .popular, .genreList, .search:
            return .get
        }
    }
    
    // MARK: - Path
    var path: String {
        switch self {
        case .popular(let page):
            return "/movie/popular?api_key=\(NetworkInfo.APIParameterKey.apiKey)&page=\(page)"
        case .genreList:
            return "/genre/movie/list?api_key=\(NetworkInfo.APIParameterKey.apiKey)"
        case .search(let text):
            let safeText = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            return "/search/movie?api_key=\(NetworkInfo.APIParameterKey.apiKey)&query=\(safeText ?? "%20")"
        }
    }
    
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .popular, .genreList, .search:
            return nil
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = NetworkInfo.ProductionServer.baseURL + path
        
        var urlRequest = URLRequest(url: URL(string: url)!)
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
}
