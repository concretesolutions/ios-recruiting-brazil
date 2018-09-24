//
//  Movies.swift
//  TheMovieDBConcrete
//
//  Created by eduardo soares neto on 23/09/18.
//  Copyright © 2018 eduardo soares neto. All rights reserved.
//

import UIKit

class Movies: NSObject {

    var movies: [Movie]
    
    override init() {
        self.movies = []
    }
    init(movies: [Movie]) {
        self.movies = movies
    }
}
