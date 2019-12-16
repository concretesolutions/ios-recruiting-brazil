//
//  MovieDBService.swift
//  ConcreteChallenge
//
//  Created by Matheus Oliveira Costa on 14/12/19.
//  Copyright © 2019 mathocosta. All rights reserved.
//

import Foundation

enum MovieDBService {
    case popularMovies(Int)
    case movieGenres
    case posterImage(String)
}

extension MovieDBService: Service {
    var baseURL: URL {
        switch self {
        case .posterImage(_):
            return URL(string: "https://image.tmdb.org/t/p/w500")!
        default:
            return URL(string: "https://api.themoviedb.org/3")!
        }
    }

    var path: String {
        switch self {
        case .popularMovies(_):
            return "/movie/popular"
        case .movieGenres:
            return "/genre/movie/list"
        case .posterImage(let posterPath):
            return posterPath
        }
    }

    var method: HTTPMethod {
        return .get
    }

    var task: HTTPTask {
        var paramenters = ["api_key": "1acba848b2e76fb281b090d44ec2acf1"]

        if case let .popularMovies(page) = self {
            paramenters["page"] = String(describing: page)
        }

        return .requestParameters(paramenters)
    }

    var headers: Headers? {
        return nil
    }

    var parametersEncoding: ParametersEncoding {
        return .url
    }


}
