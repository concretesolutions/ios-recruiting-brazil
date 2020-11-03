//
//  FavoritesModels.swift
//  Movs
//
//  Created by Adrian Almeida on 31/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import Foundation

enum Favorites {
    enum FetchLocalMovies {
        struct Response {
            let movies: [Movie]
        }

        struct ViewModel {
            let movies: [Movie]
        }
    }

    enum DeleteMovie {
        struct Request {
            let movie: Movie
        }
    }

    enum FetchLocalMoviesBySearch {
        struct Request {
            let movies: [Movie]
            let filter: FilterSearch
        }

        struct Response {
            let movies: [Movie]
        }

        struct ViewModel {
            let movies: [Movie]
        }
    }
}
