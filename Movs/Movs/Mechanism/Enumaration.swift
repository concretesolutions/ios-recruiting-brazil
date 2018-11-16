//
//  Enumaration.swift
//  Movs
//
//  Created by Adann Simões on 14/11/18.
//  Copyright © 2018 SAS. All rights reserved.
//

import Foundation

enum Behavior {
    case PopularMovies,
    EmptySearch,
    GenericError,
    LoadingView
}

enum APIRoute: String {
    case base = "https://api.themoviedb.org/3/"
    case popularMovie = "movie/popular"
    case genre = "genre/movie/list"
}
