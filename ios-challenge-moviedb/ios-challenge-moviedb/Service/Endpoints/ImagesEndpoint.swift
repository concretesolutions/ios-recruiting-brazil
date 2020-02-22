//
//  ImagesEndpoint.swift
//  ios-challenge-moviedb
//
//  Created by Giovanni Severo Barros on 21/02/20.
//  Copyright © 2020 Giovanni Severo Barros. All rights reserved.
//

import Alamofire

/**
 Images Endpoints used to request images related information
 
 - Return: The requested information
 */
enum ImagesEndpoint: APIConfiguration {
    /**
     Get Movie Image
     
     - Parameters:
        - width: Image width size
        - path: Image path
     */
    case movieImage(width: Int, path: String)
    
    // MARK: - Method
    /**
     Method that will be used depending on endpoint case
     */
    var method: HTTPMethod {
        switch self {
        case .movieImage:
            return .get
        }
    }
    
    // MARK: - Path
    /**
     Path that will be used depending on endpoint case
     */
    var path: String {
        switch self {
        case .movieImage(let width, let path):
            return "w\(width)/\(path)"
        }
    }
    
    // MARK: - Parameters
    /**
     Parameters that will be used depending on the request type
     */
    var parameters: Parameters? {
        switch self {
        case .movieImage:
            return nil
        }
    }
    
    // MARK: - Create URL Request
    /**
     Function that creates an URL Request
     */
    func asURLRequest() throws -> URLRequest {
        let baseURL = try Constants.ProductionServer.image.asURL()
        
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
