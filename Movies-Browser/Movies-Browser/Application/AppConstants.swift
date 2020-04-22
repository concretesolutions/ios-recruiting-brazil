//
//  AppConstants.swift
//  Movies-Browser
//
//  Created by Gustavo Severo on 19/04/20.
//  Copyright © 2020 Severo. All rights reserved.
//

import Foundation

class AppConstants {
    struct API {
        static let key = "12936d62fffd31723a5b1cca14af9929"
        static let baseUrl = "https://api.themoviedb.org/"
        static let apiVersion = "3"
        static let imageBaseUrl = "https://image.tmdb.org/t/p/w500" 
    }
    
    struct Endpoints {
        static let featuredMovies = "/movie/popular"
        static let moviesGenres = "/genre/movie/list"
    }
    
    struct PersistenceKey {
        static let favoritesMovies = "FavoritesMoviesPersistenceKey"
        static let genres = "GenresPersistenceKey"
    }
}
