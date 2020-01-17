//
//  MoviesInfo.swift
//  theMovie-app
//
//  Created by Adriel Alves on 19/12/19.
//  Copyright © 2019 adriel. All rights reserved.
//

import Foundation

struct PopularMovies: Codable {
    var page: Int
    var totalResults: Int
    var totalPages: Int
    var results: [Movie]
}


