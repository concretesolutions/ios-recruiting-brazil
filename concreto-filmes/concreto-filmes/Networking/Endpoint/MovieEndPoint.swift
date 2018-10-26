//
//  MovieEndPoint.swift
//  concreto-filmes
//
//  Created by Leonel Menezes on 24/10/18.
//  Copyright © 2018 Leonel Menezes. All rights reserved.
//

import Foundation


enum NetworkEnvironment {
    case qa
    case production
    case staging
}

public enum MovieApi {
    case popular(page:Int)
    case newMovies(page:Int)
}

extension MovieApi: EndPointType {
    
    var environmentBaseURL : String {
        switch MovieNetworkManager.environment {
        case .production: return "https://api.themoviedb.org/3/movie/"
        case .qa: return "https://qa.themoviedb.org/3/movie/"
        case .staging: return "https://staging.themoviedb.org/3/movie/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .popular:
            return "popular"
        case .newMovies:
            return "now_playing"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .newMovies(let page):
            return .requestParameters(bodyParameters: nil,
                                      urlParameters: ["page":page,
                                                      "api_key":MovieNetworkManager.MovieAPIKey])
        case .popular(let page):
            return .requestParameters(bodyParameters: nil,
                                      urlParameters: [
                                        "page":page,
                                        "api_key": MovieNetworkManager.MovieAPIKey,
                                        "language":Locale.preferredLanguages[0] as String
                                        ])
            
//        default:
//            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
