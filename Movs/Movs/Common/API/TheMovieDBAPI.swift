//
//  TheMovieDBAPI.swift
//  Movs
//
//  Created by Filipe Jordão on 22/01/19.
//  Copyright © 2019 Filipe Jordão. All rights reserved.
//

import Foundation
import Moya

enum TheMovieDBAPI {
    case top(page: Int)
    case configuration
    case genres
}

extension TheMovieDBAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3")!
    }

    var path: String {
        switch self {
        case .top:
            return "/movie/popular"

        case .configuration:
            return "/configuration"

        case .genres:
            return "/genre/movie/list"
        }
    }

    var method: Moya.Method {
        switch self {
        case .top, .configuration, .genres:
            return .get
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case let .top(page: page):
            var parameters = [String: Any]()

            parameters["page"] = page
            parameters["api_key"] = "1dbb7d290ce2cb88ef8c311f67afd994"

            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)

        case .configuration, .genres:
            var parameters = [String: Any]()

            parameters["api_key"] = "1dbb7d290ce2cb88ef8c311f67afd994"

            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }

    var headers: [String: String]? {
        return nil
    }
}
