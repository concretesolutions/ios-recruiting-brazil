//
//  ImageEndpoint.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 08/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import Alamofire

/**
Provides requests for image operations
 
 - Returns: The request for a determinated operation
 */
enum ImageEndpoint: APIConfiguration {
    
    /**
     Get the genre list
     */
    case image(width: Int, path: String? = nil)
    
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .image:
            return .get
        }
    }
    
    // MARK: - Path
    var path: String {
        switch self {
        case .image(let width, let path):
            guard let path = path else { return "" }
            return "/w\(width)\(path)"
        }
    }
    
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .image:
            return nil
        }
    }
    
    // MARK: - URL -
    var completeURL: URL? {
        guard path != "" else { return nil }
        let completePath = NetworkInfo.ProductionServer.imageBaseURL + path
        return URL(string: completePath)!
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        
        let url = NetworkInfo.ProductionServer.imageBaseURL + path
        
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
