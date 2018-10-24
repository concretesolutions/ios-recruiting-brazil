//
//  Movie.swift
//  concreto-filmes
//
//  Created by Leonel Menezes on 24/10/18.
//  Copyright © 2018 Leonel Menezes. All rights reserved.
//

import Foundation


class Movie {
    var name : String
    var releaseDate: Date
    var genres: [String]
    var description: String
    var posterUrl: String
    
    init(name: String, releaseDate: Date, genres: [String], description: String, posterUrl: String) {
        self.name = name
        self.releaseDate = releaseDate
        self.genres = genres
        self.description = description
        self.posterUrl = posterUrl
    }
}
