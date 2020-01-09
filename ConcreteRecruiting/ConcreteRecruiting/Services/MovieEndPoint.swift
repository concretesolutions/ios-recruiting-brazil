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
    
    case popularMovies(page: Int)
    case getPosterImage(path: String)
    case getMovieGenres
    
    var baseUrl: URL {
        
        switch self {
        case .popularMovies, .getMovieGenres:
            guard let url = URL(string: NetworkManager.baseUrl) else { fatalError("Unable to create URL object!")}
            return url
        case .getPosterImage:
            guard let url = URL(string: NetworkManager.baseImageUrl) else { fatalError("Unable to create URL object!")}
            return url
        }
        
    }
    
    var path: String {
        
        switch self {
        case .popularMovies:
            return "/popular"
        case .getPosterImage(let path):
            return "/w185"+path
        case .getMovieGenres:
            return "genre/movie/list"
        }
        
    }
    
    var method: HTTPMethod {
        
        switch self {
        case .popularMovies, .getPosterImage, .getMovieGenres:
            return .get
        }
    }
    
    var task: HTTPTask {
        
        switch self {
        case .popularMovies(let page):
            return .requestUrlParameters(["page": "\(page)", "api_key": NetworkManager.apiKey])
        case .getPosterImage, .getMovieGenres:
            return .requestPlain
        }
        
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var parametersEncoding: ParametersEncoding {
        return .url
    }
    
}
