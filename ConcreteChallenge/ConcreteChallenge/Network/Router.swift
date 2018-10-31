
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
    
    var path: String {
        switch self {
            case .popularMovies: return "/movie/popular?api_key=47265a2c299dbd2185eac909cf0dbeed&language=en-US&page=1"
        }
    }
    
    var method : HTTPMethod {
        switch  self {
            case .popularMovies: return .get
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
