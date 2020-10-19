//
//  MovsEndpoint.swift
//  Movs
//
//  Created by Joao Lucas on 08/10/20.
//

import Foundation

enum MovsEndpoint {
    case moviesList
    case getGenres
    case getCast(id: Int)
}

extension MovsEndpoint: EndpointProtocol {
    var scheme: HTTPScheme {
        return .https
    }
    
    var host: String {
        return "api.themoviedb.org"
    }
    
    var path: String {
        switch self {
        case .moviesList:
            return "/3/movie/popular"
            
        case .getGenres:
            return "/3/genre/movie/list"
            
        case .getCast(let idMovie):
            return "/3/movie/\(idMovie)/images"
        }
    }
    
    var apiKey: String {
        return "ec33a5ee87834b72e09e9aaf60d4c9fc"
    }
    
    var parameters: HTTPParameters {
        return ["": ""]
    }
    
    var method: HTTPMethod {
        switch self {
        case .moviesList, .getGenres, .getCast:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        return ["Content-type": "application/json"]
    }
    
    var urlComponents: URLComponents {
        var components = URLComponents()
        components.scheme = scheme.toString()
        components.host = host
        components.path = path
        components.queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        return components
    }

    var request: URLRequest {
        var request = URLRequest(with: urlComponents.url)
        request.httpMethod = method.toString()
        request.allHTTPHeaderFields = headers
        return request
    }
}
