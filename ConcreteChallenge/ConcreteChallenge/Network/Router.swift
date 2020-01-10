//
//  Router.swift
//  ConcreteChallenge
//
//  Created by Kaique Damato on 10/1/20.
//  Copyright © 2020 KiQ. All rights reserved.
//

import Foundation

enum Router {
    
    case getMovies
    
    var scheme: String {
        switch self {
        case .getMovies:
            return "https"
        }
    }
    
    var host: String {
        switch self {
        case .getMovies:
            return "api.themoviedb.org"
        }
    }
    
    var path: String {
        switch self {
        case .getMovies:
            return "/3/movie/popular"
        }
    }
    
    var parameters: [URLQueryItem] {
        let apiKey = "4b005d0e4deec9b57eb0678a441110ce"
        switch self {
        case .getMovies:
            return [URLQueryItem(name: "api_key", value: apiKey),
                    URLQueryItem(name: "language", value: "en-US"),
                    URLQueryItem(name: "page", value: "1")]
        }
    }
    
    var method: String {
        switch self {
        case .getMovies:
            return "GET"
        }
    }
}
