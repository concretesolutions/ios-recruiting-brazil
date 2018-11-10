//
//  BusinessFavoriteMovies.swift
//  Wonder
//
//  Created by Marcelo on 09/11/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import Foundation

class BusinessFavoriteMovies {
    
    var year: String?
    var overview: String?
    var genre: String?
    var title: String?
    var id: String?
    var poster: String?
    
    init() {
        self.year = String()
        self.overview = String()
        self.genre = String()
        self.title = String()
        self.id = String()
        self.poster = String()
    }
    
    init(year: String, overview: String, genre: String, title: String, id: String, poster: String) {
        self.year = year
        self.overview = overview
        self.genre = genre
        self.title = title
        self.id = id
        self.poster = poster
    }
    
    
    
}
