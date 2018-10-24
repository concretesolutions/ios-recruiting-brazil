//
//  APIConfiguration.swift
//  Movs
//
//  Created by Maisa on 23/10/18.
//  Copyright © 2018 Maisa Milena. All rights reserved.
//

import Moya

enum MovieDB_API {
    case listPopularMovies(page: Int)
}

struct APISetting {
    fileprivate static let key = "3ed1cbcbc6fa1685bafefb06522087ac"
}

extension MovieDB_API: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3")!
    }
    
    var path: String {
        switch self {
        case .listPopularMovies:
            return "/movie/popular"
        }
    }
    
    var method: Method {
        switch self {
        case .listPopularMovies:
            return Method.get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .listPopularMovies(let page):
            return .requestParameters(parameters: ["api_key": APISetting.key,
                                                   "language": "pt-BR",
                                                   "page": page],
                                      encoding: URLEncoding.queryString)
        
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}
