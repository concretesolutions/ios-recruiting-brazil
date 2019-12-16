//
//  EndPoint.swift
//  Challenge-Concrete
//
//  Created by João Paulo de Oliveira Sabino on 10/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

enum EndPoint {
    case getMovie(id: Int)
    case getTrending(mediaType: MediaType, timeWindow: TimeWindow, page: Int)
    case getGenres
    case searchMovie(query: String)
    case getImage(path: String)
}

extension EndPoint: RouterService {
    var baseURL: String {
        return "https://api.themoviedb.org/3"
    }
    
    var imagesURL: String {
        return "https://image.tmdb.org/t/p/w185"
    }
    
    var apiKey: String {
        return "bcf0a220ff2f5cad9a4c21be24bb23b6"
    }
    
    var path: String {
        switch self {
        case .getMovie(let id):
            return "/movie/\(id)"
        case .getTrending(let mediaType, let timeWindow, _):
            return "/trending/\(mediaType.rawValue)/\(timeWindow.rawValue)"
        case .searchMovie:
            return "/search/movie"
        case .getGenres:
            return "/genre/movie/list"
        case .getImage(let path):
            return path
        }
        
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var task: Task {
        switch self {
        case .searchMovie(let query):
            return .requestWithQuery(["query": query, "api_key": apiKey])
        case .getTrending(_,_, let page):
            return .requestWithQuery(["api_key": apiKey, "page": page])
        default:
            return .requestWithQuery(["api_key": apiKey])
        }
    }
    
    var headers: Headers? {
        return nil
    }
    
    var parametersEncoding: ParametersEncoding {
        return .url
    }
}
