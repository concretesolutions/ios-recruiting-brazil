//
//  MovieDBAPI.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 24/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import Moya

enum MovieDBAPI: TargetType {
    case getMovies

    var baseURL: URL {
        guard let url = URL(string: "https://api.themoviedb.org/3") else {
            fatalError("baseURL could not be found.")
        }

        return url
    }

    var path: String {
        switch self {
        case .getMovies: return "/movie/popular"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getMovies: return .get
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .getMovies:
            return .requestParameters(parameters: ["api_key": "9b9f207b503e03a4e0b1267156c23dd2"],
                                      encoding: URLEncoding.queryString)
        }
   }

    var headers: [String : String]? {
        return nil
    }
}
