//
//  MovieDBAPI.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 24/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import Moya

enum MovieDBAPI: TargetType {
    case fetchMovies(language: String, page: Int)

    var baseURL: URL {
        guard let url = URL(string: "\(Constants.MovieNetwork.baseURL)/\(Constants.MovieNetwork.apiVersion)") else {
            fatalError(Strings.convertUrlFailure.localizable)
        }

        return url
    }

    var path: String {
        switch self {
        case .fetchMovies: return Constants.MovieNetwork.moviePopular
        }
    }

    var method: Moya.Method {
        switch self {
        case .fetchMovies: return .get
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .fetchMovies(let language, let page):
            return .requestParameters(parameters: [Constants.MovieNetwork.apiKey: Constants.MovieNetwork.apiKeyValue,
                                                   Constants.MovieNetwork.language: language,
                                                   Constants.MovieNetwork.page: page],
                                      encoding: URLEncoding.queryString)
        }
   }

    var headers: [String : String]? {
        return Constants.MovieNetwork.headersContentTypeApplicationJSON
    }
}
