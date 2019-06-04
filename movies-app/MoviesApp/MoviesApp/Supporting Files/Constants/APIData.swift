//
//  APIData.swift
//  MoviesApp
//
//  Created by Gabriel Pereira on 02/06/19.
//  Copyright © 2019 Gabriel Pereira. All rights reserved.
//

import Foundation

struct APIData {
    static let apiKey = "1ad73f664382efcce679b9d5307e2bd0"
    static let language = "en-US"
    static let imagePath = "https://image.tmdb.org/t/p/w500"
    
    struct Endpoints {
        static let basePath = "https://api.themoviedb.org/3"
        static let popularMovies = "\(Endpoints.basePath)/movie/popular"
        static let genresList = "\(Endpoints.basePath)/genre/movie/list"
    }
    
    static func mountPathForRequest(path: String = Endpoints.popularMovies, page: Int = 1) -> String {
        return "\(path)?api_key=\(APIData.apiKey)&language=\(APIData.language)&page=\(page)"
    }
}
