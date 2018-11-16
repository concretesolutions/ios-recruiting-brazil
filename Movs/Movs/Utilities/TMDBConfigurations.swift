//
//  TMDBConfigurations.swift
//  Movs
//
//  Created by Erick Lozano Borges on 16/11/18.
//  Copyright © 2018 Erick Lozano Borges. All rights reserved.
//

import Foundation

struct TMDB {
    static let apiKey = "44a0fc2114c811dc5d25297c56fcb42f"
    
    struct language {
        static let english = "en"
        static let portuguese = "pt"
        static let spanish = "es"
    }
    
    struct endPoint {
        static let popularMovies = "https://api.themoviedb.org/3/movie/popular"
        static let searchMovies = "https://api.themoviedb.org/3/search/movie"
        static let genresList = "https://api.themoviedb.org/3/genre/movie/list"
    }
}
