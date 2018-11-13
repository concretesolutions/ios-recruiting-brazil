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
    var poster_path: String
    var original_language: String
    var original_title: String
    var genre_ids: [Int]
    var backdrop_path: String?
    var adult: Bool
    var overview: String
    var release_date: String
}
