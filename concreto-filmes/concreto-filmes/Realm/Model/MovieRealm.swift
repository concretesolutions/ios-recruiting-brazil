//
//  MovieRealm.swift
//  concreto-filmes
//
//  Created by Leonel Menezes on 01/11/18.
//  Copyright © 2018 Leonel Menezes. All rights reserved.
//

import RealmSwift

@objcMembers class MovieRealm: Object {
    
    dynamic var id: Int = 0
    dynamic var posterPath: String = ""
    dynamic var title: String = ""
    dynamic var releaseDate: Date?
    dynamic var overview: String = ""
    dynamic var genres: String = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(id: Int, posterPath: String, title: String, releaseDate: Date?, overview: String, genres: List<String>) {
        self.init()
        self.id = id
        self.posterPath = posterPath
        self.title = title
        self.releaseDate = releaseDate
        self.overview = overview
        self.genres = Array(genres).joined(separator: ", ")
    }
    
    convenience init(movie: Movie) {
        self.init()
        self.id = movie.id
        self.posterPath = movie.posterPath
        self.title = movie.title
        self.releaseDate = movie.releaseDate
        self.overview = movie.overview
        self.genres = Array(movie.genres).joined(separator: ", ")
    }
}
