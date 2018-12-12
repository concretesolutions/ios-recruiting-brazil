//
//  Movie.swift
//  TheMovieDB
//
//  Created by Gustavo Quenca on 31/10/18.
//  Copyright © 2018 Quenca. All rights reserved.
//

import Foundation

class MovieArray: Codable {
    let movieScreen = [Movie]()
}

class GenreListResult: Codable {
    let genres: [Genre]
}

class Genre: Codable {
    let id: Int?
    let name: String?
}

class Movie: Codable {
    let page: Int?
    var results: [MovieListResult]?
    let total_results: Int?
    let total_pages: Int?
  //  var isFavorite: Bool
}

struct MovieListResult: Codable {
    let poster_path: String?
    let adult: Bool?
    let overview: String?
    let release_date: String?
    let genre_ids: [Int]?
    let id: Int?
    let original_title: String?
    let original_language: String?
    let title: String?
    let backdrop_path: String?
    let popularity: Double?
    let vote_count: Int?
    let video: Bool?
    let vote_average:Double?
}

