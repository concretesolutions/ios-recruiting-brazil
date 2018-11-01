//
//  TMDBProvider.swift
//  Mov
//
//  Created by Miguel Nery on 25/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation
import Moya

enum TMDBProvider {
    case popular(page: Int)
    case genres
}

extension TMDBProvider: TargetType {
    var baseURL: URL {
        return API.TMDB.basePath
    }
    
    var path: String {
        switch self {
        case .popular:
            return "discover/movie"
        case .genres:
            return "genre/movie/list"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .popular, .genres:
            return .get
            
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var params: [String : Any]? {
        switch self {
        case .popular(let page):
            return [
                API.TMDB.sortParamKey : API.TMDB.popularityDescParamValue,
                API.TMDB.pageParamKey : page,
                API.TMDB.keyParamKey : API.TMDB.key
            ]
            
        case .genres:
            return [API.TMDB.keyParamKey : API.TMDB.key]
        }
    }
    
    var task: Task {
        switch self {
        case .popular, .genres:
            return .requestParameters(parameters: self.params!,
                                      encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .popular, .genres:
            return nil
        }
    }
}
