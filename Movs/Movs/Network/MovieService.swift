//
//  MovieService.swift
//  Movs
//
//  Created by Ricardo Rachaus on 26/10/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Moya

enum MovieService {
    case listPopular(page: Int)
    case movieDetails(id: Int)
    case listGenres
    
    static let key = "34b05e648999ed77dffdc0ce65741ccc"
    static let baseImageURL = "https://image.tmdb.org/t/p/w500"
}

extension MovieService: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3")!
    }
    
    var path: String {
        switch self {
        case .listPopular:
            return "/movie/popular"
        case .movieDetails(let id):
            return "/movie/\(id)"
        case .listGenres:
            return "/genre/movie/list"
        }
    }
    
    var method: Method {
        switch self {
        case .listPopular, .movieDetails, .listGenres:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .listPopular(let page):
            return .requestParameters(parameters: ["api_key" : MovieService.key, "page" : page], encoding: URLEncoding.queryString)
        case .movieDetails, .listGenres:
            return .requestParameters(parameters: ["api_key" : MovieService.key], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
}
