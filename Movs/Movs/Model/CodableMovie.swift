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
