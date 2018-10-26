//
//  GenresEndPoint.swift
//  concreto-filmes
//
//  Created by Leonel Menezes on 26/10/18.
//  Copyright © 2018 Leonel Menezes. All rights reserved.
//

import Foundation
import Keys

public enum GenresApi {
    case movieList
}


extension GenresApi: EndPointType {
    
    var baseURL: URL {
        guard let url = URL(string: "https://api.themoviedb.org/3/genre/movie/") else { fatalError("baseURL could not be configured.") }
        
        return url
    }
    
    var path: String {
        switch self {
        case .movieList:
            return "list"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .movieList:
            return .requestParameters(bodyParameters: nil, urlParameters: [
                "api_key":ConcretoFilmesKeys().tHE_MOVIE_DB_V3_KEY,
                "language": Locale.preferredLanguages[0] as String
                ])
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    
}
