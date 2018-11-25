//
//  Movie.swift
//  Movs
//
//  Created by Julio Brazil on 21/11/18.
//  Copyright © 2018 Julio Brazil. All rights reserved.
//

import Foundation

struct CodableMovie: Codable {
    var poster_path: String?
    var adult: Bool
    var overview: String
    var release_date: String
    var genre_ids: [Int]
    var id: Int
    var original_title: String
    var original_language: String
    var title: String
    var backdrop_path: String?
    var popularity: Double
    var vote_count: Int
    var video: Bool
    var vote_average: Double
}

public struct Movie {
    var id: Int
    var poster_path: String
    var title: String
    var release_date: String
    var genre_names: String
    var overview: String
    
    init(from movie: CodableMovie) {
        self.id = movie.id
        self.poster_path = movie.poster_path ?? ""
        self.title = movie.title
        self.release_date = movie.release_date
        self.genre_names = ""
        self.overview = movie.overview
    }
    
    init(fromMovie movie: MovieEntity) {
        self.id = Int(movie.id)
        self.poster_path = movie.posterPath ?? ""
        self.title = movie.title ?? ""
        self.release_date = movie.releaseDate ?? ""
        self.genre_names = movie.genre ?? ""
        self.overview = movie.overview ?? ""
    }
}
