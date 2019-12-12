//
//  MoviesService.swift
//  ios-recruiting-brazil
//
//  Created by Adriel Freire on 12/12/19.
//  Copyright © 2019 Adriel Freire. All rights reserved.
//

import Foundation
enum MovieService: Service {
    private var apiKey: String {
        "751e969079abb838516dbe21d3f2e686"
    }
    case getTrendingMovies
    case getImage(String)
    case getGenres
    case searchMovie(String)

    var baseURL: URL {
        switch self {
        case .getTrendingMovies, .getGenres, .searchMovie:
            if let url = URL(string: "https://api.themoviedb.org/3/") {
                return url
            }
        case .getImage:
            if let url = URL(string: "https://image.tmdb.org/t/p/w500/") {
                return url
            }
        }
        return URL(fileURLWithPath: "")
    }

    var path: String {
        switch self {
        case .getTrendingMovies:
            return "trending/movie/week"
        case .getImage(let imagePath):
            return imagePath
        case .getGenres:
            return "genre/movie/list"
        case .searchMovie:
            return "search/movie"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getTrendingMovies, .getImage, .getGenres, .searchMovie:
            return .get
        }
    }

    var task: HTTPTask {
        switch self {
        case .getImage:
            return .requestPlain
        case .getTrendingMovies, .getGenres:
            return .requestParameters(["api_key": apiKey])
        case .searchMovie(let name):
            return .requestParameters(["api_key": apiKey, "query": name])
        }
    }

    var headers: Headers? {
        switch self {
        case .getTrendingMovies, .getImage, .getGenres, .searchMovie:
            return nil
        }
    }

    var parametersEncoding: ParametersEncoding {
        switch self {
        case .getTrendingMovies, .getImage, .getGenres, .searchMovie:
            return .url
        }
    }

}
