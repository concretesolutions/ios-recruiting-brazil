//
//  TheMovieDBConsultant.swift
//  Movie
//
//  Created by Elton Santana on 09/07/19.
//  Copyright © 2019 Memo. All rights reserved.
//

import Foundation
import Moya

enum TheMovieDBMoyaProvider {
    case popular(page: Int)
    case genres
}

extension TheMovieDBMoyaProvider: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3")!
    }
    
    var path: String {
        switch self {
        case .popular(page: _):
            return "/movie/popular"
        case .genres:
            return "/genre/movie/list"
        }
    }
    
    
    var method: Moya.Method {
        switch self {
        case .popular(page: _), .genres:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        var parameters: [String: Any] = [:]
        parameters["api_key"] = "8a9578196dc2c731119a4c826068f288"
        switch self {
        case .popular(page: let page):
            parameters["page"] = page
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .genres:
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
