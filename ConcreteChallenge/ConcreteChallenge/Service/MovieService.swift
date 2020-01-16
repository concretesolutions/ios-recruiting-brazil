//
//  MovieService.swift
//  ConcreteChallenge
//
//  Created by Marcos Santos on 19/12/19.
//  Copyright © 2019 Marcos Santos. All rights reserved.
//

import NetworkLayer

enum MovieService {
    case popularMovies(page: Int)
    case movie(id: Int)
}

extension MovieService: NetworkService {
    var baseURL: URL { URL(string: "https://api.themoviedb.org/3")! }

    var path: String {
        switch self {
        case .popularMovies: return "/movie/popular"
        case .movie(let id): return "/movie/\(id)"
        }
    }

    var method: HTTPMethod { .get }

    var task: HTTPTask {
        switch self {
        case .popularMovies(let page): return .requestURLParameters(["page": page])
        case .movie: return .requestPlain
        }
    }

    var headers: Headers? {
        ["Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9" +
            ".eyJhdWQiOiI1OTBmOTQwODQ5NDMzNmQ1OWE4MjNhYWI0YjMxODEwYiIsInN1YiI6IjVlMDEwOTQ0N" +
            "zUxMTBkMDAxM2Q4MjAyNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ" +
            ".ZgQyw4wodpbCqpq4tbttpKgmsAEDocc_njRuQS5MyG8",
         "Content-Type": "application/json;charset=utf-8"]
    }

}
