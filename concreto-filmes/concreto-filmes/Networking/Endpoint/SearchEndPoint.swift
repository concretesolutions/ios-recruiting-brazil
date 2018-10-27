//
//  SearchEndPoint.swift
//  concreto-filmes
//
//  Created by Leonel Menezes on 25/10/18.
//  Copyright © 2018 Leonel Menezes. All rights reserved.
//

import Foundation

public enum SearchApi {
    case movies(text: String, page: Int)
}


extension SearchApi: EndPointType {
    
    var environmentBaseURL : String {
        return "https://api.themoviedb.org/3/search"
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .movies:
            return "movie"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .movies(let text, let page):
            return .requestParameters(bodyParameters: nil,
                                             urlParameters: ["page":page,
                                                             "query": text,
                                                             "api_key":MovieNetworkManager.MovieAPIKey,
                                                             "language": Locale.preferredLanguages[0] as String
                                                            ])
            
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    
}
