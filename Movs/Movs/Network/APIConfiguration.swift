//
//  APIConfiguration.swift
//  Movs
//
//  Created by Maisa on 23/10/18.
//  Copyright © 2018 Maisa Milena. All rights reserved.
//

import Moya

enum MovieDB_API {
    case listPopularMovies(listRequest: ListMovies.Request)
    case getMovieDetails(movieRequest: DetailMovieModel.Request)
}

struct APISetting {
    fileprivate static let key = "3ed1cbcbc6fa1685bafefb06522087ac"
}

extension MovieDB_API: TargetType {
    
    var languagePortuguese: String { return "pt-BR" }
    
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3")!
    }
    
    var path: String {
        switch self {
        case .listPopularMovies:
            return "/movie/popular"
        case .getMovieDetails(let movieRequest):
            return "/movie/\(movieRequest.movieId)"
        }
    }
    
    var method: Method {
        switch self {
        case .listPopularMovies, .getMovieDetails:
            return Method.get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .listPopularMovies(let listRequest):
            return .requestParameters(parameters: ["api_key": APISetting.key,
                                                   "language": languagePortuguese,
                                                   "page": listRequest.page],
                                      encoding: URLEncoding.queryString)
        case .getMovieDetails:
            return .requestParameters(parameters: ["api_key": APISetting.key,
                                                   "language": languagePortuguese],
                                      encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}
