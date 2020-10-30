//
//  MoviesModels.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import Foundation

enum Movies {
    enum FetchMovies {
        struct Request {
            let language: String
            let page: Int
            let genres: [Genre]
        }

        struct Response {
            let page: Int
            let totalPages: Int
            let movies: [Movie]
        }

        struct ViewModel {
            let page: Int
            let totalPages: Int
            let movies: [Movie]
        }
    }

    enum FetchGenres {
        struct Request {
            let language: String
        }

        struct Response {
            let genres: [Genre]
        }

        struct ViewModel {
            let genres: [Genre]
        }
    }
}
