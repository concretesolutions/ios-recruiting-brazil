
//
//  Router.swift
//  ConcreteChallenge
//
//  Created by Thiago  Wlasenko Nicolau on 30/10/18.
//  Copyright © 2018 Thiago  Wlasenko Nicolau. All rights reserved.
//

import Foundation
import Alamofire

enum Router {
    case popularMovies
    case genres
    
    var path: String {
        switch self {
            case .popularMovies: return "/movie/popular"
            case .genres: return "/genre/movie/list?api_key=\(Network.manager.apiKey)"
        }
    }
    
    var method : HTTPMethod {
        switch  self {
            case .popularMovies, .genres: return .get
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
