//
//  Movie.swift
//  MoviesApp
//
//  Created by Eric Winston on 8/15/19.
//  Copyright © 2019 Eric Winston. All rights reserved.
//



struct Populares: Codable{
    var page: Int
    var results: [Movie]?
    var total_results: Int
    var total_pages: Int
}


//Movie in the API
class Movie: Codable{
    let poster_path: String?
    var adult: Bool
    var overview: String
    var release_date: String
    var genre_ids: [Int]
    let id: Int
    var original_title: String
    var original_language: String
    var title: String
    var backdrop_path: String?
    var popularity: Double
    var vote_count: Int
    var video: Bool
    var vote_average: Double
}


