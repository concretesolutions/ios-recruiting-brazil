//
//  MovieDetailTargetType.swift
//  ios-recruiting-brazil
//
//  Created by André Vieira on 30/09/18.
//  Copyright © 2018 André Vieira. All rights reserved.
//

import Foundation
import Moya

enum MovieDetailTargetType {
    case genders
}

extension MovieDetailTargetType: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org")!
    }
    
    var path: String {
        return "/3/genre/movie/list"
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestParameters(parameters: ["api_key": "9ddaf105f04f0d57967901a059565af4"],
                                  encoding: URLEncoding.default)
    }
    
    var headers: [String: String]? {
        return nil
    }
}
