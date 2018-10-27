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
}

extension TMDBProvider: TargetType {
    var baseURL: URL {
        return kAPI.TMDB.basePath
    }
    
    var path: String {
        switch self {
        case .popular:
            return "discover/movie"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .popular:
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
                kAPI.TMDB.sortParamKey : kAPI.TMDB.popularityDescParamValue,
                kAPI.TMDB.pageParamKey : page,
                kAPI.TMDB.keyParamKey : kAPI.TMDB.key
            ]
        }
    }
    
    var task: Task {
        switch self {
        case .popular:
            return .requestParameters(parameters: self.params!,
                                      encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .popular:
            return nil
        }
    }
}
