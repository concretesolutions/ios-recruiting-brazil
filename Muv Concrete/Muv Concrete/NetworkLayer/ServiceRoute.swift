//
//  EndPoints.swift
//  Muv Concrete
//
//  Created by Mariaelena Silveira on 15/01/20.
//  Copyright © 2020 Mariaelena Silveira. All rights reserved.
//

import Foundation

enum ServiceRoute {
    
    case movie(Int, Int)
    case popularMovie(Int)
    case search(String, Int)
    
}

extension ServiceRoute: ServiceRouteProtocol {
    
    var scheme: String {
        return "https"
    }

    var path: String{
        switch self {
        case .movie(let id):
            return "/3/movie/\(id)"
        case .popularMovie:
            return "/3/movie/popular"
        case .search:
            return "/3/search/movie"
        }
    }

    var host: String {
        return "api.themoviedb.org"
    }

    var method: HTTPMethod {
        return .get
    }
    
    var query: [String : String]? {
        switch self {
        case .movie, .popularMovie:
            return ["api_key" : "d754b7528022528ea868cd88d8b96c78"]
        case .search(let text):
            return ["api_key" : "d754b7528022528ea868cd88d8b96c78", "query": "\(text)"]
        }
    }
    
    var headers: [String : String]? {
        return ["Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkNzU0Yjc1MjgwMjI1MjhlYTg2OGNkODhkOGI5NmM3OCIsInN1YiI6IjVkNmZmNTMzZTIyZDI4MDAwZmI1NjVjOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Lx1p8E2RbRPirdtKptRK1wlrsv403TkxpHzTKrfL-z8",
        "Content-Type": "application/json;charset=utf-8"]
    }
    
    var body: [String : String]? {
        return nil
    }
    
    
}
