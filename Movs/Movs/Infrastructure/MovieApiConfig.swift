//
//  MovieApiConfig.swift
//  Movs
//
//  Created by Douglas Silveira Machado on 12/08/19.
//  Copyright © 2019 Douglas Silveira Machado. All rights reserved.
//

import Foundation

struct MovieApiConfig {

    static let privateKey = "9b9f207b503e03a4e0b1267156c23dd2"

    struct Language {
        static let english = "en"
        static let portuguese = "pt"
    }

    struct EndPoint {
        static let popular = "https://api.themoviedb.org/3/movie/popular"
        static let genres = "https://api.themoviedb.org/3/genre/movie/list"
        static let image = "https://image.tmdb.org/t/p/w200"
    }
}
