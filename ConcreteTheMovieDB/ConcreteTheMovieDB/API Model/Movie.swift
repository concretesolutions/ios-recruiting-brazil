//
//  Movie.swift
//  ConcreteTheMovieDB
//
//  Created by Guilherme Gatto on 13/11/18.
//  Copyright © 2018 Guilherme Gatto. All rights reserved.
//

import Foundation

struct Movie: DataProtocol {
    var vote_count: Int
    var id: Double
    var video: Bool
    var vote_average: Double
    var title: String
    var popularity: Double
    var poster_path: String?
    var original_language: String
    var original_title: String
    var genre_ids: [Int]
    var backdrop_path: String?
    var adult: Bool
    var overview: String
    var release_date: String
    
    init(vote_count: Int, id: Double, video: Bool, vote_average: Double, title: String, popularity: Double, poster_path: String, original_language: String, original_title: String, genre_ids: [Int], backdrop_path: String?, adult: Bool, overview: String, release_date: String) {
        self.vote_count = vote_count
        self.id = id
        self.video = video
        self.vote_average = vote_average
        self.title = title
        self.popularity = popularity
        self.poster_path = poster_path
        self.original_title = original_title
        self.genre_ids = genre_ids
        self.backdrop_path = backdrop_path
        self.adult = adult
        self.overview = overview
        self.release_date = release_date
        self.original_language = original_language
    }
}
