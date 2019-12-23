//
//  MovieDBEndPoint.swift
//  ConcreteRecruiting
//
//  Created by Alysson Moreira on 23/12/19.
//  Copyright © 2019 Alysson Moreira. All rights reserved.
//

import Foundation
import NetworkLayer

enum MovieEndPoint: EndPointType {
    
    case popularMovies
    
    var baseUrl: URL {
        guard let url = URL(string: NetworkManager.baseUrl) else { fatalError("Unable to create URL object!")}
        return url
    }
    
    var path: String {
        
        switch self {
        case .popularMovies:
            return "/get-popular-videos"
        }
        
    }
    
    var method: HTTPMethod {
        
        switch self {
        case .popularMovies:
            return .get
        }
    }
    
    var task: HTTPTask {
        
        switch self {
        case .popularMovies:
            return .requestUrlParameters(["api_key": NetworkManager.apiKey])
        }
        
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var parametersEncoding: ParametersEncoding {
        return .url
    }
    
}
