//
//  Movie.swift
//  Movs
//
//  Created by Ygor Nascimento on 19/04/19.
//  Copyright © 2019 Ygor Nascimento. All rights reserved.
//

import Foundation

struct Movie: Codable {
    var page: Int
    var total_results: Int
    var total_pages: Int
    var results: [Results]
}

struct Results: Codable {
    var vote_count: Int
    var id: Int
    var video: Bool
    var vote_average: Double
    var title: String
    var popularity: Double
    var poster_path: String
    var original_title: String
    var genre_ids: [Int]
    var backdrop_path: String
    var adult: Bool
    var overview: String
    var release_date: String
}

struct GenreIds: Codable {
    var genreIds: [Int]
}
