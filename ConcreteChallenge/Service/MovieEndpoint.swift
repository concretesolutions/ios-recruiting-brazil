//
//  MovieEndpoint.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 07/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import Alamofire

/**
Provides requests for weather operations
 
 - Returns: The request for a determinated operation
 */
enum MovieEndpoint: APIConfiguration {
    /**
     Get the popular movies
     
     - Parameters:
        - page: The request page
     */
    case popular(page: Int)
    
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .popular:
            return .get
        }
    }
    
    // MARK: - Path
    var path: String {
        switch self {
        case .popular(let page):
            return "/movie/popular?api_key=\(NetworkInfo.APIParameterKey.apiKey)&page=\(page)"
        }
    }
    
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .popular:
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
