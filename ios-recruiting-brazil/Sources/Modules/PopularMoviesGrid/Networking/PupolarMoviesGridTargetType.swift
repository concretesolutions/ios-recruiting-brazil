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
}

extension MoviesTargetType: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org")!
    }
    
    var path: String {
        switch self {
        case .popularMovies:
            return "/3/movie/popular"
        default:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .popularMovies:
            return .get
        default:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .popularMovies(let page):
            return .requestParameters(parameters: ["api_key" : "9ddaf105f04f0d57967901a059565af4",
                                                   "page" : page],
                                      encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
