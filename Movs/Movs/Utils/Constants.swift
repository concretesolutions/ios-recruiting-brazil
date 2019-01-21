//
//  Constants.swift
//  Movs
//
//  Created by Franclin Cabral on 1/18/19.
//  Copyright © 2019 franclin. All rights reserved.
//

import Foundation

struct Constants {
    static let moviesCellIdentifier: String = "MovieCell"
    static let favoriteCellIdentifier: String = "FavoriteCell"
    static let requestTokenKey: String = "request_token"
    static let baseUrl: String = "https://api.themoviedb.org/3/"
    static let baseImageUrl: String = "https://image.tmdb.org/t/p"
    static let posterSize: String = "/w185"
    static let backdropSize: String = "/w500"
    static let authenticationUrl: String = "authentication/token/new"
    static let popularMovies: String = "movie/popular"
    static let genresUrl: String = "genre/movie/list"
    static let apiKey: String = "?api_key=9576766894aacad34639098206e95594" //TODO: add this apiKey to a plist file
    
}

