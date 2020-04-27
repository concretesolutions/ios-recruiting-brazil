//
//  Common.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 17/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import Alamofire

//The header fields
enum HttpHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case qm2ApiKey = "x-application-id";
    case requestId = "x-request-id";
}

//The content type (JSON)
enum ContentType: String {
    case json = "application/json"
}


enum Environment {
    case dev
    case staging
    case production
    
    var baseUrl: String {
        switch self {
        case .dev:
            return "https://api.themoviedb.org/3"
        case .staging:
            return "https://api.themoviedb.org/3"
        case .production:
            return "https://api.themoviedb.org/3"
        }
    }
    
    var imageBaseUrl: String {
        switch self {
        case .dev:
            return "https://image.tmdb.org/t/p"
        case .staging:
            return "https://image.tmdb.org/t/p"
        case .production:
            return "https://image.tmdb.org/t/p"
        }
    }
    
    
    var apiKey: String {
        switch self {
        case .dev:
            return "41753cb07159e6575c68421c0792962c"
        case .staging:
            return "41753cb07159e6575c68421c0792962c"
        case .production:
            return "41753cb07159e6575c68421c0792962c"
        }
    }
}


