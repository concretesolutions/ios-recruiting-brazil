//
//  MoviesModels.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import Foundation

enum Movies {
    enum FetchLocalMovies {
        struct Response {
            let movies: [Movie]
        }

        struct ViewModel {
            let movies: [Movie]
        }
    }

    enum FetchMovies {
        struct Request {
            let language: String
            let page: Int
            let genres: [GenreResponse]
        }

        struct Response {
            let page: Int
            let totalPages: Int
            let genres: [GenreResponse]
            let moviesResponse: [MovieResponse]
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
            let genres: [GenreResponse]
        }

        struct ViewModel {
            let genres: [GenreResponse]
        }
    }

    enum FetchLocalMoviesBySearch {
        struct Request {
            let movies: [Movie]
            let filter: FilterSearch
        }

        struct Response {
            let movies: [Movie]
            let search: FilterSearch
        }

        struct ViewModel {
            let movies: [Movie]
            let search: FilterSearch
        }
    }
}
