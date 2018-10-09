//
//  MoviesListClient.swift
//  TMDBMoviesSample
//
//  Created by Breno Rage Aboud on 04/10/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

class FavoritesMoviesListClient {
    
    var moviesList: [MovieDetailModel] = []
    
    private lazy var userDefault = UserDefaultWrapper()
}

