//
//  MoviesModels.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

enum Movies {
    enum FetchMovies {
        struct Request {
            let language: String
            let page: Int
        }

        struct Response {
            let moviesResponse: MoviesPopulariesResponse
        }

        struct ViewModel {
            let moviesResponse: MoviesPopulariesResponse
        }
    }

    enum SaveMovie {
        struct Request {
            let movie: Movie
        }
    }
}
