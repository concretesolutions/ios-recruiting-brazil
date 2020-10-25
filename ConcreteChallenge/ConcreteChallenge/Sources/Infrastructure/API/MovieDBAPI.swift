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
        guard let url = URL(string: "\(MovieNetworkConstants.baseURL)/\(MovieNetworkConstants.apiVersion)") else {
            fatalError("baseURL could not be found.")
        }

        return url
    }

    var path: String {
        switch self {
        case .getMovies: return MovieNetworkConstants.moviePopular
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
            return .requestParameters(parameters: [MovieNetworkConstants.apiKey: MovieNetworkConstants.apiKeyValue],
                                      encoding: URLEncoding.queryString)
        }
   }

    var headers: [String : String]? {
        return nil
    }
}
