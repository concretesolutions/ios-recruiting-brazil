//
//  Filmes.swift
//  moviesApp
//
//  Created by Victor Vieira Veiga on 04/12/19.
//  Copyright © 2019 Victor Vieira Veiga. All rights reserved.
//



import Foundation

struct Api: Codable {
    var page: Int
    var total_results: Int
    var total_pages: Int
    var results: [Movie]
}

struct Movie: Codable {
    var vote_count: Int
    var id: Int
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

struct Genre: Codable {
    var genres: [GenreData]
}

struct GenreData: Codable {
    var id: Int
    var name: String?
}

