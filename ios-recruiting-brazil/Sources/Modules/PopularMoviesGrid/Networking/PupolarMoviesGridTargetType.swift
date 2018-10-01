//
//  MoviesTargetType.swift
//  ios-recruiting-brazil
//
//  Created by André Vieira on 30/09/18.
//  Copyright © 2018 André Vieira. All rights reserved.
//

import Foundation
import Moya

enum MoviesTargetType {
    case popularMovies(Int)
    case filterMovies(String, Int)
}

extension MoviesTargetType: TargetType {
    var baseURL: URL {
        return URL(string: environment.baseUrl)!
    }
    
    var path: String {
        switch self {
        case .popularMovies:
            return "/3/movie/popular"
        case .filterMovies:
            return "/3/search/movie"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .popularMovies,
             .filterMovies:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .popularMovies(let page):
            return .requestParameters(parameters: ["api_key": environment.apiKey,
                                                   "page": page],
                                      encoding: URLEncoding.default)
        case .filterMovies(let search, let page):
                return .requestParameters(parameters: ["api_key": environment.apiKey,
                                                       "page": page,
                                                       "query": search],
                                          encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}
